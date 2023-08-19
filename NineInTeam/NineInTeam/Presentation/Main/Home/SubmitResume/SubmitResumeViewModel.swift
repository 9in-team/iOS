//
//  SubmitResumeViewModel.swift
//  NineInTeam
//
//  Created by 조상현 on 2023/07/19.
//

import UIKit
import Combine

class SubmitResumeViewModel: BaseViewModel {
    
    private var service: NetworkProtocol
    
    @Published var teamDetail: TeamDetail?
    
    @Published var selectedRole: RecruitmentRole? = nil
    
    @Published var answerText: String = ""
    @Published var answerImage: UIImage? = nil
    @Published var answerFileList: [URL] = []
    @Published var answerChoice: String = ""
    
    init(service: NetworkProtocol = NetworkService()) {
        self.service = service
    }
    
    func submit() {
        willStartLoading()
            
        uploadPDF { [weak self] url, error in
            if let _ = error {
                self?.showToast(title: "파일 업로드를 실패했습니다.")
            }
            
            // 이후 작업
            self?.didFinishLoading()
        }
    }
    
    func selectedFile(_ result: Result<[URL], Error>) {
        switch result {
        case .success(let urls):
            guard let url = urls.first else {
                showToast(title: "파일 선택 실패")
                return
            }
             
            answerFileList.append(url)                               
        case .failure(_):
            showToast(title: "파일 선택 실패")
        }
    }
    
    // TODO: PDF 파일 단일 선택인지 복수 선택인지에 따라 비동기 처리하기
    private func uploadPDF(completion: @escaping (URL?, Error?) -> Void) {
        for url in answerFileList {
            let folder = FirebaseStorageManager.resumePDF
            let fileName = url.lastPathComponent
            let path = "\(folder)/\(fileName)"
                        
            if !url.startAccessingSecurityScopedResource() {
                completion(nil, FileError.fileAccessFailed)
                return
            }
            
            if let data = url.toData() {
                url.stopAccessingSecurityScopedResource()
                FirebaseStorageManager.uploadPDF(data, path: path) { resultUrl, error in
                    if error != nil {
                        return
                    }
                    
                    completion(resultUrl, error)
                }
            } else {
                completion(nil, FileError.fileConvertError)
                return
            }
        }
    }
            
}
