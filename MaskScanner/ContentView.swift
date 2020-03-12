//
//  ContentView.swift
//  MaskScanner
//
//  Created by Sean Choi on 2020/03/12.
//  Copyright © 2020 Sean Choi. All rights reserved.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var locations = [MKPointAnnotation]()
    
    @State var locationManager = CLLocationManager()
    @State var showMapAlert = false
    
    var body: some View {
        MapView(showMapAlert: $showMapAlert, annotations: locations)
            .alert(isPresented: $showMapAlert) {
                Alert(title: Text("Location access denied"),
                      message: Text("Your location is needed"),
                      primaryButton: .cancel(),
                      secondaryButton: .default(Text("Settings"),
                                                action: {
                                                    self.goToDeviceSettings()
                      }))
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
