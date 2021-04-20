//
//  ShowsViewController.swift
//  NCSS
//
//  Created by Edward Poon on 4/17/21.
//

import UIKit

class ShowsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        YouTubePlaylistClient(channelId: "UClWTsjnW48j0EIgEyNrdSrg&key=AIzaSyCDGRnmfeJXd6bvFvT8qIm6sDWJtCmHwXA", apiKey: youtubeApiKey).getPlaylists { (networkResult) in
            switch(networkResult) {
            case .success(let playlists):
                print(playlists)
            case .failure(let error):
                print(error)
            }
        }
    }


}

