//
//  GalleryViewController.swift
//  Find One
//
//  Created by MacBook Pro on 2/16/24.
//

import UIKit

class GalleryViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "GalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: GalleryCollectionViewCell.cellReuseIdentifier())
        }
    }
    var viewModel = DetailViewModel()
    var galleryDetail: [GalleryResult]?
    var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30.0, right: 0)
        
        viewModel.galleryDetails.bind { galleryDetail in
            self.stopAnimation()
            self.galleryDetail = galleryDetail
            self.collectionView.reloadData()
        }
        self.animateSpinner()
        viewModel.getGalleryDetails(id: id ?? 0, detailType: .gallery)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .clear
    }
}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryDetail?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GalleryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! GalleryCollectionViewCell
        cell.gallery = galleryDetail?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 110, height: 90)
        let cellsAcross: CGFloat = 3
        let spaceBetweenCells: CGFloat = 5
        let width = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        return CGSize(width: width, height: width * 0.9)
    }
    
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        didTappedInstitute?(indexPath.row)
    //    }
}

