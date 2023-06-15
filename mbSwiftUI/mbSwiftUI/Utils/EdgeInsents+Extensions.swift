//
//  EdgeInsents+Extensions.swift
//  mbSwiftUI
//
//  Created by Mateus Rodrigues on 10/06/23.
//

import SwiftUI

extension EdgeInsets {
    public enum Insets: Hashable {
        case top(number: CGFloat)
        case leading(number: CGFloat)
        case trailing(number: CGFloat)
        case bottom(number: CGFloat)
        case horizontal(number: CGFloat)
    }
    
    public static func inset(_ spaces: Set<Insets>) -> EdgeInsets {
        var edge: EdgeInsets = .init()
        spaces.forEach { inset in
            switch inset {
            case let .top(number):
                edge.top = number
            case let .leading(number):
                edge.leading = number
            case let .trailing(number):
                edge.trailing = number
            case let .bottom(number):
                edge.bottom = number
            case let .horizontal(number):
                edge.leading = number
                edge.trailing = number
            }
        }
        
        return edge
    }
    
    public static func inset(top: CGFloat, bottom: CGFloat) -> EdgeInsets {
        .init(top: top, leading: .zero, bottom: bottom, trailing: .zero)
    }
    
    public static func inset(bottomSpace bottom: CGFloat) -> EdgeInsets {
        .init(top: .zero, leading: .zero, bottom: bottom, trailing: .zero)
    }
    
    public static func inset(topSpace top: CGFloat) -> EdgeInsets {
        .init(top: top, leading: .zero, bottom: .zero, trailing: .zero)
    }
    
    public static func inset(leading: CGFloat, trailing: CGFloat) -> EdgeInsets {
        .init(top: .zero, leading: leading, bottom: .zero, trailing: trailing)
    }
}
