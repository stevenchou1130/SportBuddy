//
//  EditProfileViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/4/16.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit
import DKImagePickerController

class EditProfileViewController: BaseViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        getUserInfo()
        setView()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        setUserImage()
    }

    func getUserInfo() {

    }

    func setView() {

        setBackground(imageName: Constant.BackgroundName.basketball)
    }

    func setUserImage() {

        userImage.layer.cornerRadius = userImage.bounds.size.height / 2.0
        userImage.layer.borderWidth = 1.0
        userImage.layer.masksToBounds = true

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

    @IBAction func saveProfileInfo(_ sender: Any) {

        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelEdit(_ sender: Any) {

        self.dismiss(animated: true, completion: nil)
    }
}
