//
//  PlaylistClientProtocol.swift
//  NCSS
//
//  Created by Edward Poon on 4/18/21.
//

import Foundation

protocol PlaylistClient {
    func getPlaylists(completion: @escaping (NetworkResult<[Playlist]>) -> Void)
}
