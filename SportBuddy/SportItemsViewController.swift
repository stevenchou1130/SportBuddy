//
//  SportItemsViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/23.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit
import Firebase
import NVActivityIndicatorView

class SportItemsViewController: BaseViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var jogButton: UIButton!
    @IBOutlet weak var baseballButton: UIButton!

    let loadingIndicator = LoadingIndicator()

    override func viewDidLoad() {
        super.viewDidLoad()

        checkIfUserIsLoggedIn()
        setView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setUserInfo()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        userImage.layer.cornerRadius = userImage.bounds.size.height / 2.0
        userImage.layer.borderWidth = 1.0
        userImage.layer.masksToBounds = true
    }

    func setView() {

        setBackground(imageName: Constant.BackgroundName.basketball)

        // todo: 滑動選單

        let jobImageBW = convertImageToBW(image: #imageLiteral(resourceName: "Item_Jog"))
        jogButton.setImage(jobImageBW, for: .normal)
        jogButton.isEnabled = false

        let baseballImageBW = convertImageToBW(image: #imageLiteral(resourceName: "Item_Baseball"))
        baseballButton.setImage(baseballImageBW, for: .normal)
        baseballButton.isEnabled = false
    }

    func checkIfUserIsLoggedIn() {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            handleLogout()
        }
    }

    func handleLogout() {

        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print("=== LogoutError: ")
            print(logoutError)
        }

        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {

            let loginStorybard = UIStoryboard(name: Constant.Storyboard.login, bundle: nil)
            let loginViewController = loginStorybard.instantiateViewController(withIdentifier: Constant.Controller.login) as? LoginViewController

            appDelegate.window?.rootViewController = loginViewController
        }
    }

    func setUserInfo() {

        guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }

        loadingIndicator.start()

        UserManager.shared.getUserInfo(currentUserUID: uid) { (user, error) in

            if user != nil {
                self.userName.text = user!.name
                self.loadImage(imageUrlString: user!.photoURL, imageView: self.userImage)
            }

            if error != nil {
                self.errorHandle(errString: "Can't find the data", error: nil)
            }
        }
    }

    @IBAction func toEditProfile(_ sender: Any) {

        let editProfileStorybard = UIStoryboard(name: Constant.Storyboard.editProfile, bundle: nil)
        let editProfileViewController = editProfileStorybard.instantiateViewController(withIdentifier: Constant.Controller.editProfile) as? EditProfileViewController

        self.present(editProfileViewController!, animated: true, completion: nil)
    }

    // todo: add another item button action
    @IBAction func toBasketballGameList(_ sender: Any) {

        guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
        let rootRef = FIRDatabase.database().reference()

        rootRef.child(Constant.FirebaseLevel.nodeName).child(uid).observeSingleEvent(of: .value, with: { (snapshot) in

            if snapshot.exists() {

                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {

                    let basketballStorybard = UIStoryboard(name: Constant.Storyboard.basketball, bundle: nil)
                    let basketballTabbarViewController = basketballStorybard.instantiateViewController(withIdentifier: Constant.Controller.basketballTabbar) as? BasketballTabbarViewController

                    appDelegate.window?.rootViewController = basketballTabbarViewController
                }

            } else {

                let dbUrl = Constant.Firebase.dbUrl
                let ref = FIRDatabase.database().reference(fromURL: dbUrl)

                let levelsReference = ref.child(Constant.FirebaseLevel.nodeName).child(uid)

                let value = [Constant.FirebaseLevel.basketball: "",
                             Constant.FirebaseLevel.baseball: "",
                             Constant.FirebaseLevel.jogging: ""]

                levelsReference.updateChildValues(value, withCompletionBlock: { (err, _) in

                    if err != nil {
                        self.showErrorAlert(error: err, myErrorMsg: nil)
                        return
                    }

                    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {

                        let chooseLevelStorybard = UIStoryboard(name: Constant.Storyboard.chooseLevel, bundle: nil)
                        let chooseLevelViewController = chooseLevelStorybard.instantiateViewController(withIdentifier: Constant.Controller.chooseLevel) as? ChooseLevelViewController

                        appDelegate.window?.rootViewController = chooseLevelViewController
                    }
                })
            }
        })
    }

    /*
     *  For testing
     */
    @IBAction func logout(_ sender: Any) {

        if FIRAuth.auth()?.currentUser?.uid != nil {
            handleLogout()
        }
    }

}

// MARK: - Load Image and Set to ImageView
extension SportItemsViewController {

    func loadImage(imageUrlString: String, imageView: UIImageView) {

        var imageData: Data?

        let workItem = DispatchWorkItem {
            if let imageUrl = URL(string: imageUrlString) {
                do {
                    imageData = try Data(contentsOf: imageUrl)
                } catch {
                    self.errorHandle(errString: nil, error: error)
                }
            }
        }

        workItem.perform()

        let queue = DispatchQueue.global(qos: .default)

        queue.async(execute: workItem)

        workItem.notify(queue: DispatchQueue.main) {
            guard
                imageData != nil
                else { return }

            if let image = UIImage(data: imageData!) {
                imageView.image = image
            }

            self.loadingIndicator.stop()
        }
    }
}

// MARK: - Convert Image to grayscale
extension SportItemsViewController {

    func convertImageToBW(image: UIImage) -> UIImage {

        let filter = CIFilter(name: "CIPhotoEffectMono")

        // convert UIImage to CIImage and set as input

        let ciInput = CIImage(image: image)
        filter?.setValue(ciInput, forKey: "inputImage")

        // get output CIImage, render as CGImage first to retain proper UIImage scale

        let ciOutput = filter?.outputImage
        let ciContext = CIContext()
        let cgImage = ciContext.createCGImage(ciOutput!, from: (ciOutput?.extent)!)

        return UIImage(cgImage: cgImage!)
    }

}

// MARK: - Error handle
extension SportItemsViewController {

    func errorHandle(errString: String?, error: Error?) {

        if errString != nil {
            print("=== Error: \(String(describing: errString))")
        }

        if error != nil {
            print("=== Error: \(String(describing: error))")
        }

        loadingIndicator.stop()
    }
}
