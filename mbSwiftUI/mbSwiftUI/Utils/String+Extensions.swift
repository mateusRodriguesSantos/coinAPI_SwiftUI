//
//  String+Extensions.swift
//  mbSwiftUI
//
//  Created by Mateus Rodrigues on 10/06/23.
//

import Foundation

extension String: Identifiable {
    public var id: Int {
        UUID().hashValue
    }
}

extension String {
    public static var empty: String {
        ""
    }
    
    public func substring(_ endIndex: Int) -> String {
        let index = self.index(self.startIndex, offsetBy: endIndex)
        return String(self[..<index])
    }
}
