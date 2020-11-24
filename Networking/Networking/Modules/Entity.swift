//
//  Entity.swift
//  Networking
//
//  Created by Glauco Moraes on 24/11/20.
//

import Foundation

struct Photo: Decodable, Equatable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
