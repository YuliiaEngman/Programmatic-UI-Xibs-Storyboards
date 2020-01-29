//
//  PodcastAPIClient.swift
//  Programmatic-UI-Xibs-Storyboards
//
//  Created by Alex Paul on 1/29/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation
import NetworkHelper

struct PodcastAPIClient {
  static func fetchPodcast(with name: String, completion: @escaping (Result<[Podcast], AppError>) -> ()) {
    let endpointURLString = "https://itunes.apple.com/search?media=podcast&limit=200&term=\(name)"
    guard let url = URL(string: endpointURLString) else {
      completion(.failure(.badURL(endpointURLString)))
      return
    }
    let request = URLRequest(url: url)
    NetworkHelper.shared.performDataTask(with: request) { (result) in
      switch result {
      case .failure(let appError):
        completion(.failure(.networkClientError(appError)))
      case .success(let data):
        do {
          let podcastSearch = try JSONDecoder().decode(PodcastSerach.self, from: data)
          completion(.success(podcastSearch.results))
        } catch {
          completion(.failure(.decodingError(error)))
        }
      }
    }
  }
}
