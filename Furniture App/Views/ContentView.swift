//
//  ContentView.swift
//  SweaterShopApp
//
//  Created by Stephanie Diep on 2021-12-23.
//

import SwiftUI

struct ContentView: View {
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
//struct TagLineView: View {
//    var body: some View {
//        HStack(alignment: .top, spacing: 0) {
//            Text("Find the \nFurniture! ")
//                .font(.custom("PlayfairDisplay-Regular", size: 28))
//                .foregroundColor(Color(.black))
//                .alignmentGuide(.top, computeValue: { dimension in dimension[.top] })
//
//            Text("Best")
//                .font(.custom("PlayfairDisplay-Bold", size: 28))
//                .fontWeight(.bold)
//                .foregroundColor(Color(.black))
//        }
//        .padding()
//        .frame(maxWidth: .infinity, alignment: .leading)
//    }
//}


//struct CategoryView: View {
//    let isActive: Bool
//    let text: String
//    var body: some View {
//        VStack (alignment: .leading, spacing: 0) {
//            Text(text)
//                .font(.system(size: 18))
//                .fontWeight(.medium)
//                .foregroundColor(isActive ? Color(.black) : Color.black.opacity(0.5))
//            if (isActive) { Color(.blue)
//                .frame(width: 15, height: 2)
//                .clipShape(Capsule())
//            }
//        }
//        .padding(.trailing)
//    }
//}
//struct SearchAndScanView: View {
//    @Binding var search: String
//    var body: some View {
//        HStack {
//            HStack {
//                Image("Search")
//                    .padding(.trailing, 8)
//                TextField("Search Furniture", text: $search)
//            }
//            .padding(.all, 20)
//            .background(Color.white)
//            .cornerRadius(10.0)
//            .padding(.trailing, 8)
//            
//            Button(action: {}) {
//                Image("Scan")
//                    .padding()
//                    .background(Color("Primary"))
//                    .cornerRadius(10.0)
//            }
//        }
//        .padding(.horizontal)
//    }
//}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
