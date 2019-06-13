//
//  ViewController.swift
//  PhotozouAlbum
//
//  Created by 井草俊輔 on 2019/06/08.
//  Copyright © 2019 井草俊輔. All rights reserved.
//

import UIKit
import APIKit
import Nuke

final class PhotoListViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var presenter: PhotoListPresenterInput!
    private let reuseIdentifier = "PhotoCollectionViewCell"
    private var response : PhotoListRepository?
    
    static func makeInstance() -> PhotoListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! PhotoListViewController
        return viewController
    }
    
    func inject(presenter: PhotoListPresenterInput) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        searchBar.placeholder = "検索してください"
        collectionView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
}

extension PhotoListViewController: PhotoListPresenterOutput {
    func updatePhotoList(_ photos: PhotoListRepository) {
        response = photos
        collectionView.reloadData()
    }
    
}

extension PhotoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        presenter.didTapSearchButton(text: searchBar.text)
    }
}

extension PhotoListViewController: UICollectionViewDelegate {
    
}

extension PhotoListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return response?.info.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
        guard let result = response else { return cell }
        cell.updateCell(result.info.photos[indexPath.row].imageURL)
        return cell
    }
    
    
}

extension PhotoListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = view.bounds.width
        if (indexPath.row + 1) % 5 == 0 {
            return CGSize(width: cellWidth - 10, height: 200)
        } else {
            return CGSize(width: cellWidth / 2 - 10 , height: 120)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20 , left: 3 , bottom: 20 , right: 3 )
    }
    
}

