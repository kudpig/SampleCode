//
//  TitleModel.swift
//  SampleCode
//
//  Created by Shinichiro Kudo on 2021/04/24.
//

import Foundation

struct Title {
    let name: String
    
    static func createTitles() -> [Title] {
        
        let defaultTitles = [
            Title(name: "1st"),
            Title(name: "2nd"),
            Title(name: "3rd"),
            Title(name: "4th"),
            Title(name: "5th"),
            Title(name: "6th"),
            Title(name: "7th"),
            Title(name: "8th"),
        ]
        
        return defaultTitles
    }
}
