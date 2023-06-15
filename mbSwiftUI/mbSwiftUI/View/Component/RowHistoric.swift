//
//  RowHistoric.swift
//  mbSwiftUI
//
//  Created by Mateus Rodrigues on 13/06/23.
//

import SwiftUI

struct RowHistoric: View {
    
    var text: String = "text"
    var type: String = "type"
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(text)
                .fontWeight(.medium)
                .font(.headline)
            Text(type)
        }
        .padding(.inset([.top(number: 8), .bottom(number: 8), .horizontal(number: 20)]))
        
    }
}

struct RowHistoric_Previews: PreviewProvider {
    static var previews: some View {
        RowHistoric()
    }
}
