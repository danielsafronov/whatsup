//
//  Triangle.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 27.12.2020.
//

import SwiftUI

struct Triangle: View {
    let color: Color
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let middle = width * 0.5
            
            Path { path in
                path.addLines([
                    CGPoint(x: 0, y: height),
                    CGPoint(x: middle, y: 0),
                    CGPoint(x: width, y: height),
                    CGPoint(x: 0, y: height),
                ])
            }
            .fill(color)
        }
        .frame(width: 100.0, height: 100.0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct Triangle_Previews: PreviewProvider {
    static var previews: some View {
        Triangle(color: Color(red: 79.0 / 255, green: 79.0 / 255, blue: 191.0 / 255))
    }
}
