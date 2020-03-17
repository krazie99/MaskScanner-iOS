//
//  MaskStoreListView.swift
//  MaskScanner
//
//  Created by Sean Choi on 2020/03/17.
//  Copyright © 2020 Sean Choi. All rights reserved.
//

import SwiftUI

struct MaskStoreListView: View {
    
    @State var stores: [MaskStore]
    @Binding var selectedStore: MaskStore?
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(stores) { store in
                    Button(action: {
                        self.selectedStore = store
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Text(store.name)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }
                }
                .frame(height: 45)
            }
            .navigationBarTitle("판매처 선택")
        }
    }
}


struct MaskStoreListView_Previews: PreviewProvider {
    static var previews: some View {
        MaskStoreListView(stores: [], selectedStore: .constant(nil))
    }
}
