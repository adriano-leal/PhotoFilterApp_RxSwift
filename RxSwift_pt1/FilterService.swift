//
//  FilterService.swift
//  RxSwift_pt1
//
//  Created by Adriano Ramos on 02/02/20.
//  Copyright © 2020 Adriano Ramos. All rights reserved.
//

import UIKit
import CoreImage
import RxSwift
import RxCocoa

class FilterService {
    
    private var context: CIContext
    
    init() {
        self.context = CIContext()
    }
    
    func applyFilter(to inputImage: UIImage) -> Observable<UIImage> {
        return Observable<UIImage>.create { observer in
            self.applyFilter(to: inputImage) { (filteredImage) in
                observer.onNext(filteredImage)
            }
            return Disposables.create()
        }
    }
    
    func applyFilter(to inputtImage: UIImage, completion: @escaping ((UIImage) -> ())) {
        
        let filter = CIFilter(name: "CICMYKHalftone")!
        filter.setValue(4.0, forKey: kCIInputWidthKey)
        
        if let sourceImage = CIImage(image: inputtImage) {
            filter.setValue(sourceImage, forKey: kCIInputImageKey)
            
            if let cgimg = self.context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent) {
                let processedImage = UIImage(cgImage: cgimg, scale: inputtImage.scale, orientation: inputtImage.imageOrientation)
                completion(processedImage)
            }
        }
        
    }
    
}
