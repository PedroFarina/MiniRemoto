//
//  ModuleCollectionViewDataSource.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 19/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class ModuleCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var modules: [Module] = [CalendarData(), LocationData(), InviteData(), ListData()]

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modules.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let moduleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "moduleCell", for: indexPath) as? ModuleCollectionViewCell {
            moduleCell.module = modules[indexPath.row]
            return moduleCell
        }
        return UICollectionViewCell()
    }

}
