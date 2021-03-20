//
//  FoodModel.swift
//  SampleCode
//
//  Created by Shinichiro Kudo on 2021/02/28.
//

import Foundation

// Foodを定義
struct Food: Codable {
    
    let name: String
    let price: Int
    let image: String
    
    static func createEmpty() -> Food {
        return Food(name: "", price: 0, image: "")
    }
    
    static func createDefaultFoods() -> [Food] {

        let arr = [
            Food(name: "Apple", price: 200, image: "Apple"),
            Food(name: "Orange", price: 120 ,image: "Orange"),
            Food(name: "Banana", price: 65 ,image: "Banana"),
            Food(name: "Grape", price: 400 ,image: "Grape"),
            Food(name: "Strawberry", price: 600 ,image: "Strawberry"),
            Food(name: "Chocolate", price: 100 ,image: "Chocolate"),
            Food(name: "Candy", price: 20 ,image: "Candy"),
            Food(name: "Biscuit", price: 70 ,image: "Biscuit"),
            Food(name: "Water", price: 100 ,image: "Water"),
            Food(name: "Tea", price: 200 ,image: "Tea"),
            Food(name: "Cola", price: 150 ,image: "Cola"),
            Food(name: "Beer", price: 300 ,image: "Beer"),
            Food(name: "Wine", price: 500 ,image: "Wine")
        ]

        return arr
    }
    
}

//let jsonStr = """
//    [
//        { "name": "Apple",      "price": 200,   "image": "Apple" },
//        { "name": "Orange",     "price": 120,   "image": "Orange" },
//        { "name": "Banana",     "price": 65,    "image": "Banana" },
//        { "name": "Grape",      "price": 400,   "image": "Grape" },
//        { "name": "Strawberry", "price": 600,   "image": "Strawberry" },
//        { "name": "Chocolate",  "price": 100,   "image": "Chocolate" },
//        { "name": "Candy",      "price": 20,    "image": "Candy" },
//        { "name": "Biscuit",    "price": 70,    "image": "Biscuit" },
//        { "name": "Water",      "price": 100,   "image": "Water" },
//        { "name": "Tea",        "price": 200,   "image": "Tea" },
//        { "name": "Cola",       "price": 150,   "image": "Cola" },
//        { "name": "Beer",       "price": 300,   "image": "Beer" },
//        { "name": "Wine",       "price": 500,   "image": "Wine" }
//    ]
//"""
//
//let jsonData = jsonStr.data(using: .utf8)  // json文字列をデータ型に変換
//// 受け取ったdataをJSONDecoder()のdecodeメソッドでswiftの形式に変換(struct) 変換先は配列型なので[Food].selfとしている
//let foods = try! JSONDecoder().decode([Food].self, from: jsonData!)
