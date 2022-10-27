//
//  ComicStorage.swift
//  Cosmics_ShortCut
//
//  Created by Caroline Klakegg on 27/10/2022.
//

import Foundation

class ComicStorage{
    
    static var standard = ComicStorage()
    
    private var storage: UserDefaults = UserDefaults.standard
    
func dictionary(forKey key: String, defaultValue: [Int: Int] = [:]) -> [Int: Int] {
    
        let object = storage.object(forKey: key)
        if let val = object as? [String: Int] {
            
            var convertedVal: [Int: Int] = [:]
            for item in val {
                if let key = Int(item.key) {
                    convertedVal[key] = item.value
                }
            }
            
            return convertedVal
        }

        return defaultValue
    }

    func set(_ val: [Int: Int], forKey key: String) {
        var convertedVal: [String: Int] = [:]
        for item in val {
            convertedVal[String(item.key)] = item.value
        }

        storage.set(convertedVal, forKey: key)
    }
}
