//
//  PhotoListModel.swift
//  PhotozouAlbum
//
//  Created by 井草俊輔 on 2019/06/10.
//  Copyright © 2019 井草俊輔. All rights reserved.
//

import Foundation
import APIKit


protocol PhotoListModelInput {
    func fetchPhotos(query: String, limit: String,
                     completion: @escaping (Result<PhotozouAPI.PhotoListRequest.Response, SessionTaskError>) -> ())
}

final class PhotoListModel: PhotoListModelInput {
    func fetchPhotos(query: String,
                     limit: String,
                     completion: @escaping (Result<PhotozouAPI.PhotoListRequest.Response, SessionTaskError>) -> ()) {
        let request = PhotozouAPI.PhotoListRequest(query: query, limit: limit)
        
        Session.send(request) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
