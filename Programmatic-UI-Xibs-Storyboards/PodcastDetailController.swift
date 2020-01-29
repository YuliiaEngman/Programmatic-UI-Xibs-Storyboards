//
//  PodcastDetailController.swift
//  Programmatic-UI-Xibs-Storyboards
//
//  Created by Yuliia Engman on 1/29/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import ImageKit

class PodcastDetailController: UIViewController {

    @IBOutlet weak var podcastImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    var podcast: Podcast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI() {
        guard let podcast = podcast else {
            fatalError("did not load a podcast from segue")
        }
        artistNameLabel.text = podcast.artistName
        podcastImageView.getImage(with: podcast.artworkUrl600) {[weak self] (result) in
            switch result {
            case .failure:
                break
            case .success(let image):
                DispatchQueue.main.async {
                    self?.podcastImageView.image = image
                }
            }
            
        }
    }

}
