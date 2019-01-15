//
//  ImageCache.swift
//  SamsClub
//
//  Created by Armando Gonzalez on 12/18/18.
//  Copyright © 2018 Armando Gonzalez. All rights reserved.
//

import UIKit

struct ImageCache {
    
    private static let assetCache = NSCache<NSString, NSData>()
    
    private init() {}
    
    static func saveAsset(identifier: String, data: Data) {
        ImageCache.assetCache.setObject(NSData(data: data), forKey: identifier as NSString)
    }
    
    static func getAsset(identifier: String) -> Data? {
        if let data = ImageCache.assetCache.object(forKey: identifier as NSString) {
            return Data(referencing: data)
        } else {
            return nil
        }
    }
}
