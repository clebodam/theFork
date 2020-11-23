//
//  AttributedString+helpers.swift
//  theFork
//
//  Created by Damien on 23/11/2020.
//

import Foundation
import UIKit

extension NSAttributedString {
    static func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString
    {
        let result = NSMutableAttributedString()
        result.append(left)
        result.append(right)
        return result
    }
}
