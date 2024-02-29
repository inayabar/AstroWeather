//
//  RoundedTranslucentBox.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 29/02/2024.
//

import SwiftUI

struct RoundedTranslucentBox<Content> : View where Content : View {
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.4))
                .blur(radius: 1)
            
            content()
        }
    }
}

#Preview {
    RoundedTranslucentBox {
        Text("Some text")
    }
    .frame(width: 100, height: 100)
}
