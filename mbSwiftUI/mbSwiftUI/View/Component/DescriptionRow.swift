//
//  DescriptionRow.swift
//  mbSwiftUI
//
//  Created by Mateus Rodrigues on 13/06/23.
//

import SwiftUI

struct DescriptionRow: View {
    var title: String = "Title"
    var description: String = "Description"
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    
                Text(description)
            }
            Spacer()
        }.padding(.inset([.top(number: 8), .bottom(number: 8), .horizontal(number: 20)]))
    }
}

struct RowDescription_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionRow()
    }
}
