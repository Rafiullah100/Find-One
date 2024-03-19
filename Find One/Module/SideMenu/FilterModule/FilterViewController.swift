//
//  FilterViewController.swift
//  Find One
//
//  Created by MacBook Pro on 3/18/24.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var typeCollectionView: UICollectionView!
    @IBOutlet weak var genderCollectionView: UICollectionView!
    @IBOutlet weak var stageCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
}
