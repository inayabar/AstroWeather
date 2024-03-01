//
//  SkeletonRectangle.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 29/02/2024.
//

import SwiftUI

struct SkeletonRectangle: View {
    @State private var isBlinking = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.gray.opacity(0.5))
            .frame(width: 100, height: 20)
            .opacity(isBlinking ? 0.3 : 1)
            .animation(.easeInOut(duration: 0.8).repeatForever(), value: isBlinking)
            .onAppear {
                isBlinking.toggle()
            }
    }
}

#Preview {
    SkeletonRectangle()
}
