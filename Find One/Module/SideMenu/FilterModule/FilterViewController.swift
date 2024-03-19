//
//  FilterViewController.swift
//  Find One
//
//  Created by MacBook Pro on 3/18/24.
//

import UIKit

class FilterViewController: UIViewController {

    struct Grades {
        let grades:String?
    }

    struct Genders {
        let genderType:String?
    }

    struct SchoolTypes {
        let schoolType:String?
    }
    
    let stage = [ Grades(grades: "All grades"),
              Grades(grades: "Elementary"),
              Grades(grades: "kindergarten and Nursery"),
              Grades(grades: "High School"),
        ]
    
    let gender = [Genders(genderType: "Boys"),
              Genders(genderType: "Girls"), Genders(genderType: "Boys and Girls")]
    
    let schooltype = [SchoolTypes(schoolType: "International"),
                  SchoolTypes(schoolType: "National"),
                  SchoolTypes(schoolType: "Special Needs"),
                  SchoolTypes(schoolType: "Typical"),
    ]
    
    @IBOutlet weak var typeCollectionView: UICollectionView!{
        didSet{
            typeCollectionView.delegate = self
            typeCollectionView.dataSource = self
            typeCollectionView.register(UINib(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "school")
        }
    }
    @IBOutlet weak var genderCollectionView: UICollectionView!{
        didSet{
            genderCollectionView.delegate = self
            genderCollectionView.dataSource = self
            genderCollectionView.register(UINib(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "gender")
        }
    }
    @IBOutlet weak var stageCollectionView: UICollectionView!{
        didSet{
            stageCollectionView.delegate = self
            stageCollectionView.dataSource = self
            stageCollectionView.register(UINib(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "stage")
        }
    }
    
    @IBOutlet weak var curriculumTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var regionTextField: UITextField!
    
    var stageSelected: IndexPath?
    var typeSelected: IndexPath?
    var genderSelected: IndexPath?

    
    var viewModel = FilterViewModel()
    var regionList: [RegionResultModel]?
    var citiesList: [CityResultModel]?
    var curriculamList: [InstitutetypeResult]?
    var genderList: [GenderResult]?
    var gradeList: [GradeResult]?

    var regionID: Int?
    var cityID: Int?
    var curriculumID: Int?
    var genderID: Int?
    
    
    var regionPicker: UIPickerView?{
        didSet{
            regionPicker?.delegate = self
            regionPicker?.delegate = self
        }
    }
    
    var CityPicker: UIPickerView?{
        didSet{
            CityPicker?.delegate = self
            CityPicker?.delegate = self
        }
    }
    
    var curriculumPicker: UIPickerView?{
        didSet{
            curriculumPicker?.delegate = self
            curriculumPicker?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regionPicker = UIPickerView()
        CityPicker = UIPickerView()
        curriculumPicker = UIPickerView()

        regionTextField.inputView = regionPicker
        cityTextField.inputView = CityPicker
        curriculumTextField.inputView = curriculumPicker
        viewModel.regionList.bind { regions in
            self.regionList = regions
            self.regionPicker?.reloadAllComponents()
        }
        viewModel.citiesList.bind { cities in
            self.citiesList = cities
            self.regionPicker?.reloadAllComponents()
        }
        
        viewModel.curriculam.bind { curriculam in
            self.curriculamList = curriculam
            self.regionPicker?.reloadAllComponents()
        }

        viewModel.genderList.bind { gender in
            self.genderList = gender
            self.genderCollectionView.reloadData()
        }
        
        viewModel.gradeList.bind { grade in
            self.gradeList = grade
            self.stageCollectionView.reloadData()
        }
        
        viewModel.getRegionList()
        viewModel.getCurriculamType()
        viewModel.getGender()
        viewModel.getGrade()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension FilterViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case typeCollectionView:
            return schooltype.count
        case stageCollectionView:
            return gradeList?.count ?? 0
        case genderCollectionView:
            return genderList?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case typeCollectionView:
            let cell: FilterCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "school", for: indexPath) as! FilterCollectionViewCell
            cell.label.text = schooltype[indexPath.row].schoolType ?? ""
            cell.label.textColor = indexPath == typeSelected ? .white : .gray
            cell.BgView.backgroundColor = indexPath == typeSelected ? CustomColor.appColor.color : .clear
            cell.BgView.borderColor = indexPath == typeSelected ? .clear : .gray
            return cell
        case genderCollectionView:
            let cell: FilterCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "gender", for: indexPath) as! FilterCollectionViewCell
            cell.label.text = genderList?[indexPath.row].name ?? ""
            cell.label.textColor = indexPath == genderSelected ? .white : .gray
            cell.BgView.backgroundColor = indexPath == genderSelected ? CustomColor.appColor.color : .clear
            cell.BgView.borderColor = indexPath == genderSelected ? .clear : .gray
            return cell
        case stageCollectionView:
            let cell: FilterCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "stage", for: indexPath) as! FilterCollectionViewCell
            cell.label.text = gradeList?[indexPath.row].name ?? ""
            cell.label.textColor = indexPath == stageSelected ? .white : .gray
            cell.BgView.backgroundColor = indexPath == stageSelected ? CustomColor.appColor.color : .clear
            cell.BgView.borderColor = indexPath == stageSelected ? .clear : .gray
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case typeCollectionView:
            typeSelected = indexPath
        case genderCollectionView:
            genderSelected = indexPath
        case stageCollectionView:
            stageSelected = indexPath
        default: break
        }
        collectionView.reloadData()
    }
}

extension FilterViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat = 0
        switch collectionView {
        case typeCollectionView:
            width = calculateWidth(text: schooltype[indexPath.row].schoolType ?? "")
        case genderCollectionView:
            width = calculateWidth(text: genderList?[indexPath.row].name ?? "")
        case stageCollectionView:
            width = calculateWidth(text: gradeList?[indexPath.row].name ?? "")
        default:
            width = 0
        }
        return CGSize(width: width + 20, height: collectionView.frame.height)
    }
    
    private func calculateWidth(text: String)->CGFloat {
        let width = text.size(withAttributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0)
        ]).width
        return width
    }
}

extension FilterViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == regionPicker {
            return regionList?.count ?? 0
        }
        else if pickerView == CityPicker{
            return citiesList?.count ?? 0
        }
        else if pickerView == curriculumPicker{
            return curriculamList?.count ?? 0
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == regionPicker {
            regionTextField.text = regionList?[row].name
            return regionList?[row].name
        }
        else if pickerView == CityPicker{
            cityTextField.text = citiesList?[row].name
            return citiesList?[row].name
        }
        else if pickerView == curriculumPicker{
            curriculumTextField.text = curriculamList?[row].name
            return curriculamList?[row].name
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == regionPicker {
            regionID = regionList?[row].id ?? 0
            cityTextField.text = ""
            viewModel.getCitiesList(regionID: regionList?[row].id ?? 0)
        }
        else if pickerView == CityPicker{
            cityID = citiesList?[row].id ?? 0
        }
        else if pickerView == curriculumPicker{
            curriculumID = curriculamList?[row].id ?? 0
        }
    }
}

