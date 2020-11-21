//
//  UIview+reuseIdentifier.swift
//  theFork
//
//  Created by Damien on 20/11/2020.
//

import Foundation

protocol ReuseIdentifierProtocol {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifierProtocol {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
        }
}
