//
//  BrowseViewController.swift
//  Find One
//
//  Created by MacBook Pro on 2/15/24.
//

import UIKit

struct Grid {
    let name: String?
    let image: String?
    
}

class BrowseViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "GridCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: GridCollectionViewCell.cellReuseIdentifier())
        }
    }
    
    let arr = [Grid(name: "Information", image: "about"), Grid(name: "Sustainability", image: "sustainability"), Grid(name: "Fee Structure", image: "cash"), Grid(name: "Gallery", image: "gallery"), Grid(name: "Reviews", image: "review"), Grid(name: "Location", image: "locate")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension BrowseViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GridCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! GridCollectionViewCell
        cell.imgView.image = UIImage(named: arr[indexPath.row].image ?? "")
        cell.label.text = arr[indexPath.row].name ?? ""
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 90)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        didTappedInstitute?(indexPath.row)
//    }
}

