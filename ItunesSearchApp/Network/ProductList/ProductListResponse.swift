//
//  ProductListResponse.swift
//  ItunesSearchApp
//
//  Created by Özgü Ataseven on 1.05.2022.
//

import Foundation

struct ProductListResponse: Decodable {
    let resultCount: Int
    let results: [Product]?
}

struct Product: Decodable {
    let wrapperType: String?
    let kind: String?
    let artistId: Int?
    let collectionId: Int?
    let trackId: Int?
    let artistName: String?
    let collectionName: String?
    let trackName: String?
    let collectionCensoredName: String?
    let trackCensoredName: String?
    let artistViewUrl: String?
    let collectionViewUrl: String?
    let trackViewUrl: String?
    let previewUrl: String?
    let artworkUrl30: String?
    let artworkUrl60: String?
    let artworkUrl100: String?
    let collectionPrice: Double?
    let releaseDate: String?
    let trackPrice: Double?
    let currency: String?
    let primaryGenreName: String?
    let longDescription: String?
}
