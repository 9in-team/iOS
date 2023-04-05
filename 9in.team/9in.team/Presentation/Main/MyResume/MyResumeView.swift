//
//  MyResumeView.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/14.
//

import SwiftUI

struct MyResumeView: View {

    @StateObject var viewModel = MyResumeViewModel()
    
    @State var resumeList: [Resume] = [Resume(applyState: .waiting),
                                 Resume(applyState: .waiting),
                                 Resume(applyState: .waiting),
                                 Resume(applyState: .waiting)]
    
}

extension MyResumeView {
    
    var body: some View {
        BaseView(appState: viewModel.appState) {
            mainBody()
                .showNavigationBar(NavigationBar(useDismissButton: false, title: "9in.team"))
        }
    }
    
    func mainBody() -> some View {
        ScrollView {
            Rectangle()
                .frame(height: 0.1)
                .foregroundColor(Color.clear)
            
            ForEach(Array(zip(resumeList.indices, resumeList)), id: \.0) { index, resume in
                ResumeCellView(resume: resume)
                    .onTouch { location in
                        print("location :: \(location)")
                    }
            }
        }
        
        
        //            Group {
        //                if showAlert {
        //                    Rectangle()
        //                        .fill(Color(hexcode: "FFFFFF"))
        //                        .frame(width: 150, height: 90)
        //                        .overlay(
        //                            VStack {
        //                                Text("문의")
        //
        //                                Text("추가 제출")
        //
        //                                Button {
        //                                    showAlert = false
        //                                } label: {
        //                                    Text("닫기")
        //                                }
        //                            }
        //                        )
        //                        .rectangleShadows(firstX: 0, firstY: 3, secondX: 0, secondY: 8)
        //                }
        //           }
    }
                
}
