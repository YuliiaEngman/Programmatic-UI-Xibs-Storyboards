//
//  Podcast.swift
//  Programmatic-UI-Xibs-Storyboards
//
//  Created by Alex Paul on 1/29/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

struct PodcastSerach: Codable {
  let results: [Podcast]
}

struct Podcast: Codable {
  let artistName: String
  let collectionName: String
  let artworkUrl100: String
  let artworkUrl600: String
}


