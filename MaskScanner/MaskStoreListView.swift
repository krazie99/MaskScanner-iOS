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
                Section(header: Text("")) {
                    ForEach(stores) { store in
                        Button(action: {
                            self.selectedStore = store
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack {
                                Text(store.name)
                                    .foregroundColor(.buttonTextColor)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.buttonTextColor)
                            }
                        }
                    }
                    .frame(height: 45)
                }
            }
            .listStyle(GroupedListStyle())
            .listRowBackground(Color.clear)
            .navigationBarTitle("판매처 선택")
        }
        
    }
}


struct MaskStoreListView_Previews: PreviewProvider {
    static var previews: some View {
        MaskStoreListView(stores: [], selectedStore: .constant(nil))
    }
}
