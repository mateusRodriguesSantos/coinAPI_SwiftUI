//
//  DispatchQueue+Extensions.swift
//  mbSwiftUI
//
//  Created by Mateus Rodrigues on 11/06/23.
//

import Foundation

struct DispatchQueueType: DispatchQueueTypeProtocol {
    
}

public protocol DispatchQueueTypeProtocol {
    func main_async(completion: @escaping (() -> Void))
}

extension DispatchQueueType {
    public func main_async(completion: @escaping (() -> Void)) {
        DispatchQueue.main.async(execute: completion)
    }
}
