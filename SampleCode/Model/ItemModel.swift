//
//  FoodModel.swift
//  SampleCode
//
//  Created by Shinichiro Kudo on 2021/02/28.
//

import Foundation

// Foodを定義
struct Item {
    
    let name: String
    let price: Int
    let image: String
    
    //var isEmpty: Bool
    
    static func createEmpty() -> Item {
        return Item(name: "", price: 0, image: "")
    }
    
    static func createDefaultItems() -> [Item] {

        let arr = [
            Item(name: "Apple", price: 200, image: "Apple"),
            Item(name: "Orange", price: 120 ,image: "Orange"),
            Item(name: "Banana", price: 65 ,image: "Banana"),
            Item(name: "Grape", price: 400 ,image: "Grape"),
            Item(name: "Strawberry", price: 600 ,image: "Strawberry"),
            Item(name: "Chocolate", price: 100 ,image: "Chocolate"),
            Item(name: "Candy", price: 20 ,image: "Candy"),
            Item(name: "Biscuit", price: 70 ,image: "Biscuit"),
            Item(name: "Water", price: 100 ,image: "Water"),
            Item(name: "Tea", price: 200 ,image: "Tea"),
            Item(name: "Cola", price: 150 ,image: "Cola"),
            Item(name: "Beer", price: 300 ,image: "Beer"),
            Item(name: "Wine", price: 500 ,image: "Wine")
        ]

        return arr
    }
    
}
