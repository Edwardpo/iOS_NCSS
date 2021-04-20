//
//  Playlist.swift
//  NCSS
//
//  Created by Edward Poon on 4/18/21.
//

import Foundation

class Playlist: Decodable {
    var title: String
    var videoId: String
    var thumbnailURLString: String
    var publishedAt: String
    
    init(title: String, videoId: String, thumbnailString: String, publishedAt: String) {
        self.title = title
        self.videoId = videoId
        self.thumbnailURLString = thumbnailString
        self.publishedAt = publishedAt
    }
    
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        videoId = try values.decode(String.self, forKey: .videoId)
        publishedAt = try values.decode(String.self, forKey: .publishedAt)
        
        let snippet = try values.nestedContainer(keyedBy: SnippetInfoKeys.self, forKey: .snippet)
        title = try snippet.decode(String.self, forKey: .title)
        let thumbnails = try snippet.nestedContainer(keyedBy: ThumbnailKeys.self, forKey: .thumbnails)
        let mediumThumbnail = try thumbnails.nestedContainer(keyedBy: MediumKeys.self, forKey: .medium)
        thumbnailURLString = try mediumThumbnail.decode(String.self, forKey: .thumbnailURLString)
    }
    
    enum CodingKeys: String, CodingKey {
        case snippet
        case videoId = "id"
        case publishedAt
    }
    
    enum SnippetInfoKeys: String, CodingKey {
        case title
        case thumbnails
    }
    
    enum ThumbnailKeys: String, CodingKey {
        case medium
    }
    
    enum MediumKeys: String, CodingKey {
        case thumbnailURLString = "url"
    }
}
