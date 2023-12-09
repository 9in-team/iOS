//
//  DocumentPicker.swift
//  NineInTeam
//
//  Created by 조상현 on 2023/07/31.
//

import SwiftUI
import Combine

struct DocumentPicker: UIViewControllerRepresentable {
     
    private var urlSubject: PassthroughSubject<URL?, Error> = .init()
    var urlPublisher: AnyPublisher<URL?, Error> {
        return urlSubject.eraseToAnyPublisher()
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(documentPicker: self)
    }

    func updateUIViewController(
        _ uiViewController: UIDocumentPickerViewController,
        context: UIViewControllerRepresentableContext<DocumentPicker>) {
    }
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let controller = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
//        controller.allowsMultipleSelection <- 이후 규칙에 따라 변경하기 (default false)
        controller.delegate = context.coordinator
        return controller
    }

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var documentPicker: DocumentPicker

        init(documentPicker: DocumentPicker) {
            self.documentPicker = documentPicker
        }

        // https://vapor3965.tistory.com/107
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            var outputFileURL: URL?
            var error: NSError?
            
            let coordinator = NSFileCoordinator()
                        
            let firstFileURL = urls[0]
            let isSecuredURL = (firstFileURL.startAccessingSecurityScopedResource() == true)
            coordinator.coordinate(readingItemAt: firstFileURL, options: [], error: &error) { (externalFileURL) -> Void in
                var url = URL(fileURLWithPath: NSTemporaryDirectory())
                url.appendPathComponent(externalFileURL.lastPathComponent)
                outputFileURL = url
            }
            if (isSecuredURL) {
                firstFileURL.stopAccessingSecurityScopedResource()
            }
            
            if error != nil {
                return
            }
                   
            if let outputFileURL = outputFileURL {
                documentPicker.urlSubject.send(outputFileURL)
            } else {
                documentPicker.urlSubject.send(nil)
            }
        }
    }
    
}
