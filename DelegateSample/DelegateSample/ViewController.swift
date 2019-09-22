//
//  ViewController.swift
//  DelegateSample
//
//  Created by R.miyamoto on 2019/09/16.
//  Copyright © 2019 R.Miyamoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CustomCellDelegate {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        }
    }
    
    private let dataSource: [String] = ["item1", "item2", "item3", "item4", "item5", "item6", "item7", "item8", "item9", "item10"]
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell else { return UITableViewCell() }
        cell.label.text = dataSource[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    
    // MARK: - CustomCellDelegate
    
    func tapCellButton(from cell: CustomCell) {
        guard let text = cell.label.text else { return }
        print(text)
    }
}
