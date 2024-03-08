//
//  ViewController.swift
//  UICollection_1
//
//  Created by Настя Сарамуд on 05.03.2024.
//

import UIKit


class ViewController: UIViewController {
    
    var images = [UIImage]()
    
    let countCells = 3
    let offset: CGFloat = 2.0
    
    let imagePicker = ImagePicker()
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        for i in 1...5 {
            guard let image = UIImage(named: "IMG_\(i)") else { return }
            
            images.append(image)
        }
    }
    
    // MARK: - adding a photo
    
    @IBAction func pushSelectImageAction(_ sender: Any) {
        
        imagePicker.showImagePicker(in: self) {image in
            self.images.append(image)
            self.collectionView.reloadData()
            
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.detailSegue,
              let detailVC = segue.destination as? DetailViewController,
              let detailImage = sender as? UIImage else { return }
        
        detailVC.image = detailImage
    }
}


   // MARK: - Delegate, ViewDataSource, DelegateFlowLayout

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return images.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cell, for: indexPath) as! ImagesCollectionViewCell
        let image = images[indexPath.item]
        
        cell.photoView.image = image
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameCV = collectionView.frame
        let sellSize = frameCV.width / CGFloat(countCells)
        
        let spacing = CGFloat(countCells + 1) * offset / CGFloat(countCells)
        
        return CGSize(width: sellSize - spacing, height: sellSize - offset * 2)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = images[indexPath.row]
        performSegue(withIdentifier: Constants.detailSegue, sender: photo)
    }
}


private enum Constants {
    static let detailSegue = "detailPhoto"
    static let cell = "cellImage"
}
