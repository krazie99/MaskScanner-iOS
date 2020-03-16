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
            //SMTMapView(annotations: $viewModel.annotations, viewModel: viewModel)
            //MKMapView
            SMKMapView(annotations: $viewModel.annotations, viewModel: viewModel)
                .alert(isPresented: $viewModel.showMapAlert) {
                    Alert(title: Text("Location access denied"),
                          message: Text("Your location is needed"),
                          primaryButton: .cancel(),
                          secondaryButton: .default(Text("Settings"),
                                                    action: {
                                                        self.goToDeviceSettings()
                          }))
            }.edgesIgnoringSafeArea(.all)
            VStack {
                //상태바
                Rectangle()
                    .frame(height: 30.0)
                    .foregroundColor(Color.bgColor)
                    .blur(radius: 20)
                Spacer().frame(height: 15.0)
                if viewModel.canRefresh {
                    Button(action: {
                        self.viewModel.requestMaskStoresByGeo()
                    }) {
                        HStack {
                            Image(systemName: "arrow.clockwise")
                                .font(.body)
                            Text("재검색")
                                .fontWeight(.semibold)
                                .font(.body)
                        }
                        .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                        .foregroundColor(Color.buttonTextColor)
                        .background(Color.bgColor)
                        .cornerRadius(40)
                    }
                }
                Spacer()
            }.edgesIgnoringSafeArea(.top)
            ActivityIndicator(isAnimating: $viewModel.isLoading, style: .large)
        }.onAppear() {
            print("ContentView appeared!")
        }
    }
}

extension ContentView {
    ///Path to device settings if location is disabled
    func goToDeviceSettings() {
        guard let url = URL.init(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
