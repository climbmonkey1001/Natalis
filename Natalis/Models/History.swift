//
//  History.swift
//  Natalis
//
//  Created by Laura Edwards on 26/04/2023.
//

import Foundation

struct History: Identifiable, Hashable, Codable{
    let id: UUID
    let date: Date
    var ideas: [DatesInfo.Idea]
    
    init(id: UUID = UUID(), date: Date = Date(), ideas: [DatesInfo.Idea]){
        self.id = id
        self.date = date
        self.ideas = ideas
    }
}
