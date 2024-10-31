//
//  SkewedRectangle.swift
//  LucraCodingChallenge
//
//  Created by Christopher Guirguis on 10/31/24.
//

import SwiftUI

struct SkewedRectangle: Shape {
    let topFraction: CGFloat
    let bottomFraction: CGFloat
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX + (rect.width * bottomFraction), y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX + (rect.width * topFraction), y: rect.minY))

        return path
    }
}
