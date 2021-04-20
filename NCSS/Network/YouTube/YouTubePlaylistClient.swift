//
//  YouTubePlaylistClient.swift
//  NCSS
//
//  Created by Edward Poon on 4/18/21.
//
 
import Foundation

enum PlaylistResult {
    
}

class YouTubePlaylistClient: PlaylistClient {
    
    /// Identifier for the YouTube Channel
    var channelId: String
    var apiKey: String
    var networkClient: NetworkClient
    
    init(channelId:String, apiKey: String) {
        self.channelId = channelId
        self.apiKey = apiKey
        self.networkClient = NetworkClient()
    }
    
    func getPlaylists(completion: @escaping (NetworkResult<[Playlist]>) -> Void) {
        
        let url = URL(string: "https://www.googleapis.com/youtube/v3/playlists?part=snippet&channelId=\(channelId)&key=\(apiKey)")!
        var playlists = [Playlist]()
        var getPlaylistsError: Error? = nil
        networkClient.loadData(from: url) { (networkResult) in
            switch(networkResult) {
            case .success(let data):
                do {
                    // TODO: - Fix this
//                    let json = try JSONSerialization.jsonObject(with: data, options: [])
//                    print("Got the json \(json)")
//                    if let object = json as? [String:Any], let items = object["items"] as? [Any] {
//                        print("Got the items \(items)")
//
//                        let playlistsData = try NSKeyedArchiver.archivedData(withRootObject: items, requiringSecureCoding: false)
//                        playlists = try JSONDecoder().decode([Playlist].self, from: playlistsData)
//                    }
                }
                catch {
                    getPlaylistsError = error
                }
            case .failure(let error):
                getPlaylistsError = error
            }
            if(getPlaylistsError != nil) {
                completion(NetworkResult.failure(getPlaylistsError))
            }
            else {
                completion(NetworkResult.success(playlists))                
            }
            
        }
    }
}
