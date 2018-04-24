//
//  UIImage.swift
//  buynothing
//
//  Created by Jake Romer on 4/11/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import Alamofire
import AlamofireImage
import UIKit

typealias ImageCompletion = (UIImage?) -> Void

extension UIImage {
    /// Download and image from url URLSTRING, yield it to the 
    /// COMPLETION handler.
    ///
    /// Yet to be implemented:
    /// Optionally cache it under CACHEKEY.
    static func fromURL(url urlString: String, cacheKey: String? = nil,
                        completion: @escaping ImageCompletion) {

        Alamofire.request(urlString).responseImage { response in
            if let image = response.result.value {
                completion(image)
            }
        }
    }

    /// Return the path of the given image on the local file system
    var path: URL {
        if let docsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return docsDirectory.appendingPathComponent("image")
        } else {
            fatalError("Error accessing documents directory")
        }
    }
}
