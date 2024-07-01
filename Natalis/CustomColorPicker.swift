//
//  CustomColorPicker.swift
//  Natalis
//
//  Created by Laura Edwards on 08/03/2023.
//

import SwiftUI

struct CustomColorPicker: View {
    @Binding var selectedColor: Color
    let colors: [Color] = [Color("Blue"), Color("Green"), Color("Yellow"), Color("Purple"), Color("Pink")]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(colors, id: \.self) { color in
                            Button(action: {
                                self.selectedColor = color
                            }) {
                                Circle()
                                    .fill(color)
                                    .frame(width: 50, height: 50)
                                    .overlay(
                                        Circle()
                                            .stroke(Color("DarkToLight"), lineWidth: self.selectedColor == color ? 3 : 0)
                                    )
                            }
                        }
                    }
                    .padding()
                }
    }
}

