//
//  Line.swift
//  9in.team
//
//  Created by 조상현 on 2023/02/27.
//

import SwiftUI

struct Line: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
    
}
