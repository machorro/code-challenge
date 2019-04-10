//
//  ImageLoader.swift
//  App
//
//  Copyright © 2019 Code Coding Challenge. All rights reserved.
//

import Foundation

public class ImageLoader {
    
    public init() {}
    
    @discardableResult
    public func loadImage(from url: URL, _ handler: @escaping (UIImage?) -> Void) -> URLSessionTask {
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let _ = error {
                handler(nil)
                return
            }
            
            guard let data = data else {
                handler(nil)
                return
            }
            
            let image = UIImage(data: data)
            handler(image)
        }
        
        task.resume()
        
        return task
    }
}
