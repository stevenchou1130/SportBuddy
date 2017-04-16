//
//  NewBasketballGameViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/27.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit
import Firebase
import NVActivityIndicatorView

class NewBasketballGameViewController: BaseViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var courtTextField: UITextField!
    @IBOutlet weak var levelTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!

    let levelArray = ["A", "B", "C", "D", "E"]
    var basketballCourts: [BasketballCourt] = []
    var selectedCourt: BasketballCourt?

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

        self.tabBarController?.tabBar.isHidden = true

        getCourts()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.tabBarController?.tabBar.isHidden = false
    }

    func setView() {

        setBackground(imageName: Constant.BackgroundName.basketball)

        setCourtPicker()

        setLevelPicker()

        setTimePicker()
    }

    func setCourtPicker() {

        courtPicker.delegate = self
        courtPicker.dataSource = self
        courtTextField.inputView = courtPicker
    }

    func setLevelPicker() {

        levelPicker.delegate = self
        levelPicker.dataSource = self
        levelTextField.inputView = levelPicker
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

        // assigning date picker to textfield
        timeTextField.inputView = timePicker
    }

    func selectedTime() {

        // format date
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd HH:mm"

        timeTextField.text = formatter.string(from: timePicker.date)
        self.view.endEditing(true)
    }

    func getCourts() {

        // MARK: Loading indicator
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)

        BasketballCourtsProvider.shared.getApiData(city: Constant.CurrentCity.cityName, gymType: Constant.GymType.basketball) { (basketballCourts, error) in

            if error == nil {

                self.basketballCourts = basketballCourts!

            } else {

                // todo: error handling

            }

            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        }
    }

    @IBAction func createGame(_ sender: Any) {

        let name = nameTextField.text
        let court = courtTextField.text
        let level = levelTextField.text
        let time = timeTextField.text

        if name != "" && court != "" && level != "" && time != "" {

            guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
            let ref = FIRDatabase.database().reference().child(Constant.FirebaseGame.nodeName)

            if selectedCourt != nil {

                let selectedCourtInfo: [String: Any] = [
                    Constant.CourtInfo.courtID: selectedCourt!.courtID,
                    Constant.CourtInfo.name: selectedCourt!.name,
                    Constant.CourtInfo.tel: selectedCourt!.tel ?? "",
                    Constant.CourtInfo.address: selectedCourt!.address,
                    Constant.CourtInfo.rate: selectedCourt!.rate,
                    Constant.CourtInfo.rateCount: selectedCourt!.rateCount,
                    Constant.CourtInfo.gymFuncList: selectedCourt!.gymFuncList,
                    Constant.CourtInfo.latitude: selectedCourt!.latitude,
                    Constant.CourtInfo.longitude: selectedCourt!.longitude
                ]

                let game: [String : Any] = [
                    Constant.FirebaseGame.owner: uid,
                    Constant.FirebaseGame.itme: Constant.SportItem.basketball,
                    Constant.FirebaseGame.name: name!,
                    Constant.FirebaseGame.time: time!,
                    Constant.FirebaseGame.court: selectedCourtInfo,
                    Constant.FirebaseGame.level: level!,
                    Constant.FirebaseGame.members: [uid]
                ]

                let game1Ref = ref.childByAutoId()
                game1Ref.setValue(game)

                self.navigationController?.popViewController(animated: true)

            } else {

                return
            }

        } else {

            self.showErrorAlert(error: nil,
                                myErrorMsg: "Please fill out all information about you.")
        }
    }
}

// MARK: - Set Picker
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
            selectedCourt = basketballCourts[row]

        } else if pickerView == levelPicker {

            levelTextField.text = levelArray[row]

        }
    }

}
