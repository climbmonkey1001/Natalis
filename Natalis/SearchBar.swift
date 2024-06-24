//
//  SearchBar.swift
//  Natalis
//
//  Created by Laura Edwards on 19/04/2023.
//

import SwiftUI

struct SearchBar: View {
    @Binding var dates: [DatesInfo]
    @State private var searchText = ""
    
    var body: some View {
        
        List {
            
            if (searchText.isEmpty){
                HStack {
                    Text("Swipe down to reveal the search bar")
                    Spacer()
                    Image(systemName: "arrow.down")
                }
            }
            
//            //Remove this once the search bug thingy is fixed idk
//            HStack{
//                Text("Currently you can only view (not modify) these dates")
//                    .font(.caption)
////                Spacer()
////                Image(systemName: "exclamationmark.triangle.fill")
//            }
            
            
            ForEach($dates, id: \.id) { $date in
                if (date.title.lowercased().contains(searchText.lowercased())){
                    NavigationLink {
                        DetailView(thisDate: $date)
                    } label: {
                        Text(date.title)
                    }
                    
                    //when the user is searching
                }
                else {
                    if (searchText.isEmpty){
                        NavigationLink {
                            DetailView(thisDate: $date)
                        } label: {
                            Text(date.title)
                        }
                    }
                    
                    //if they aren't searching
                }
                
            }
            
            
        }
        .navigationTitle("Search for dates")
        .searchable(text: $searchText, prompt: "Search for a name")
        
        
    }
    
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchBar(dates: .constant(DatesInfo.sampleData))
        }
    }
}
