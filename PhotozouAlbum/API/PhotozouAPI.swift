//
//  PhotozouAPI.swift
//  PhotozouAlbum
//
//  Created by shunsuke igusa on 2019/06/10.
//  Copyright © 2019 井草俊輔. All rights reserved.
//

import Foundation
import APIKit

final class PhotozouAPI {
    struct PhotoListRequest: PhotozouRequest {
        typealias Response = PhotoListRepository
        
        let query: String
        let limit: String
        
        var method: HTTPMethod {
            return .get
        }
        
        var path: String {
            return "/rest/search_public.json"
        }
        
        var parameters: Any? {
            return ["keyword": query, "limit": limit]
        }
        
        var dataParser: DataParser {
            return DecodableDataParser()
        }
        
        func response(from object: Any, urlResponse: HTTPURLResponse) throws -> PhotoListRepository {
            guard let data = object as? Data else {
                throw ResponseError.unexpectedObject(object)
            }
            return try JSONDecoder().decode(PhotoListRepository.self, from: data)
        }
    }
}

final class DecodableDataParser: DataParser {
    var contentType: String? {
        return "application/json"
    }

    func parse(data: Data) throws -> Any {
        return data
    }
}


public struct PhotoListRepository: Codable {
    public var info : Info!
    
    public struct Info: Codable {
        public var photos : [Photo]!
        
        enum CodingKeys: String, CodingKey {
            case photos = "photo"
        }
        
        public struct Photo: Codable {
            public var imageURL : String!
            
            enum CodingKeys: String, CodingKey {
                case imageURL = "image_url"
            }
            
        }
        
    }
}

