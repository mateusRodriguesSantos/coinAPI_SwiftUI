//
//  mbSwiftUIApp.swift
//  mbSwiftUI
//
//  Created by Mateus Rodrigues on 05/06/23.
//

import SwiftUI

@main
struct mbSwiftUIApp: App {
    
    @StateObject var viewModelList: ViewModel = ViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModelList)
                .ignoresSafeArea()
                .onAppear {
                    Task {
                        viewModelList.getMetadata()
                    }
                }
        }
    }
}
