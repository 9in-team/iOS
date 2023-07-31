//
//  DocumentPicker.swift
//  NineInTeam
//
//  Created by 조상현 on 2023/07/31.
//

import SwiftUI
import Combine

struct DocumentPicker: UIViewControllerRepresentable {
     
    private var urlSubject: PassthroughSubject<URL, Error> = .init()
    var urlPublisher: AnyPublisher<URL, Error> {
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
        controller.delegate = context.coordinator
        return controller
    }

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var documentPicker: DocumentPicker

        init(documentPicker: DocumentPicker) {
            self.documentPicker = documentPicker
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let url = urls.first, url.startAccessingSecurityScopedResource() else { return }
            defer { url.stopAccessingSecurityScopedResource() }
            documentPicker.urlSubject.send(urls[0])       
        }
    }
    
}
