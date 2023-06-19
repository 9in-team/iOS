//
//  PhotoPicker.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/06/19.
//

import SwiftUI
import Combine

struct PhotoPicker: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    private var imageSubject: PassthroughSubject<UIImage, Error> = .init()
    var imagePublisher: AnyPublisher<UIImage, Error> {
        return self.imageSubject.eraseToAnyPublisher()
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<PhotoPicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<PhotoPicker>) { }
    
    func makeCoordinator() -> Coodinator {
        Coodinator(photoPicker: self)
    }
    
    final class Coodinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        var photoPicker: PhotoPicker
        
        init(photoPicker: PhotoPicker) {
            self.photoPicker = photoPicker
        }
        
        deinit {
            print("PhotoPicker Deinit")
        }
        
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            
            if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                self.photoPicker.imageSubject.send(image)
                print("DEBUG IMAGESUBJECT: \(image)")
            }
            
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}
