//
//  MyResumeView.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/14.
//

import SwiftUI

struct MyResumeView: View {

    @StateObject var viewModel = MyResumeViewModel()
    
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
            
            ResumeView(resume: Resume(applyState: .waiting))
            
            ResumeView(resume: Resume(applyState: .invited))
            
            ResumeView(resume: Resume(applyState: .rejected))
        }
    }
                
}