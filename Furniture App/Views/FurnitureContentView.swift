//
//  FurnitureContentView.swift
//  SweaterShopApp
//
//  Created by kuet on 16/11/23.
//

import SwiftUI

struct FurnitureContentView: View {
    @State private var search: String = ""
    @State private var selectedIndex: Int = 0
    private let categories = ["All", "Chair", "Sofa", "Lamp", "Kitchen", "Table"]
    @StateObject var cartManager = CartManager()
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    var body: some View {
        NavigationView {
            ScrollView {
                TagLineView()
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(productList, id: \.id) { product in
                        NavigationLink(destination: DetailScreen(img:product.image,name:product.name), label: {
                            ProductCard(product: product)
                                .environmentObject(cartManager)
                        })
                    }
                }
                .padding()
            }
            
            .navigationTitle(Text("Furniture Shop"))
            .toolbar {
                NavigationLink {
                    CartView()
                        .environmentObject(cartManager)
                } label: {
                    CartButton(numberOfProducts: cartManager.products.count)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
struct TagLineView: View {
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Text("Find the Best \nFurniture! ")
                .font(.custom("PlayfairDisplay-Regular", size: 28))
                .foregroundColor(Color(.brown))
                .alignmentGuide(.top, computeValue: { dimension in dimension[.top] })
            
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


struct FurnitureContentView_Previews: PreviewProvider {
    static var previews: some View {
        FurnitureContentView()
    }
}
