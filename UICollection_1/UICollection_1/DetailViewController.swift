//
//  DetailViewController.swift
//  UICollection_1
//
//  Created by Настя Сарамуд on 08.03.2024.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var image: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = image 
       
    }

}
