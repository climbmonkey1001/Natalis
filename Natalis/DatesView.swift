//
//  DatesView.swift
//  Natalis
//
//  Created by Laura Edwards on 22/02/2023.
//

import SwiftUI


struct ContentView: View{
    @State var dates = [DatesInfo(title: "Negative", date: Date().addingTimeInterval(-234567), reccuring: true, theme: Color("Green"), ideas: []), DatesInfo(title: "Positive", date: Date().addingTimeInterval(234567), reccuring: true, theme: Color("Green"), ideas: [])]
    
    var body: some View {
        DatesView(dates: $dates, saveAction: {})
    }
}



struct DatesView: View {
    @Binding var dates: [DatesInfo]
    @Environment(\.scenePhase) private var scenePhase
    
    let nowDate = Date()
    @State private var dateComponent = DateComponents()
    
    
    var sortedDates: [DatesInfo] {
        dates.sorted {
            $0.date < $1.date
        }
        
    }
    
    let idk = true
    @State private var newDateUrMom = DatesInfo.Data()
    @State private var isPresentingNewDatesView = false
    @State private var isPresentingSearchView = false
    @State private var newDatesData = DatesInfo.Data()
    
    let saveAction: ()->Void
    
    var body: some View {
        
        NavigationStack {
            List{
                HStack{
                    ForEach(sortedDates) { thing in
                        Spacer()
                            .listRowBackground(Color("greyBackground"))
                    }
                    .onAppear {
                        updateDates()
                    }
                }
                .listRowBackground(Color("greyBackground"))
                ForEach(sortedDates, id: \.id) { date in
                    //Checks if the date isn't one of the expired non-reccuring dates
                    if (!(date.date.timeIntervalSince1970 < Calendar.current.startOfDay(for: Date()).timeIntervalSince1970 && !date.reccuring)){
                        
                        HStack {
                            CardView(thisDate: date)
                            Spacer()
                            Image(systemName: "chevron.forward")
                                .padding(.trailing)
                        }
                        .background(NavigationLink("", destination: DetailView(thisDate: $dates[dates.firstIndex(of: date)!])).opacity(0))
                        .background(RoundedRectangle(cornerRadius: 12).fill(date.theme))
                        .swipeActions{
                            Button (role: .destructive){
                                removeDates(date: date)
                            } label: {
                                //                            Label("Delete", systemImage: "trash.fill")
                                Image(systemName: "trash.fill")
                                    .foregroundColor(Color("AccentColor"))
                            }
                            .tint(Color("greyBackground"))
                        }
                        //.listRowBackground(date.theme)
                    }
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                // ^ this somehow turns it into seperated rectangles
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Your dates")
            .toolbar {
                NavigationLink(destination: SearchBar(dates: $dates)) {
                    Image(systemName: "magnifyingglass")
                }
                Button(action: { isPresentingNewDatesView = true}){
                    Image(systemName: "plus")
                }
                //            Button(action: {}){
                //                Image(systemName: "gift")
                //            }
            }
            .toolbarBackground(
                Color("LightToDark"),
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .sheet(isPresented: $isPresentingNewDatesView){
            NavigationView {
                DetailEditView(data: $newDatesData)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss"){
                                isPresentingNewDatesView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add"){
                                let newDateThing = DatesInfo(data: newDatesData)
                                dates.append(newDateThing)
                                isPresentingNewDatesView = false
                                newDatesData = DatesInfo.Data()
                            }
                        }
                    }
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
    
    
    func updateDates() {
        for i in dates.indices {
            if (Calendar.current.startOfDay(for: Date()).timeIntervalSince1970 > dates[i].date.timeIntervalSince1970) {
                if dates[i].reccuring,
                   let newDate = Calendar.current.date(byAdding: .year, value: 1, to: dates[i].date) {
                    
                    //making a new history value
                    let newHistory = History(date: dates[i].date, ideas: dates[i].ideas)
                    dates[i].history.insert(newHistory, at: 0)
                    
                    //Reseting the idea values
                    dates[i].ideas = []
                    
                    //updating the date
                    dates[i].date = newDate
                    
                }
            }
        }
    }
    
    func removeDates(date: DatesInfo){
        dates.remove(at: dates.firstIndex(of: date)!)
    }
}

struct DatesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DatesView(dates: .constant(DatesInfo.sampleData), saveAction: {})
        }
        
    }
}
