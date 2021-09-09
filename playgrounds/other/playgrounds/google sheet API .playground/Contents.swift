import UIKit
import PlaygroundSupport



struct Payload: Codable {
    let station : [SupplyStation]
}
struct SupplyStation: Codable {
    let name, city, address: String
    let latitude, longitude: Double
}
//struct MapAnnotation: Codable {
//    let name, address: String?
//    let latitude, longitude: Double?
//    let remark, phone, opening, keyword: String?
//    let rating, checkinCount, kinds: String?
//
//    enum CodingKeys: String, CodingKey {
//        case name, address
//        case latitude = "Latitude"
//        case longitude = "Longitude"
//        case remark, phone, opening, keyword, rating, checkinCount, kinds
//    }
//}


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - WelcomeElement
struct MapAnnotation: Codable {
    let name, address: String
    let latitude, longitude, remark: Latitude
    let phone: String
    let opening: Opening
    let keyword: Keyword
    let rating: Rating
    let checkinCount: String
    let kinds: Kinds

    enum CodingKeys: String, CodingKey {
        case name, address
        case latitude = "Latitude"
        case longitude = "Longitude"
        case remark, phone, opening, keyword, rating, checkinCount, kinds
    }
}

enum Keyword: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Keyword.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Keyword"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum Kinds: String, Codable {
    case empty = ""
    case 食 = "食"
}

enum Latitude: Codable {
    case double(Double)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Latitude.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Latitude"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum Opening: String, Codable {
    case 特別感謝G0V唐鳳開放資料貢獻資料每分鐘更新請善用列表右上方黃色同步按鈕 = "特別感謝g0v, 唐鳳 開放資料貢獻 \n資料每分鐘更新, 請善用列表右上方黃色同步按鈕"
}

enum Rating: String, Codable {
    case 可持健保卡以10元購買2片口罩7天內不能重複購買 = "可持健保卡以10元購買2片口罩，7天內不能重複購買"
}

//typealias Welcome = [WelcomeElement]




let privacy = "https://raw.githubusercontent.com/TerryCK/privacepolicyofsupplymap/master/README.md"
let testApi = "https://raw.githubusercontent.com/TerryCK/TestForAPI/master/Content.json"


let productAllAPI = "https://script.google.com/macros/s/AKfycbwinOb0yIffk6sxSlTuTtwgOUSdCu01bYvor9yg6Q/exec"

let parameters = "?apiToken=1aK0vUI6a16kRKXygq3ySRmYmphsdmRyPPiLL6BrSXjo"


let api = "https://script.google.com/macros/s/AKfycby-_D068nxPkOKxNQcq8PJWUoXFNEljGrORBsoYuQBxIAfrFo4/exec"



func request(url : URL) {
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let data = data else { return }
        do {
            let list = try JSONDecoder().decode([MapAnnotation].self, from: data)
            print(list)
        } catch { print(error) }
    }.resume()
}

let testapiid = "1rjiOzu_zVJN_0FmgJBUnP3fJDGIP5XuGjq1vKNePojY"

URLSession.shared.dataTask(with: URL(string: productAllAPI)!) { (data, response, error) in
    guard let data = data else { return }
    
    do {
        let list = try JSONDecoder().decode([[String: String]].self, from: data)
        
        for dictionary in list {
            
            guard let api = dictionary["api"] else { return }
            print(api)
            print()
            let redirect = productAllAPI+"?apiToken=\(api)"
            print(redirect)
            print()
            request(url: URL(string: redirect)!)
        }
    } catch { print(error) }
}.resume()


request(url: URL(string: productAllAPI+"?apiToken=\(testapiid)")!)





PlaygroundPage.current.needsIndefiniteExecution = false
