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
    
    @IBOutlet weak var viewhieght: NSLayoutConstraint!
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
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .clear
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewhieght.constant = collectionView.contentSize.height
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
        delegate?.selectCategory(index: indexPath.row)
    }
}


extension InformationViewController {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionFooter {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer_view", for: indexPath) as! FooterView
            footerView.didTappedBtn = {
                Switcher.gotoBooking(delegate: self)
            }
            return footerView
        }
        return UICollectionReusableView()
    }
}
