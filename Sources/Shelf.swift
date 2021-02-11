import Foundation

/**
{
 "id": "568494",
 "name": "Przeczytane",
 "type": "read",
 "books": "224"
} 
*/

struct Shelf: Codable {
    let id: String
    let name: String
    let type: String
    let books: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name, type, books
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        type = try values.decode(String.self, forKey: .type)
        guard let books = try Int(values.decode(String.self, forKey: .books)) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.books], debugDescription: "Expecting string representation of Int"))
        }
        self.books = books
    }
}
