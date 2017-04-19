//
//  MembersTableViewCell.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/4/19.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit

class MembersTableViewCell: UITableViewCell, Identifiable {

    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: Property

    class var identifier: String { return String(describing: self) }

    static let height: CGFloat = 180.0

    var game: BasketballGame?

    let fullScreenSize = UIScreen.main.bounds.size

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        collectionView.dataSource = self
        collectionView.delegate = self

        let memberNib = UINib(nibName: MemberCollectionViewCell.identifier, bundle: nil)
        collectionView.register(memberNib, forCellWithReuseIdentifier: MemberCollectionViewCell.identifier)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension MembersTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 10
    }

    // swiftlint:disable force_cast
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemberCollectionViewCell.identifier, for: indexPath) as! MemberCollectionViewCell

        cell.userImage.layer.cornerRadius = cell.userImage.bounds.size.height / 2.0
        cell.userImage.layer.masksToBounds = true

        return cell
    }
    // swiftlint:enable force_cast

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        guard
            let memberCell = cell as? MemberCollectionViewCell
            else { return }

        memberCell.userImage.layer.cornerRadius = memberCell.userImage.bounds.size.height / 2.0
        memberCell.userImage.layer.masksToBounds = true
    }

    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let size = fullScreenSize.width / 4
        return CGSize(width: size, height: size)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        return sectionInsets
    }
}
