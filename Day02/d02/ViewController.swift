//
//  ViewController.swift
//  d02
//
//  Created by Mykola ZHURBA on 10/2/19.
//  Copyright © 2019 mzhurba. All rights reserved.
//

import UIKit


class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var table: UITableView!
    
    var info: [(String, String, String)] = [
        ("КолумбиЯ", "Murdered", "13 January 2069  11:25:13"),
        ("Moonsinger", "Slaughtered", "04 January 2053 13:22:33"),
        ("MrAmsterdam", "Suicide", "06 November 2044 00:00:01")
        ] {
        didSet {
            table.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! InfoTable
        cell.info = info[indexPath.row]
        cell.nameLbl?.numberOfLines = 0
        cell.descriptionLbl?.numberOfLines = 0
        cell.dateLbl?.numberOfLines = 0
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 100
        return cell
    }
    
    @IBAction func unWindSegue(segue: UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

