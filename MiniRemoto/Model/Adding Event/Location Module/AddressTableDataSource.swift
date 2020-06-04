//
//  AddressTableDataSource.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 27/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit
import MapKit

public class AddressTableDataSource: NSObject, UITableViewDataSource {
    let locationHelper = LocationHelper()
    private var addresses: [MKMapItem] = []
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell") as? LocationModuleTableViewCell {
            cell.mapItem = addresses[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }

    public func searchForAddress(_ address: String, didFind: @escaping(Int) -> Void) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = address
        if let region = locationHelper.currentRegion {
            request.region = region
        }
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if let response = response {
                self.addresses = Array(response.mapItems.prefix(5))
                didFind(self.addresses.count)
            }
        }
    }
}
