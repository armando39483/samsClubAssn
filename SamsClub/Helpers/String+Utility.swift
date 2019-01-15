//
//  String+Utility.swift
//  SamsClub
//
//  Created by Armando Gonzalez on 12/22/18.
//  Copyright © 2018 Armando Gonzalez. All rights reserved.
//

import UIKit

extension String {
    
    /**
     This function is used to take the string, including html tags, that contains the description, and turn it into an NSAttributedSring.
     - Parameter self: This a string containing html tags.
     - Returns: An optional NSAttributedString
     */
    func convertToAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: .utf8) else { return nil }
        do {
            let options: [NSMutableAttributedString.DocumentReadingOptionKey:Any] = [.documentType: NSAttributedString.DocumentType.html,
                                                                                     .characterEncoding: String.Encoding.utf8.rawValue]
            let font = UIFont.systemFont(ofSize: 17.0)
            let attributed = try NSMutableAttributedString(data: data,
                                                           options: options,
                                                           documentAttributes: nil)
            attributed.addAttributes([.font : font],
                                     range: NSMakeRange(0, attributed.length))
            return attributed
        } catch {
            return NSAttributedString()
        }
    }
}


