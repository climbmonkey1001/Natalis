//
//  ContentView.swift
//  Natalis
//
//  Created by Laura Edwards on 22/02/2023.
//

import SwiftUI

struct CardView: View {
    let thisDate: DatesInfo
    
    var body: some View {
        HStack {
            VStack{
                
                let formatedMonth = thisDate.date.formatted(
                    .dateTime
                        .month()
                )
                
                //the month
                Text("\(formatedMonth)")
                    .font(.caption)
                
                let formatedDay = thisDate.date.formatted(
                    .dateTime
                        .day()
                )
                
                let day = "\(formatedDay)"
                
                //formats the day (so 4 = 04)
                if day.count == 1{
                    Text("0\(formatedDay)")
                } else {
                    Text(day)
                }
            }
            .padding(.trailing, 15)
            .accessibilityLabel("\(thisDate.date.formatted(.dateTime.day().month()))")
            Text(thisDate.title)
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
        }
        .padding()
            
    }
}

struct CardView_Previews: PreviewProvider {
    static var date = DatesInfo.sampleData[0]
    static var previews: some View {
        CardView(thisDate: date)
            .background(date.theme)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
