//
//  SignUpViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/21.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit
import Firebase
import DKImagePickerController
import NVActivityIndicatorView

class SignUpViewController: BaseViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var genderLabel: UILabel!

    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!

    private var maleRadioButton = LTHRadioButton()
    private var femaleRadioButton = LTHRadioButton()

    private var userGender = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()

        setView()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        userImage.layer.cornerRadius = userImage.bounds.size.height / 2.0
        userImage.layer.borderWidth = 1.0
        userImage.layer.masksToBounds = true
    }

    func setView() {

        setBackground(imageName: Constant.BackgroundName.login)

        emailTextField.placeholder = "Emall address"
        emailTextField.clearButtonMode = .whileEditing
        emailTextField.keyboardType = .emailAddress
        emailTextField.delegate = self

        passwordTextField.placeholder = "Password"
        passwordTextField.clearButtonMode = .whileEditing
        passwordTextField.delegate = self

        nameTextField.placeholder = "It will be displaied in app"
        nameTextField.clearButtonMode = .whileEditing
        nameTextField.delegate = self

        // Male Radio Button
        maleRadioButton = LTHRadioButton(selectedColor: .blue)
        view.addSubview(maleRadioButton)
        maleRadioButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            maleRadioButton.centerYAnchor.constraint(equalTo: maleButton.centerYAnchor),
            maleRadioButton.trailingAnchor.constraint(equalTo: maleButton.leadingAnchor, constant: -10),
            maleRadioButton.heightAnchor.constraint(equalToConstant: maleRadioButton.frame.height),
            maleRadioButton.widthAnchor.constraint(equalToConstant: maleRadioButton.frame.width)])

        // Female Radio Button
        femaleRadioButton = LTHRadioButton(selectedColor: .blue)
        view.addSubview(femaleRadioButton)
        femaleRadioButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            femaleRadioButton.centerYAnchor.constraint(equalTo: femaleButton.centerYAnchor),
            femaleRadioButton.trailingAnchor.constraint(equalTo: femaleButton.leadingAnchor, constant: -10),
            femaleRadioButton.heightAnchor.constraint(equalToConstant: femaleRadioButton.frame.height),
            femaleRadioButton.widthAnchor.constraint(equalToConstant: femaleRadioButton.frame.width)])

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        userImage.isUserInteractionEnabled = true
        userImage.addGestureRecognizer(tapGestureRecognizer)
    }

    // MARK: - Select Picture
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        guard
            let tappedImage = tapGestureRecognizer.view as? UIImageView
            else { return }

        let pickerController = DKImagePickerController()

        pickerController.singleSelect = true
        pickerController.assetType = .allPhotos

        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            if assets.count != 0 {
                assets[0].fetchOriginalImageWithCompleteBlock({ (image, _) in
                    tappedImage.image = image
                })
            }
        }

        self.present(pickerController, animated: true) {}
    }

    // MARK: - Select Gender
    @IBAction func clickMaleButton(_ sender: Any) {

        selectGender(select: maleRadioButton,
                     deselect: femaleRadioButton,
                     isMale: true)
    }

    @IBAction func clickFemaleButton(_ sender: Any) {

        selectGender(select: femaleRadioButton,
                     deselect: maleRadioButton,
                     isMale: false)
    }

    func selectGender(select selectGenderButton: LTHRadioButton,
                      deselect deselectGenderButton: LTHRadioButton,
                      isMale: Bool) {

        selectGenderButton.select()
        deselectGenderButton.deselect(animated: false)

        if isMale {
            userGender = Constant.Gender.male

        } else {
            userGender = Constant.Gender.female
        }
    }

    // MARK: - Sign up
    @IBAction func signUp(_ sender: Any) {

        let email = self.emailTextField.text!
        let password = self.passwordTextField.text!
        let name = self.nameTextField.text!
        let gender = self.userGender

        if email != "" && password != "" && name != "" && userGender != "" {

            // MARK: Start loading indicator
            let activityData = ActivityData()
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)

            // MARK: Save user info to firebase
            FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in

                if error != nil {
                    self.showErrorAlert(error: error, myErrorMsg: nil)
                    return
                }

                guard let uid = user?.uid else { return }

                let storageRef = FIRStorage.storage().reference()
                    .child(Constant.FirebaseStorage.userPhoto)
                    .child(Constant.FirebaseStorage.userPhoto + "_" + uid)

                guard
                    let uploadData = UIImageJPEGRepresentation(self.userImage.image!, 0.5)
                    else { return }

                storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in

                    if error != nil {
                        self.showErrorAlert(error: error, myErrorMsg: nil)
                        return
                    }

                    let userPhotoURL = metadata?.downloadURL()?.absoluteString

                    self.setValueToFirebase(uid: uid,
                                       email: email,
                                       name: name,
                                       gender: gender,
                                       userPhotoURL: userPhotoURL)
                })
            }

        } else {
            self.showErrorAlert(error: nil, myErrorMsg: "Please fill out all information about you.")
        }
    }

    func setValueToFirebase(uid: String, email: String, name: String, gender: String, userPhotoURL: String?) {

        let dbUrl = Constant.Firebase.dbUrl
        let ref = FIRDatabase.database().reference(fromURL: dbUrl)
        let usersReference = ref.child(Constant.FirebaseUser.nodeName).child(uid)

        let value = [Constant.FirebaseUser.email: email,
                     Constant.FirebaseUser.name: name,
                     Constant.FirebaseUser.gender: gender,
                     Constant.FirebaseUser.photoURL: userPhotoURL ?? ""]

        usersReference.updateChildValues(value, withCompletionBlock: { (err, _) in

            if err != nil {
                self.showErrorAlert(error: err, myErrorMsg: nil)
                return
            }

            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                let sportItemsStorybard = UIStoryboard(name: Constant.Storyboard.sportItems, bundle: nil)
                let sportItemsViewController = sportItemsStorybard.instantiateViewController(withIdentifier: Constant.Controller.sportItems) as? SportItemsViewController

                appDelegate.window?.rootViewController = sportItemsViewController
            }

            // MARK: End loading indicator
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        })
    }

    /*
     *  For testing
     */
    @IBAction func toLogin(_ sender: Any) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {

            let loginStorybard = UIStoryboard(name: Constant.Storyboard.login, bundle: nil)
            let loginViewController = loginStorybard.instantiateViewController(withIdentifier: Constant.Controller.login) as? LoginViewController

            appDelegate.window?.rootViewController = loginViewController
        }
    }

}

// MARK: - Hide keyboard when user clicks the return on keyboard
extension SignUpViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        self.view.endEditing(true)
        return true
    }
}
