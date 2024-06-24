//
//  DatesStore.swift
//  Natalis
//
//  Created by Laura Edwards on 26/05/2023.
//

import SwiftUI

@MainActor
class DatesStore: ObservableObject {
    @Published var dates: [DatesInfo] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("dates.data")
    }
    
    func load() async throws{
        let task = Task<[DatesInfo], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let datesInfos = try JSONDecoder().decode([DatesInfo].self, from: data)
            return datesInfos
        }
        let dates = try await task.value
        self.dates = dates
        
    }
    
    func save(dates: [DatesInfo]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(dates)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
