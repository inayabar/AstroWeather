//
//  CompassView.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 29/02/2024.
//

import SwiftUI

struct CompassView: View {
    let directionDegrees: Double
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                Text("N")
                    .font(.callout)
                HStack {
                    Text("E")
                        .font(.callout)
                    Image(systemName: "arrow.up")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .rotationEffect(.degrees(directionDegrees))
                        
                    Text("O")
                        .font(.callout)
                }
                Text("S")
                    .font(.callout)
            }
            
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .butt, lineJoin: .miter, miterLimit: 0, dash: [1, 3], dashPhase: 0))
        }
    }
}

#Preview {
    CompassView(directionDegrees: 80)
        .frame(width: 80, height: 80)
}
