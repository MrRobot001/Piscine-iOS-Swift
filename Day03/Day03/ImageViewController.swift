//
//  ImageViewController.swift
//  Day03
//
//  Created by Bogdan DEOMIN on 2/7/20.
//  Copyright © 2020 Bogdan. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    var imageView: UIImageView!
    var image: UIImage!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView = UIImageView(image: image)
        scrollView.delegate = self
        scrollView.addSubview(imageView!)
        scrollView.maximumZoomScale = 100
        scrollView.minimumZoomScale = 0.3
        // Do any additional setup after loading the view.
    }
    
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
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
