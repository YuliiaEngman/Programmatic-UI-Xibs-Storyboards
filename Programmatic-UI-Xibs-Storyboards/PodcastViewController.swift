//
//  ViewController.swift
//  Programmatic-UI-Xibs-Storyboards
//
//  Created by Alex Paul on 1/29/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class PodcastViewController: UIViewController {
  
  private let podcastView = PodcastView()
  
  private var podcasts = [Podcast]() {
    didSet {
      // 13.
        DispatchQueue.main.async {
            self.podcastView.collectionView.reloadData()
        }
    }
  }

  override func loadView() {
    view = podcastView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    navigationItem.title = "Podcasts"
    
    // 4.
    podcastView.collectionView.dataSource = self
    // 6.
    podcastView.collectionView.delegate = self
    
    // 5. register collection view cell
    //podcastView.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "podcastCell")
    // UICollectionViewCell.self - means that we are using default cell (not custom cell)
    
    // after we created PodcastCell 8. + 9.
    //10.
    
    // register cellection view cell using xib/nib
    // making custo cell
    podcastView.collectionView.register(UINib(nibName: "PodcastCell", bundle: nil), forCellWithReuseIdentifier: "podcastCell")
    
    fetchPodcasts()
  }
  
  private func fetchPodcasts(_ name: String = "swift") {
    PodcastAPIClient.fetchPodcast(with: name) { (result) in
      switch result {
      case .failure(let appError):
        print("error fetching podcasts: \(appError)")
      case .success(let podcasts):
        self.podcasts = podcasts
      }
    }
  }
}

extension PodcastViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // 12.
    return podcasts.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "podcastCell", for: indexPath) as? PodcastCell else {
        fatalError("could not downcast to Podcast")
    }
    cell.backgroundColor = .white
    return cell
  }
}

// 7. We are doing size of our cell here
extension PodcastViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // override the default values of the itemSize layout from the collectionView property inializer in thr PodcastView
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width * 0.95 //95% of the width of device
        return CGSize(width: itemWidth, height: 120)
    }
    // 11.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let podcast = podcasts[indexPath.row]
        //print(podcast.collectionName)
        
        // segue to the PodcastDetailController
        // access the PodcastDetailController from Storyboard
        
        // make sure that the storyboard id is set for the PodcastDetailController
        let podcastDetailStoryboard = UIStoryboard(name: "PodcastDetail", bundle: nil)
        guard let podcastDetailController = podcastDetailStoryboard.instantiateViewController(identifier: "PodcastDetailController") as? PodcastDetailController else {
            fatalError("coulod not downcast to PodcastDetailController")
        }
        podcastDetailController.podcast = podcast
        
        // nest week we will pass data using initializer/dependancy injection e.g. PodcastDetailController(podcast: podcast)
        
        navigationController?.pushViewController(podcastDetailController, animated: true)
        
        //show(podcastDetailController, sender: nil)
    }
}




