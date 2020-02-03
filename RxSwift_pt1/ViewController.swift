//
//  ViewController.swift
//  RxSwift_pt1
//
//  Created by Adriano Ramos on 12/01/20.
//  Copyright © 2020 Adriano Ramos. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    
    // MARK: - Variables
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var applyFilterButton: UIButton!
    
    override var prefersHomeIndicatorAutoHidden: Bool { return true }
    
    // MARK: - RxSwift Dispose Bag
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Perform Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let navC = segue.destination as? UINavigationController, let photosCVC = navC.viewControllers.first as? PhotosCollectionViewController else { fatalError("Segue destination is not found") }
        
        photosCVC.selectedPhoto.subscribe(onNext: { [weak self] (photo) in
            
            DispatchQueue.main.async {
                self?.updateUI(with: photo)
            }
            }).disposed(by: disposeBag)
    }
    
    // MARK: - Display button to apply filter when a photo is selected from camera roll
    private func updateUI(with image: UIImage) {
        self.imageView.image = image
        self.applyFilterButton.isHidden = false
    }
    
    // MARK: Actions
    @IBAction func applyFilterPressed() {
        guard let sourceImage = self.imageView.image else { return }
        
        FilterService().applyFilter(to: sourceImage)
            .subscribe(onNext: { filteredImage in
                DispatchQueue.main.async {
                    self.imageView.image = filteredImage
                }
            }).disposed(by: disposeBag)
        
        // MARK: - Without using filtered image as observable
//        FilterService().applyFilter(to: sourceImage) { (filteredImage) in
//            DispatchQueue.main.async {
//                self.imageView.image = filteredImage
//            }
//        }
        
    }
    
}
