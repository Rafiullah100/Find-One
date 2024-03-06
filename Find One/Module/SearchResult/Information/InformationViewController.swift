//
//  InformationViewController.swift
//  Find One
//
//  Created by MacBook Pro on 2/16/24.
//

import UIKit

class InformationViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var levelLabel: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var curriculamLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "GridCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: GridCollectionViewCell.cellReuseIdentifier())
        }
    }
    
    let arr = [Grid(name: "Sustainability", image: "sustainability"), Grid(name: "Fee Structure", image: "cash"), Grid(name: "Gallery", image: "gallery"), Grid(name: "Reviews", image: "review"), Grid(name: "Location", image: "locate")]
    
    var delegate: BrowseDelegate?
    
    var information: DetailResult? {
        didSet{
            levelLabel.text = information?.educationLevel
            typeLabel.text = information?.type
            genderLabel.text = information?.gender
            curriculamLabel.text = information?.curriculam
            textView.text = information?.detail?.htmlToString.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .clear
    }

}

extension InformationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        didTappedInstitute?(indexPath.row)
        delegate?.selectCategory(index: indexPath.row)
    }
}


//class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout {
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        let attributes = super.layoutAttributesForElements(in: rect)
//        
//        var newAttributes = [UICollectionViewLayoutAttributes]()
//        var maxY: CGFloat = -1.0
//        
//        attributes?.forEach { layoutAttribute in
//            if layoutAttribute.frame.origin.y >= maxY {
//                maxY = layoutAttribute.frame.maxY
//            } else {
//                var frame = layoutAttribute.frame
//                frame.origin.x = (collectionView!.bounds.width - frame.width) / 2
//                layoutAttribute.frame = frame
//            }
//            newAttributes.append(layoutAttribute)
//        }
//        
//        return newAttributes
//    }
//}
