//
//  NatalisApp.swift
//  Natalis
//
//  Created by Laura Edwards on 22/02/2023.
//

import SwiftUI

@main
struct NatalisApp: App {
    @StateObject private var store = DatesStore()
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            DatesView(dates: $store.dates) {
                Task {
                    do {
                        try await store.save(dates: store.dates)
                    } catch {
                        errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                    }
                }
            }
            .task{
                do {
                    try await store.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error, guidance: "Natalis will load sample data and continue.")
                }
            }
            .sheet(item: $errorWrapper) {
                store.dates = DatesInfo.sampleData
            } content: { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
        }
    }
}
