//
//  CurrencyRow.swift
//  mbSwiftUI
//
//  Created by Mateus Rodrigues on 05/06/23.
//

import SwiftUI

struct CurrencyRow: View {
    var title: String = "Titulo"
    var describe: String = "Describe"
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text(title)
                    Spacer()
                }.padding(.inset(top: 8, bottom: 20))
                HStack {
                    Text("USDtoday")
                        .font(.system(size: 20))
                        .foregroundColor(.indigo)
                    Text(describe)
                        .font(.system(size: 15))
                        .foregroundColor(.blue)
                    Spacer()
                }
            }
        }
    }
}

