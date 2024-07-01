//
//  DatesInfo.swift
//  Natalis
//
//  Created by Laura Edwards on 22/02/2023.
//

import Foundation
import SwiftUI
let Formatter = DateFormatter()
let expectedFormat = Date.FormatStyle()
    .month().year().day()

struct DatesInfo: Identifiable, Hashable, Codable {
    
    let id: UUID
    var title: String
    var date: Date
    var reccuring: Bool
    var theme: Color
    var ideas: [Idea]
    var history: [History] = []
    
    init(id: UUID = UUID(), title: String, date: Date, reccuring: Bool, theme: Color, ideas: [String]){
        self.id = id
        self.title = title
        self.date = date
        self.reccuring = reccuring
        self.theme = theme
        self.ideas = ideas.map {Idea(ideaString: $0)}
    }
    
}


extension DatesInfo{
    struct Idea: Identifiable, Hashable, Codable {
        let id: UUID
        var ideaString: String
        
        init(id: UUID = UUID(), ideaString: String) {
            self.id = id
            self.ideaString = ideaString
        }
    }
        
    struct Data {
        var title: String = ""
        var date: Date = Date()
        var reccuring: Bool = false
        var theme: Color = Color("Green")
        var ideas: [Idea] = []
    }
    
    var data: Data {
        Data(title: title, date: date, reccuring: reccuring, theme: theme, ideas: ideas)
    }
    
    mutating func update(from data: Data){
        title = data.title
        date = data.date
        reccuring = data.reccuring
        theme = data.theme
    }
    
    init(data: Data) {
        id = UUID()
        title = data.title
        date = data.date
        reccuring = data.reccuring
        theme = data.theme
        ideas = data.ideas
    }
}




extension Color: Codable {
  init(hex: String) {
    let rgba = hex.toRGBA()
    
    self.init(.sRGB,
              red: Double(rgba.r),
              green: Double(rgba.g),
              blue: Double(rgba.b),
              opacity: Double(rgba.alpha))
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let hex = try container.decode(String.self)
    
    self.init(hex: hex)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(toHex)
  }
  
  var toHex: String? {
    return toHex()
  }
  
  func toHex(alpha: Bool = false) -> String? {
    guard let components = cgColor?.components, components.count >= 3 else {
      return nil
    }
    
    let r = Float(components[0])
    let g = Float(components[1])
    let b = Float(components[2])
    var a = Float(1.0)
    
    if components.count >= 4 {
      a = Float(components[3])
    }
    
    if alpha {
      return String(format: "%02lX%02lX%02lX%02lX",
                    lroundf(r * 255),
                    lroundf(g * 255),
                    lroundf(b * 255),
                    lroundf(a * 255))
    }
    else {
      return String(format: "%02lX%02lX%02lX",
                    lroundf(r * 255),
                    lroundf(g * 255),
                    lroundf(b * 255))
    }
  }
}

extension String {
  func toRGBA() -> (r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) {
    var hexSanitized = self.trimmingCharacters(in: .whitespacesAndNewlines)
    hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
    
    var rgb: UInt64 = 0
    
    var r: CGFloat = 0.0
    var g: CGFloat = 0.0
    var b: CGFloat = 0.0
    var a: CGFloat = 1.0
    
    let length = hexSanitized.count
    
    Scanner(string: hexSanitized).scanHexInt64(&rgb)
    
    if length == 6 {
      r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
      g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
      b = CGFloat(rgb & 0x0000FF) / 255.0
    }
    else if length == 8 {
      r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
      g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
      b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
      a = CGFloat(rgb & 0x000000FF) / 255.0
    }
    
    return (r, g, b, a)
  }
}







extension DatesInfo {
    static let sampleData: [DatesInfo] =
    [
        DatesInfo(title: "Jamie's Birthday", date: (try! Date("28 Mar 2050", strategy: expectedFormat)), reccuring: true, theme: Color("Blue"), ideas: ["Chocolate", "Crochet"]),
        DatesInfo(title: "Christmas", date: (try! Date("25 Dec 2050", strategy: expectedFormat)), reccuring: true, theme: Color("Pink"), ideas: ["Tamerra: Shrek Crocs"]),
        DatesInfo(title: "Trix's Birthday", date: (try! Date("30 Dec 2050", strategy: expectedFormat)), reccuring: true, theme: Color("Green"), ideas: ["Hot Wheels"]),
        DatesInfo(title: "Present swap", date: (try! Date("13 May 2050", strategy: expectedFormat)), reccuring: false, theme: Color("Yellow"), ideas: ["Phoenix: flowers","Spencer: Some sort of Lego"])
    ]
}
