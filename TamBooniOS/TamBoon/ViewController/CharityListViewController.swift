//
//  CharityListViewController.swift
//  TamBoon
//
//  Created by hiroshi on 2020/09/16.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import UIKit

class CharityListViewController: UIViewController {

    @IBOutlet weak var charityTableView: UITableView!
    
    var charityList: CharityList? {
        didSet {
            DispatchQueue.main.async {
                self.charityTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCharityTable()
        
        APIAccess.getCharities(completion: { (charityList) in
            self.charityList = charityList
        })
    }
    
    func setupCharityTable()  {
        charityTableView.delegate = self
        charityTableView.dataSource = self
    }
}

extension CharityListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charityList?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharityTableViewCell", for: indexPath) as? CharityTableViewCell else {
            fatalError("Cell identifer is not correct!")
        }
        
        if let charityInfo = charityList?.data[indexPath.row] {
            cell.textLabel?.text = charityInfo.name
        }
        
        return cell
    }
}
