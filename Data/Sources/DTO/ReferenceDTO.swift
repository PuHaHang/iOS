//
//  ReferenceDTO.swift
//  PuHaHang
//
//  Created by 디해 on 6/20/25.
//

import Foundation
import Entity

public struct ReferenceDTO: Decodable {
    let platform: String
    let url: String?
    let metadata: String?
    
    enum CodingKeys: String, CodingKey {
        case platform
        case url
        case metadata
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        platform = try container.decode(String.self, forKey: .platform)
        url = try container.decodeIfPresent(String.self, forKey: .url)
        
        if container.contains(.metadata) {
            do {
                let rawValue = try container.decode(JSONValue.self, forKey: .metadata)
                metadata = rawValue.stringValue
            } catch {
                metadata = nil
            }
        } else {
            metadata = nil
        }
    }
}

private enum JSONValue: Decodable {
    case string(String)
    case object([String: JSONValue])
    case array([JSONValue])
    case null
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if container.decodeNil() {
            self = .null
        } else if let string = try? container.decode(String.self) {
            self = .string(string)
        } else if let object = try? container.decode([String: JSONValue].self) {
            self = .object(object)
        } else if let array = try? container.decode([JSONValue].self) {
            self = .array(array)
        } else {
            self = .null
        }
    }
    
    var stringValue: String? {
        switch self {
        case .string(let string):
            return string
        case .object(let dict):
            if dict.isEmpty {
                return "{}"
            }
            do {
                let data = try JSONSerialization.data(
                    withJSONObject: dict.mapValues { $0.anyValue },
                    options: [])
                return String(data: data, encoding: .utf8)
            } catch {
                return "{}"
            }
        case .null:
            return nil
        case .array:
            return "[]"
        }
    }
    
    var anyValue: Any {
        switch self {
        case .string(let string):
            return string
        case .object(let dict):
            return dict.mapValues { $0.anyValue }
        case .array(let array):
            return array.map { $0.anyValue }
        case .null:
            return NSNull()
        }
    }
}

extension ReferenceDTO {
    func toDomain() -> ReferenceVO {
        ReferenceVO.from(type: platform, urlString: url, metadataString: metadata)
    }
}
