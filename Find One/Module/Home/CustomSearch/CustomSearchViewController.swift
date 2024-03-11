//
//  CustomSearchViewController.swift
//  Find One
//
//  Created by MacBook Pro on 2/13/24.
//

import UIKit

class CustomSearchViewController: BaseViewController {

    @IBOutlet weak var sliderView: UISlider!
    @IBOutlet weak var segmentView: UISegmentedControl!
    @IBOutlet weak var instituteTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var regionTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var viewModel = SearchViewModel()
    var regionList: [RegionResultModel]?
    var citiesList: [CityResultModel]?
    var curriculamList: [InstitutetypeResult]?
    var genderList: [GenderResult]?

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
    
    var curriculamPicker: UIPickerView?{
        didSet{
            curriculamPicker?.delegate = self
            curriculamPicker?.delegate = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .home
        
        segmentView.removeAllSegments()
        regionPicker = UIPickerView()
        CityPicker = UIPickerView()
        curriculamPicker = UIPickerView()

        regionTextField.inputView = regionPicker
        cityTextField.inputView = CityPicker
        instituteTextField.inputView = curriculamPicker
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
            for i in 0..<(self.genderList?.count ?? 0){
                self.segmentView.insertSegment(withTitle: self.genderList?[i].name, at: i, animated: true)
            }
        }
        
        viewModel.getRegionList()
        viewModel.getCurriculamType()
        viewModel.getGender()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
    }
}


extension CustomSearchViewController: UIPickerViewDelegate, UIPickerViewDataSource{
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
        else if pickerView == curriculamPicker{
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
        else if pickerView == curriculamPicker{
            instituteTextField.text = curriculamList?[row].name
            return curriculamList?[row].name
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == regionPicker {
            cityTextField.text = ""
            viewModel.getCitiesList(regionID: regionList?[row].id ?? 0)
        }
    }
}

