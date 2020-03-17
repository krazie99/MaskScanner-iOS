//
//  ContentView.swift
//  MaskScanner
//
//  Created by Sean Choi on 2020/03/12.
//  Copyright © 2020 Sean Choi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    enum MapType {
        case kakao
        case naver
        case google
    }
    
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
            Button(action: { }) { Text("") }.sheet(isPresented: $viewModel.hasSelectedAnnotations) {
                MaskStoreListView(stores: self.viewModel.selectedStores, selectedStore: self.$viewModel.selectedStore)
                    .onDisappear() {
                        self.viewModel.hasSelectedAnnotation = self.viewModel.selectedStore != nil
                        if self.viewModel.selectedStore == nil {
                            self.clearSelectedAnnotation()
                        }
                }
            }
        }
        .actionSheet(isPresented: $viewModel.hasSelectedAnnotation, content: { () -> ActionSheet in
            let store = self.viewModel.selectedStore
            let title = Text(store?.name ?? "")
            let subTitle = Text(store?.remainText ?? "")
            return ActionSheet(title: title, message: subTitle, buttons: [
                .default(Text("카카오맵 길찾기"), action: {
                    print("카카오맵")
                    self.moveToFindTheWay(with: store, type: .kakao)
                }),
                .default(Text("네이버맵 길찾기"), action: {
                    print("네이버맵")
                    self.moveToFindTheWay(with: store,type: .naver)
                }),
                .destructive(Text("취소"), action: {
                    self.clearSelectedAnnotation()
                })
            ])
        })
    }
}

extension ContentView {
    ///Path to device settings if location is disabled
    func goToDeviceSettings() {
        guard let url = URL.init(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func moveToFindTheWay(with store: MaskStore?, type: MapType) {
        guard let store = store, let regionTuple = self.viewModel.regionTuple else { return }
        
        var urlString: String?
        if type == .kakao {
            urlString = "daummaps://route?sp=\(regionTuple.lati),\(regionTuple.lng)&ep=\(store.latitude),\(store.longitude)&by=FOOT"
        } else if type == .naver {
            let tempUrl = "nmap://route/walk?slat=\(regionTuple.lati)&slng=\(regionTuple.lng)&sname=현위치&dlat=\(store.latitude)&dlng=\(store.longitude)&dname=\(store.name)&appname=dev.letsean.mask"
            urlString = tempUrl.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)
        }
        
        if let urlString = urlString, let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:])
        }
        
        clearSelectedAnnotation()
    }
    
    func clearSelectedAnnotation() {
        self.viewModel.selectedAnnotation = nil
        self.viewModel.selectedAnnotations = nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
