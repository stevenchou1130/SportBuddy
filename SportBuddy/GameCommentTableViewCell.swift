//
//  GameCommentTableViewCell.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/5/4.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit
import Firebase

protocol CommentCallDelegate: class {
    func showAlert(title: String, message: String)
}

class GameCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var commentMainView: UIView!
    @IBOutlet weak var commentTitleLabel: UILabel!
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var commentButton: UIButton!

    class var identifier: String { return String(describing: self) }

    weak var commentDelegate: CommentCallDelegate?

    static let defaultHeight: CGFloat = 40.0
    static let height: CGFloat = 300.0

    var currentUser: String?
    var game: BasketballGame?

    var comments: [GameComment] = []

    override func awakeFromNib() {
        super.awakeFromNib()

        commentTableView.dataSource = self
        commentTableView.delegate = self

        getUser()
        initNib()
        setView()
    }

    func getUser() {

        guard
            let uid = FIRAuth.auth()?.currentUser?.uid
            else { return }

        currentUser = uid
    }

    func initNib() {

        let commentNib = UINib(nibName: CommentDetailTableViewCell.identifier, bundle: nil)
        commentTableView.register(commentNib, forCellReuseIdentifier: CommentDetailTableViewCell.identifier)
    }

    func setView() {

        commentTableView.separatorStyle = .none

        commentTitleLabel.textColor = .white

        commentTextField.backgroundColor = .clear
        commentTextField.layer.cornerRadius = 8.0
        commentTextField.layer.masksToBounds = true
        commentTextField.layer.borderColor = UIColor.gray.cgColor
        commentTextField.layer.borderWidth = 2.0
        commentTextField.textColor = .white

        commentButton.tintColor = .white
        commentButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)

        moveToLastComment()
    }

    func sendMessage() {
        print("=== sendMessage ===")

        guard
            let gameID = game?.gameID
            else { return }

        print("gameID: \(gameID)")

        if commentTextField.text == "" {
            self.commentDelegate?.showAlert(title: "訊息", message: "請輸入留言內容")
        } else {
            saveComment(gameID)
            commentTextField.text = ""
        }

    }

    func saveComment(_ gameID: String) {

        let ref = FIRDatabase.database().reference()
            .child(Constant.FirebaseGameMessage.nodeName)
            .child(gameID)
            .childByAutoId()

        let value: [String: String] = [Constant.FirebaseGameMessage.userID: currentUser!,
                     Constant.FirebaseGameMessage.comment: commentTextField.text!]

        ref.updateChildValues(value) { (error, _) in
            if error != nil {
                print("=== Error in GameCommentTableViewCell: \(String(describing: error))")
            }
        }

        let comment = GameComment(commentOwner: currentUser!, comment: commentTextField.text!)
        comments.append(comment)

        commentTableView.beginUpdates()
        commentTableView.insertRows(at: [IndexPath(row: comments.count - 1, section: 0)], with: .automatic)
        commentTableView.endUpdates()

        commentTableView.reloadData()
        moveToLastComment()
    }

    func moveToLastComment() {
        if commentTableView.contentSize.height > commentTableView.frame.height {
            // First figure out how many sections there are
            let lastSectionIndex = commentTableView.numberOfSections - 1
            // Then grab the number of rows in the last section
            let lastRowIndex = commentTableView.numberOfRows(inSection: lastSectionIndex) - 1
            // Now just construct the index path
            let pathToLastRow = NSIndexPath(row: lastRowIndex, section: lastSectionIndex)
            // Make the last row visible
            commentTableView.scrollToRow(at: pathToLastRow as IndexPath, at: UITableViewScrollPosition.bottom, animated: true)
        }
    }
}

// MARK: - TableView
extension GameCommentTableViewCell: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let identifier = CommentDetailTableViewCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? CommentDetailTableViewCell

        cell?.selectionStyle = .none

        cell?.userImage.layer.cornerRadius = (cell?.userImage.bounds.size.height)! / 2.0
        cell?.userImage.layer.masksToBounds = true

        cell?.comment.text = comments[indexPath.row].comment

        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        print("indexPath: \(indexPath.row)")
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        guard
            let commentCell = cell as? CommentDetailTableViewCell
            else { return }

        commentCell.userImage.layer.cornerRadius = commentCell.userImage.bounds.size.height / 2.0
        commentCell.userImage.layer.masksToBounds = true
    }
}
