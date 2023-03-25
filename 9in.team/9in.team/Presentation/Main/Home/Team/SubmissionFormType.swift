//
//  SubmissionFormType.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/24.
//

import CoreFoundation

enum SubmissionFormType {
    
    case text
    case image
    case file
    case choice
    
    func asset() -> String {
        switch self {
        case .text:
            return "Text"
        case .image:
            return "Image"
        case .file:
            return "File"
        case . choice:
            return "Choice"
        }
    }
    
    func assetSize() -> CGSize {
        switch self {
        case .text:
            return CGSize(width: 19, height: 15)
        case .image:
            return CGSize(width: 18, height: 18)
        case .file:
            return CGSize(width: 16, height: 20)
        case . choice:
            return CGSize(width: 18, height: 18)
        }
    }
    
    func text() -> String {
        switch self {
        case .text:
            return "텍스트"
        case .image:
            return "이미지"
        case .file:
            return "파일"
        case . choice:
            return "선택"
        }
    }
    
}
