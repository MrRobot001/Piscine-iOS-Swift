//
//  ViewController.swift
//  Day03
//
//  Created by Bogdan DEOMIN on 2/7/20.
//  Copyright © 2020 Bogdan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var spiner: UIActivityIndicatorView!
    
    var selectedImage: UIImage?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.backgroundColor = UIColor.black
        cell.isHidden = false
        cell.spin.startAnimating()

        cell.myImage.load(url: URL(string: images[indexPath.item])!)
//        cell.isHidden = true
//        cell.spin.stopAnimating()
//        cell.spin.isHidden = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell
        
        selectedImage = cell?.myImage.image
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "imageItemSegue", sender: nil)
        }
        print(indexPath.item)
    }

    
    let images = ["https://cdn.intra.42.fr/users/large_bdeomin.jpg", "https://cdn.intra.42.fr/users/large_ozhadaie.jpg",
        "https://cdn.intra.42.fr/users/large_akasamar.jpg",
        "https://cdn.intra.42.fr/users/large_msaliuta.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? ImageViewController else { return }
        vc.image = self.selectedImage
    }
    
//    @IBOutlet weak var image: UIImageView!
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
