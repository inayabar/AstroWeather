//
//  ErrorSnackbar.swift
//  AstroWeather
//
//  Created by Iñaki Yabar Bilbao on 01/03/2024.
//

import SwiftUI

struct ErrorSnackbar: View {
    let errorMessage: String
    @Binding var isShowing: Bool
    let dismissAfter: TimeInterval
    
    var body: some View {
        VStack {
            Spacer()
            if isShowing {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.white)
                    Text(LocalizedStringKey(errorMessage))
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .lineLimit(2)
                }
                .padding()
                .background(Color.red)
                .cornerRadius(10)
                .padding()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + dismissAfter) {
                        withAnimation {
                            isShowing = false
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .bottom)
    }
}

#Preview {
    ErrorSnackbar(errorMessage: "Oops! There was an error. Please try again later", isShowing: .constant(true), dismissAfter: 3.0)
}
