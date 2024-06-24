//
//  DetailView.swift
//  Natalis
//
//  Created by Laura Edwards on 01/03/2023.
//

import SwiftUI

struct DetailView: View {
    @Binding var thisDate: DatesInfo
    
    @State private var exampleIdeas = ["Sweets", "Chocolate", "Cake"]
    
    @State private var theseIdeas: String = ""
    let nowDate = Date()
    
    @State private var data = DatesInfo.Data()
    
    @State private var isPresentingEditView = false
    
    var body: some View {
        List{
            
            Section(header: Text("")){
                
                let formatedDate = thisDate.date.formatted(
                    .dateTime
                        .day().month(.wide).year()
                )
                
                Text("Date: \(formatedDate)")
                
                
                let daysUntil = Calendar.current.dateComponents([.day], from: nowDate, to: thisDate.date).day!
                
                if daysUntil>1{
                    Text("\(daysUntil) days to go!")
                }
                else if daysUntil == 1{
                    Text("1 day to go!")
                }
                else if daysUntil == 0{
                    Text("It's today!")
                }
                else{
                    Text("This date is expired / in the past")
                }
            }

            Section(header: Text("Present Ideas: ")){

                ForEach($thisDate.ideas, id:\.id, editActions: .delete) { $idea in
                    TextField("Idea", text: $idea.ideaString)
                }
                
                HStack {
                    TextField("New idea", text: $theseIdeas)
                    Button(action: {
                        withAnimation{
                            let newIdea = DatesInfo.Idea(ideaString: theseIdeas)
                            thisDate.ideas.append(newIdea)
                            //exampleIdeas.append(theseIdeas)
                            theseIdeas = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(thisDate.theme)
                    }
                    .disabled(theseIdeas.isEmpty)
                }
            }
            
            if (thisDate.reccuring){
                
                Section(header: Text("History: ")){
                    if thisDate.history.isEmpty {
                        //Text("No history values yet")
                        Label("No history values yet", systemImage: "calendar.badge.exclamationmark")
                    }
                    
                    ForEach(thisDate.history) {history in
                        NavigationLink(destination: HistoryView(history: history)){
                            HStack{
                                Image(systemName: "calendar")
                                Text(history.date, style: .date)
                            }
                        }
                        //                    HStack{
                        //                        Image(systemName: "calendar")
                        //                        Text(history.date, style: .date)
                        //                    }
                    }
                }
            }
        }
        .navigationTitle(thisDate.title)
        .toolbarBackground(
            thisDate.theme,
                        for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar{
            Button("Edit"){
                isPresentingEditView = true
                data = thisDate.data
            }
        }
        .sheet(isPresented: $isPresentingEditView){
            NavigationView{
                DetailEditView(data: $data)
                    .navigationTitle(thisDate.title)
                    .toolbar{
                        ToolbarItem(placement: .cancellationAction){
                            Button("Cancel"){
                                isPresentingEditView = false
                            }
                        }
                        
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                thisDate.update(from: data)
                            }
                        }
                    }
            }
        }
        
//        List($exampleIdeas, id:\.self, editActions: .delete) { $idea in
//
//
//            TextField("Ideas", text: $idea)
//        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DetailView(thisDate: .constant(DatesInfo.sampleData[0]))
        }
    }
}
