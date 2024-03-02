//
//  WeatherInfoContainer.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 29/02/2024.
//

import SwiftUI

struct WeatherInfoContainer<Content> : View where Content : View {
    let title: String
    let systemImage: String
    let content: () -> Content
    
    var body: some View {
        RoundedTranslucentBox {
            VStack(alignment: .leading) {
                Label(LocalizedStringKey(title), systemImage: systemImage)
                    .font(.subheadline)
                    .padding(.bottom)
                
                content()
            }
            .padding()
        }
    }
}

#Preview {
    WeatherInfoContainer(title: "Example", systemImage: "clipboard", content: {
        Text("Some content")
    })
    .frame(width: 200, height: 100)
}
