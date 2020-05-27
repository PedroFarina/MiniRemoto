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
        // Initialization code
    }

    func setup() {
        
    }
    
    func setupContent() {
        self.inviteLabel.font = UIFont(name: "Montserrat-Medium", size: 16)
        self.inviteLabel.textColor = .black50()
        
        self.inviteImageView.image = UIImage(named: "invite")
        self.inviteImageView.tintColor = .black50()
    }
    
    func setupCollectionView() {
//        self
    }
    
}

extension InviteTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
    
}
