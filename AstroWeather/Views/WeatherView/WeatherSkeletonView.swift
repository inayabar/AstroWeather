//
//  WeatherSkeletonView.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 29/02/2024.
//

import SwiftUI

struct WeatherSkeletonView: View {
    let location: Location
    
    var body: some View {
        VStack(alignment: .center) {
            Text(location.name)
                .font(.title)
            
            SkeletonRectangle()
        
            SkeletonRectangle()
        }
        
        skeletonInfoView
        
        skeletonInfoView
        
        skeletonInfoView
    }
    
    var skeletonInfoView: some View {
        return HStack(spacing: 32) {
            RoundedTranslucentBox {
                VStack {
                    SkeletonRectangle()
                    SkeletonRectangle()
                }
            }
            
            RoundedTranslucentBox {
                VStack {
                    SkeletonRectangle()
                    SkeletonRectangle()
                }
            }
        }
        .frame(height: 100)
        .padding()
    }
}

#Preview {
    WeatherSkeletonView(location: MockLocation.london)
}
