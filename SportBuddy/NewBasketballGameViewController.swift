//
//  NewBasketballGameViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/27.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class NewBasketballGameViewController: BaseViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var courtTextField: UITextField!
    @IBOutlet weak var levelTextField: UITextField!

    let levelArray = ["A", "B", "C", "D", "E"]
    var basketballCourts: [BasketballCourt] = []

    let courtPicker = UIPickerView()
    let levelPicker = UIPickerView()
    let timePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()

        setView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        getCourts()
    }

    func setView() {

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear

        setBackground(imageName: Constant.BackgroundName.basketball)

        setCourtPicker()

        setTimePicker()

        setLevelPicker()
    }

    func setCourtPicker() {

        courtPicker.delegate = self
        courtPicker.dataSource = self
        courtTextField.inputView = courtPicker
    }

    func setTimePicker() {

        let currentTime = Date()
        timePicker.minimumDate = currentTime

        let calendar = Calendar.current
        let maxTime = calendar.date(byAdding: .month, value: 1, to: currentTime)
        timePicker.maximumDate = maxTime

        timePicker.minuteInterval = 15

        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        // bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: nil,
                                         action: #selector(selectedTime))

        doneButton.tintColor = .black

        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                       target: nil,
                                       action: nil)

        toolbar.setItems([flexible, doneButton], animated: false)

        timeTextField.inputAccessoryView = toolbar

        // assigning date picker to text field
        timeTextField.inputView = timePicker
    }

    func selectedTime() {

        // format date
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd   HH:mm"

        timeTextField.text = formatter.string(from: timePicker.date)
        self.view.endEditing(true)
    }

    func setLevelPicker() {

        levelPicker.delegate = self
        levelPicker.dataSource = self
        levelTextField.inputView = levelPicker
    }

    func getCourts() {

        // MARK: Loading indicator
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)

        print("===============")
        print("Constant.CurrentCity.cityName: \(Constant.CurrentCity.cityName)")

        BasketballCourtsProvider.shared.getApiData(city: Constant.CurrentCity.cityName, gymType: Constant.GymType.basketball) { (basketballCourts, error) in

            if error == nil {

                self.basketballCourts = basketballCourts!

            } else {

                // todo: error handling

            }
            print("basketballCourts?.count: \(String(describing: basketballCourts?.count))")
            print("===============")
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        }
    }

    @IBAction func createGame(_ sender: Any) {

    }
}

extension NewBasketballGameViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        if pickerView == courtPicker {

            return basketballCourts.count

        } else if pickerView == levelPicker {

            return levelArray.count

        } else {

            print("== Error in NewBasketballGameViewController - pickerView")
            return 1
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        if pickerView == courtPicker {

            return basketballCourts[row].name

        } else if pickerView == levelPicker {

            return levelArray[row]

        } else {

            print("== Error in NewBasketballGameViewController - pickerView")
            return ""
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if pickerView == courtPicker {

            courtTextField.text = basketballCourts[row].name

        } else if pickerView == levelPicker {

            levelTextField.text = levelArray[row]

        }
    }

}
