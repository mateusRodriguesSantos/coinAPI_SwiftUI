//
//  DispatchQueueFake.swift
//  mbSwiftUITests
//
//  Created by Mateus Rodrigues on 15/06/23.
//

import Foundation
@testable import mbSwiftUI

struct DispatchQueueFake: DispatchQueueTypeProtocol {
    
    func main_async(completion: @escaping (() -> Void)) {
        completion()
    }
}
