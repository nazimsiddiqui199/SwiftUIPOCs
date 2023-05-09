//
//  PageModal.swift
//  GesturePOC
//
//  Created by Nazim Siddiqui on 09/05/23.
//

import Foundation

struct Page: Identifiable {
    let id: Int
    let imageName: String
}

extension Page {
    var thumbnailImage: String {
        "thumb-" + imageName
    }
}
