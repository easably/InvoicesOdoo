//
//  ItemDetaislView.swift
//  InvoicesOdoo
//
//  Created by taqtile on 19.09.24.
//

import SwiftUI

struct ItemDetailView: View {
    var title: String
    var value: String
    var body: some View {
        HStack{
            HStack{
                Text(title)
                Spacer()
            }
            .frame(width: 170)
            Text(value)
                .font(.headline)
        }
        Divider()
    }
}

#Preview {
    ItemDetailView(title: "Customer", value: "Apple")
}
