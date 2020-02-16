//
//  SecondViewController.swift
//  d02
//
//  Created by Mykola ZHURBA on 10/3/19.
//  Copyright © 2019 mzhurba. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var nameLbl: UITextField!
    @IBOutlet weak var descLbl: UITextView!
    @IBOutlet weak var dateLbl: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.descLbl.layer.borderWidth = 1
        self.descLbl.layer.cornerRadius = 15
        self.descLbl.layer.borderColor = UIColor.lightGray.cgColor
        // Do any additional setup after loading the view.
    }
    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        if let name = self.nameLbl.text {
            print("Name: " + name)
        }
        if let desc = self.descLbl.text {
            print("Description: " + desc)
        }
        let format = DateFormatter()
        format.dateFormat = "dd MMMM yyyy HH:mm:ss"
        let date = format.string(from: self.dateLbl.date)
        print(date)
        let currDate = Date()
        if self.nameLbl.text != "" && currDate < self.dateLbl.date {
            performSegue(withIdentifier: "done", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let format = DateFormatter()
        format.dateFormat = "dd MMMM yyyy HH:mm:ss"
        let date = format.string(from: self.dateLbl.date)
        let destination = segue.destination as! FirstViewController
        destination.info.append((self.nameLbl.text!, self.descLbl.text!, date))
        print(destination.info)
    }
    
}
