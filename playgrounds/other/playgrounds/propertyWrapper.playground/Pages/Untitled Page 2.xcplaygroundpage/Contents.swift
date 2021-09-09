//: [Previous](@previous)

import Foundation

//1.63, 1.53

let result = """
{
    "value" : 1.53
}
""".data(using: .utf16)

struct Person: Decodable {
    let value: Double
    enum CodingKeys: String, CodingKey {
        case value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decode(Double.self, forKey: .value)
    }
}


let age = try! JSONDecoder().decode(Person.self, from: result!)
print(age.value)


