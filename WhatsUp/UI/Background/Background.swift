//
//  Background.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 26.12.2020.
//

import SwiftUI

struct Background: View {
    static let triangleCount = 8
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: .init(colors: [Self.gradientStart, Self.gradientEnd]),
                        startPoint: .init(x: 0.5, y: 0),
                        endPoint: .init(x: 0.5, y: 1)
                    )
                )
                .ignoresSafeArea(.all)
            
            VStack {
                Spacer()
                
                GeometryReader { geometry in
                    ForEach(0..<Self.triangleCount) { i in
                        let scale = CGFloat.random(in: 0.25...1)
                        let red = Double.random(in: 100...140)
                        let green = Double.random(in: 120...140)
                        let blue = Double.random(in: 180...210)
                        
                        Triangle(
                            color: Color(
                                red: red / 255.0,
                                green: green / 255,
                                blue: blue / 255)
                        )
                        .scaleEffect(CGSize(width: scale, height: scale), anchor: .bottom)
                        .position(
                            x: ((geometry.size.width) / CGFloat(Self.triangleCount - 1)) * CGFloat(i),
                            y: geometry.size.height
                        )
                    }
                }
            }
        }
    }
    
    static let gradientStart = Color(
        red: 147 / 255,
        green: 170 / 255,
        blue: 255 / 255
    )
    
    static let gradientEnd = Color(
        red: 255 / 255,
        green: 172 / 255,
        blue: 172 / 255
    )
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        Background()
    }
}
