//
//  UIImage.swift
//  9in.team
//
//  Created by 조상현 on 2023/01/13.
//

import UIKit

extension UIImage {
           
    public var png: Data? {
        return self.pngData()
    }
    
    public var jpeg: Data? {
        return self.jpegData(compressionQuality: 1.0)
    }
    
}
