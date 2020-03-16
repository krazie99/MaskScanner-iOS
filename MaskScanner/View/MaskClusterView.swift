//
//  MaskClusterView.swift
//  MaskScanner
//
//  Created by Sean Choi on 2020/03/16.
//  Copyright © 2020 Sean Choi. All rights reserved.
//

import MapKit

class MaskClusterView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        displayPriority = .defaultHigh
        collisionMode = .circle
        centerOffset = CGPoint(x: 0, y: -10) // Offset center point to animate better with marker annotations
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var annotation: MKAnnotation? {
        willSet {
            if let cluster = newValue as? MKClusterAnnotation {
                let renderer = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40))
                let count = cluster.memberAnnotations.count
                
                let plentyCount = cluster.memberAnnotations.filter { member -> Bool in
                    return (member as! MaskAnnotation).remainType == .plenty
                }.count
                
                let someCount = cluster.memberAnnotations.filter { member -> Bool in
                    return (member as! MaskAnnotation).remainType == .some
                }.count
                
                let fewCount = cluster.memberAnnotations.filter { member -> Bool in
                    return (member as! MaskAnnotation).remainType == .few
                }.count
                
//                let emptyCount = cluster.memberAnnotations.filter { member -> Bool in
//                    return (member as! MaskAnnotation).remainType == .empty
//                }.count
                
                let plentyColor = MaskRemainType.plenty.color
                let someColor = MaskRemainType.some.color
                let fewColor = MaskRemainType.few.color
                let emptyColor = MaskRemainType.empty.color
                
                image = renderer.image { _ in
                    emptyColor.setFill()
                    UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 40, height: 40)).fill()
                    
                    plentyColor.setFill()
                    let plentyEndAngle: CGFloat = (CGFloat.pi * 2.0 * CGFloat(plentyCount)) / CGFloat(count)
                    
                    let piePath = UIBezierPath()
                    piePath.addArc(withCenter: CGPoint(x: 20, y: 20), radius: 20,
                                   startAngle: 0, endAngle: plentyEndAngle,
                                   clockwise: true)
                    piePath.addLine(to: CGPoint(x: 20, y: 20))
                    piePath.close()
                    piePath.fill()
                    
                    someColor.setFill()
                    let someEndAngle: CGFloat = plentyEndAngle + (CGFloat.pi * 2.0 * CGFloat(someCount)) / CGFloat(count)

                    let piePath2 = UIBezierPath()
                    piePath2.addArc(withCenter: CGPoint(x: 20, y: 20), radius: 20,
                                   startAngle: plentyEndAngle, endAngle: someEndAngle,
                                   clockwise: true)
                    piePath2.addLine(to: CGPoint(x: 20, y: 20))
                    piePath2.close()
                    piePath2.fill()

                    fewColor.setFill()
                    let fewEndAngle: CGFloat = someEndAngle + (CGFloat.pi * 2.0 * CGFloat(fewCount)) / CGFloat(count)

                    let piePath3 = UIBezierPath()
                    piePath3.addArc(withCenter: CGPoint(x: 20, y: 20), radius: 20,
                                   startAngle: someEndAngle, endAngle: fewEndAngle,
                                   clockwise: true)
                    piePath3.addLine(to: CGPoint(x: 20, y: 20))
                    piePath3.close()
                    piePath3.fill()
                    
                    // Fill inner circle with white color
                    UIColor.white.setFill()
                    UIBezierPath(ovalIn: CGRect(x: 8, y: 8, width: 24, height: 24)).fill()
                    
                    // Finally draw count text vertically and horizontally centered
                    let attributes = [ NSAttributedString.Key.foregroundColor: UIColor.black,
                                       NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)]
                    let text = "\(count)"
                    let size = text.size(withAttributes: attributes)
                    let rect = CGRect(x: 20 - size.width / 2, y: 20 - size.height / 2, width: size.width, height: size.height)
                    text.draw(in: rect, withAttributes: attributes)
                }
            }
        }
    }
}
