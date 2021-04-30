//
//  FoodModel.swift
//  SampleCode
//
//  Created by Shinichiro Kudo on 2021/02/28.
//

import Foundation

struct Item {
    
    let type: genre
    let name: String
    let price: Int
    let image: String
    
    enum genre: String, CaseIterable {
        case all = "All", fruits = "fruits", sweets = "sweets", drinks = "drink", none = ""
    }
    
    static func createEmpty() -> Item {
        return Item(type: .none, name: "", price: 0, image: "")
    }
    
    static func createDefaultItems() -> [Item] {

        let arr = [
            Item(type: .fruits, name: "Apple", price: 200, image: "Apple"),
            Item(type: .fruits, name: "Orange", price: 120 ,image: "Orange"),
            Item(type: .fruits, name: "Banana", price: 65 ,image: "Banana"),
            Item(type: .fruits, name: "Grape", price: 400 ,image: "Grape"),
            Item(type: .fruits, name: "Strawberry", price: 600 ,image: "Strawberry"),
            Item(type: .sweets, name: "Chocolate", price: 100 ,image: "Chocolate"),
            Item(type: .sweets, name: "Candy", price: 20 ,image: "Candy"),
            Item(type: .sweets, name: "Biscuit", price: 70 ,image: "Biscuit"),
            Item(type: .drinks, name: "Water", price: 100 ,image: "Water"),
            Item(type: .drinks, name: "Tea", price: 200 ,image: "Tea"),
            Item(type: .drinks, name: "Cola", price: 150 ,image: "Cola"),
            Item(type: .drinks, name: "Beer", price: 300 ,image: "Beer"),
            Item(type: .drinks, name: "Wine", price: 500 ,image: "Wine")
        ]

        return arr
    }
    
    static func createSegmentArray() -> [String] {
        let arrStr = genre.allCases.filter { genre in !genre.rawValue.isEmpty }.map { (arr) -> String in arr.rawValue }
        return arrStr
    }
    
}
