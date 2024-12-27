//
//  Product.swift
//  SweaterShopApp
//
//  Created by Stephanie Diep on 2021-12-23.
//

import Foundation
import FirebaseDatabase

struct Product: Identifiable {
    var id = UUID()
    var name: String
    var image: String
    var price: Int
}

var productList = [Product(name: "Luxury Swedian chair", image: "chair_1", price: 54),
                   Product(name: "New Swedian chair", image: "chair_2", price: 89),
                   Product(name: "Swedian chair", image: "chair_3", price: 79),
                   Product(name: "Desk Table", image: "chair_5", price: 70),
                   Product(name: "Modern Tool", image: "chair_6", price: 40),
                   Product(name: "Comfi chair", image: "chair_7", price: 30),
                   Product(name: "Reading Table Set", image: "chair_8", price: 109),
                   Product(name: "Premium Sofa", image: "chair_9", price: 149),
                   Product(name: "Single Sofa", image: "chair_10", price: 79),
                   Product(name: "Steel Chair", image: "chair_11", price: 75),
                   Product(name: "Royal Sofa", image: "chair_12", price: 71),
                   Product(name: "Comfi Sofa", image: "chair_13", price: 120),
                   Product(name: "Swedian chair", image: "chair_14", price: 79),
                   Product(name: "Basic chair", image: "chair_15", price: 78),
                   Product(name: "Stand Chair", image: "chair_16", price: 56),
                   Product(name: "Office chair", image: "chair_17", price: 119),
                   Product(name: "Mirror chair", image: "chair_18", price: 89),
                   Product(name: "Purple chair", image: "chair_19", price: 29),
                   Product(name: "Round table", image: "chair_20", price: 150),
                   Product(name: "Chair", image: "chair_4", price: 94)]








