//
//  HistoryView.swift
//  Natalis
//
//  Created by Laura Edwards on 17/05/2023.
//

import SwiftUI

struct HistoryView: View {
    let history: History
    
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                Divider()
                    .padding(.bottom)
                
//                //Date
//                HStack{
//                    let formatedDate = history.date.formatted(
//                        .dateTime
//                            .day().month(.wide).year()
//                    )
//
//                    Text("Date: ")
//                        .font(.headline)
//                    Text("\(formatedDate)")
//                }
                
                //Ideas
                Text("Ideas: ")
                    .font(.headline)
                ForEach (history.ideas){idea in
                    Text(" - \(idea.ideaString)")
                }
            }
        }
        .navigationTitle(Text(history.date, style: .date))
        .padding()
    }
    
    
}

struct HistoryView_Previews: PreviewProvider {
    static var history: History {
        History(date: (try! Date("Apr 04, 2023", strategy: expectedFormat)), ideas: [DatesInfo.Idea(ideaString: "Chocolate"), DatesInfo.Idea(ideaString: "Crochet")])
    }
    static var previews: some View {
        HistoryView(history: history)
    }
}
