//
//  ContentView.swift
//  MaskScanner
//
//  Created by Sean Choi on 2020/03/12.
//  Copyright © 2020 Sean Choi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = MaskStoresViewModel()
    
    var body: some View {
        ZStack {
            //다음맵뷰
            //SMTMapView(viewModel: viewModel, annotations: $viewModel.annotations)
            //MKMapView
            SMKMapView(viewModel: viewModel, annotations: $viewModel.annotations)
                .alert(isPresented: $viewModel.showMapAlert) {
                    Alert(title: Text("Location access denied"),
                          message: Text("Your location is needed"),
                          primaryButton: .cancel(),
                          secondaryButton: .default(Text("Settings"),
                                                    action: {
                                                        self.goToDeviceSettings()
                          }))
            }
            .edgesIgnoringSafeArea(.all)
            //상태바
            VStack {
                Rectangle()
                    .frame(height: 30.0)
                    .foregroundColor(Color.bgColor)
                    .blur(radius: 20)
                Spacer()
            }
            .edgesIgnoringSafeArea(.top)
        }.onAppear() {
            print("ContentView appeared!")
            self.viewModel.requestMaskStoresByGeo()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    ///Path to device settings if location is disabled
    func goToDeviceSettings() {
        guard let url = URL.init(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
