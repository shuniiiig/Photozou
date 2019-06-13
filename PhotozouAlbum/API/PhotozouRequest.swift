//
//  PhotozouAPI.swift
//  PhotozouAlbum
//
//  Created by shunsuke igusa on 2019/06/10.
//  Copyright © 2019 井草俊輔. All rights reserved.
//

import Foundation
import APIKit

protocol PhotozouRequest: Request { }

extension PhotozouRequest {
    var baseURL: URL {
        return URL(string: "https://api.photozou.jp")!
    }
}
