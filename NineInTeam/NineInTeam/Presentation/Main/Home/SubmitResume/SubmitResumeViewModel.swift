//
//  SubmitResumeViewModel.swift
//  NineInTeam
//
//  Created by 조상현 on 2023/07/19.
//

import Foundation
import Combine
import UIKit

class SubmitResumeViewModel: BaseViewModel {
    
    private var service: NetworkProtocol
    
    @Published var teamDetail: TeamDetail?
    
    @Published var answerText: String = ""
    @Published var answerImage: UIImage? = nil
    @Published var answerFileList: [URL] = []
    @Published var answerChoice: String = ""
    
    init(service: NetworkProtocol = NetworkService()) {
        self.service = service
    }
    
    func submit() {
        uploadPDF() { url, error in
            if let error = error {
                print("error : \(error.localizedDescription)")
            }
            
            print("url : \(String(describing: url))")
        }
    }
    
    // TODO: PDF 파일 단일 선택인지 복수 선택인지에 따라 비동기 처리하기
    private func uploadPDF(completion: @escaping (URL?, Error?) -> Void) {
        let folder = FirebaseStorageManager.kResumePDF
        
        for url in answerFileList {
            let fileName = url.lastPathComponent
            let path = "\(folder)/\(fileName)"
            
            FirebaseStorageManager.uploadPDF(url: url, path: path) { [weak self] url, error in
                if error != nil {
                    self?.showToast(title: "파일 업로드를 실패했습니다.")
                }
                
                completion(url, error)
            }
        }
    }
            
}
