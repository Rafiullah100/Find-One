//
//  FilterViewController.swift
//  Find One
//
//  Created by MacBook Pro on 3/18/24.
//

import UIKit

protocol FilterProtocol {
    func filter(cityID: Int, regionID: Int, curriculumID: Int, stageID: Int, genderID: Int, instituteType: Int)
}

class FilterViewController: UIViewController {
    
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var schoolTypeLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var stageLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var districtLabel: UILabel!
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
    var instituteList: [InstitutetypeResult]?

    var regionID: Int?
    var cityID: Int?
    var curriculumID: Int?
    var genderID: Int?
    var stageID: Int?
    var typeID: Int?

    var filterDelegate: FilterProtocol?
    
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
        
        districtLabel.text = LocalizationKeys.district.rawValue.localizeString()
        regionLabel.text = LocalizationKeys.region.rawValue.localizeString()
        stageLabel.text = LocalizationKeys.stage.rawValue.localizeString()
        genderLabel.text = LocalizationKeys.gender.rawValue.localizeString()
        schoolTypeLabel.text = LocalizationKeys.schoolType.rawValue.localizeString()
        filterButton.setTitle(LocalizationKeys.filterResult.rawValue.localizeString(), for: .normal)
        cityTextField.textAlignment = Helper.isRTL() ? .right : .left
        regionTextField.textAlignment = Helper.isRTL() ? .right : .left
        cityTextField.placeholder = LocalizationKeys.city.rawValue.localizeString()
        regionTextField.placeholder = LocalizationKeys.allDistrict.rawValue.localizeString()
        curriculumTextField.textAlignment = Helper.isRTL() ? .right : .left
        curriculumTextField.placeholder = LocalizationKeys.curriculum.rawValue.localizeString()

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
        
        viewModel.instituteType.bind { type in
            self.instituteList = type
            self.typeCollectionView.reloadData()
        }
        
        viewModel.getRegionList()
        viewModel.getCurriculamType()
        viewModel.getGender()
        viewModel.getGrade()
        viewModel.getInstituteType()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func filterBtnAction(_ sender: Any) {
        filterDelegate?.filter(cityID: cityID ?? 0, regionID: regionID ?? 0, curriculumID: curriculumID ?? 0, stageID: stageID ?? 0, genderID: genderID ?? 0, instituteType: typeID ?? 0)
        self.dismiss(animated: true)
    }
}

extension FilterViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case typeCollectionView:
            return instituteList?.count ?? 0
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
            cell.label.text = instituteList?[indexPath.row].name ?? ""
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
            typeID = instituteList?[indexPath.row].id
        case genderCollectionView:
            genderSelected = indexPath
            genderID = genderList?[indexPath.row].id
        case stageCollectionView:
            stageSelected = indexPath
            stageID = gradeList?[indexPath.row].id
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
            width = calculateWidth(text: instituteList?[indexPath.row].name ?? "")
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
            return instituteList?.count ?? 0
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == regionPicker {
            return regionList?[row].name
        }
        else if pickerView == CityPicker{
            return citiesList?[row].name
        }
        else if pickerView == curriculumPicker{
            return curriculamList?[row].name
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == regionPicker {
            regionTextField.text = regionList?[row].name
            regionID = regionList?[row].id ?? 0
            cityTextField.text = ""
            viewModel.getCitiesList(regionID: regionList?[row].id ?? 0)
        }
        else if pickerView == CityPicker{
            cityTextField.text = citiesList?[row].name
            cityID = citiesList?[row].id ?? 0
        }
        else if pickerView == curriculumPicker{
            curriculumTextField.text = curriculamList?[row].name
            curriculumID = curriculamList?[row].id ?? 0
        }
    }
}

