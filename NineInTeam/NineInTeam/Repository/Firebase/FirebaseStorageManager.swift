//
//  FirebaseStorageManager.swift
//  9in.team
//
//  Created by 조상현 on 2023/02/26.
//

import UIKit
import FirebaseStorage
import Firebase

class FirebaseStorageManager {
    
    static let kProfileImage = "ProfileImage"
    static let kResumePDF = "ResumePDF"
    
    static func uploadImage(imageData: Data, path: String, completion: @escaping (URL?, Error?) -> Void) {
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        
        let firebaseReference = Storage.storage().reference().child("\(path)")
        
        firebaseReference.putData(imageData, metadata: metaData) { _, error in
            if let error = error {
                completion(nil, error)
            } else {
                firebaseReference.downloadURL { url, error in
                    if let error = error {
                        completion(nil, error)
                    } else {
                        completion(url, nil)
                    }
                }
            }
        }
    }
    
    static func downloadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        let storageReference = Storage.storage().reference(forURL: urlString)
        let megaByte = Int64(1 * 1024 * 1024)
        
        storageReference.getData(maxSize: megaByte) { data, _ in
            guard let imageData = data else {
                completion(nil)
                return
            }
            completion(UIImage(data: imageData))
        }
    }
    
    static func deleteImage(urlString: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let storageReference = Storage.storage().reference(forURL: urlString)
        
        storageReference.delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    static func uploadPDF(url: URL, path: String, completion: @escaping (URL?, Error?) -> Void) {
        let firebaseReference = Storage.storage().reference().child("\(path)")
        firebaseReference.putFile(from: url, metadata: nil) { metadata, error in
            guard let _ = metadata else {
                completion(nil, error)
                return
            }
            // TODO: 사이즈 제한이 필요하다면 체크
//            let size = metadata.size
            
            firebaseReference.downloadURL { url, error in
                if let error = error {
                    completion(nil, error)
                } else {
                    completion(url, nil)
                }
            }
        }
    }
    
}
