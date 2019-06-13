//
//  PhotoListPresenter.swift
//  PhotozouAlbum
//
//  Created by shunsuke igusa on 2019/06/10.
//  Copyright © 2019 井草俊輔. All rights reserved.
//

import Foundation

protocol PhotoListPresenterInput {
    func didTapSearchButton(text: String?)
}

protocol PhotoListPresenterOutput {
    func updatePhotoList(_ photos: PhotoListRepository)
}

class PhotoListPresenter: PhotoListPresenterInput {
    private var view: PhotoListPresenterOutput!
    private var model: PhotoListModelInput
    
    init(view: PhotoListPresenterOutput, model: PhotoListModelInput) {
        self.view = view
        self.model = model
    }
    
    func didTapSearchButton(text: String?) {
        guard let query = text else { return }
        guard !query.isEmpty else { return }
        
        var keyword = text
        var limit = "20"
        
        if query.contains("&") {
            let splited = query.split(separator: "&")
            keyword = String(splited.first!)
            limit = String(splited.last!)
        }
        
        model.fetchPhotos(query: keyword!, limit: limit) { [weak self] result in
            switch result {
            case .success(let response):
                self?.view.updatePhotoList(response)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
