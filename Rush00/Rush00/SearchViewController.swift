//
//  SearchViewController.swift
//  Rush00
//
//  Created by Bogdan DEOMIN on 2/9/20.
//  Copyright © 2020 Bogdan DEOMIN. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    
    
    var User: UserInfo?
    
    @IBOutlet weak var searchTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        //searchTF.autocorrectionType = .no
        // Do any additional setup after loading the view.
    }
    @IBAction func searchButton(_ sender: Any) {
        if let s = searchTF.text, !s.isEmpty, s.contains(" ")
        {
            let url = URL(string: "https://api.intra.42.fr/v2/users/\(s)/")
            var request = URLRequest(url: url!)
            request.httpMethod = "GET"
            request.setValue("Bearer " + catchToken!, forHTTPHeaderField: "Authorization")
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                (data, response, error) in
                guard error == nil && data != nil else { return }
                do {
                    var cursesName = [String]()
                    var cursesLvl = [Double]()
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                    if let firstName = json["first_name"] as? String{
                        let lastName = json["last_name"] as! String
                        let login = json["login"] as! String
                        let photo = json["image_url"] as! String
                        let cursus_users_array = (json["cursus_users"] as? [NSDictionary])!
                        
                        for c in cursus_users_array {
                            let name = (c["cursus"] as! NSDictionary)["name"] as! String
                            let level = (c["level"] as! Double)
                            cursesName.append(name)
                            cursesLvl.append(level)
                        }
                        self.User = UserInfo(firstName: firstName, lastName: lastName, login: login, photo: photo, curseName: cursesName, curseLvl: cursesLvl)
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "gotoUserVC", sender: nil)
                        }
                    } else {
                        self.presentError(mess: "User not found")
                    }
                } catch {
                    return
                }
            }
            task.resume()
        }
        else {
            presentError(mess: "Input some in fild")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIViewController {
    func presentError(mess: String){
        let error = UIAlertController(title: "Error", message: mess, preferredStyle: .alert)
        error.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(error, animated: true)
    }
}
