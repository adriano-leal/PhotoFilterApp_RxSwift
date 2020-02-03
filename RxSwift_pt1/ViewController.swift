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
    
    @IBOutlet weak var imageView: UIImageView!
    
    // Rx
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let navC = segue.destination as? UINavigationController, let photosCVC = navC.viewControllers.first as? PhotosCollectionViewController else { fatalError("Segue destination is not found") }
        
        photosCVC.selectedPhoto.subscribe(onNext: { [weak self] (photo) in
            self?.imageView.image = photo
            }).disposed(by: disposeBag)
    }
    
}
