//
//  InviteTableViewCell.swift
//  MiniRemoto
//
//  Created by Felipe Petersen on 27/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class InviteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var inviteImageView: UIImageView!
    @IBOutlet weak var inviteLabel: UILabel!
    @IBOutlet weak var inviteCollectionView: UICollectionView!
    
    let PERSON_CELL = "PersonCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupContent()
        self.setupCollectionView()
    }

    func setup() {
        
    }
    
    func setupContent() {
        self.inviteLabel.font = UIFont(name: "Montserrat-Medium", size: 16)
        self.inviteLabel.textColor = .black50
        self.inviteLabel.text = "Convidados"
        
        self.inviteImageView.image = UIImage(named: "invite")
        self.inviteImageView.tintColor = .black50
    }
    
    func setupCollectionView() {
        self.inviteCollectionView.delegate = self
        self.inviteCollectionView.dataSource = self
        self.inviteCollectionView.register(UINib(nibName: PERSON_CELL, bundle: nil), forCellWithReuseIdentifier: PERSON_CELL)
        self.inviteCollectionView.showsHorizontalScrollIndicator = false
    }
    
}

extension InviteTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.inviteCollectionView.dequeueReusableCell(withReuseIdentifier: PERSON_CELL, for: indexPath) as! PersonCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 56, height: 56)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
