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
                                       Resume(applyState: .invited),
                                       Resume(applyState: .rejected),
                                       Resume(applyState: .waiting)]
        
    @State var showAlert: Bool = false
    @State var selectedIndex: Int = 0
    @State var alertPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    func closeAlert() {
        showAlert = false
        selectedIndex = 0
        alertPoint = CGPoint(x: 0, y: 0)
    }
    
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
                    .onTouch { point in
                        showAlert = true
                        selectedIndex = index
                        alertPoint = point
                    }
            }
        }
        .overlay(resumeCellViewAlert())
    }
    
    func resumeCellViewAlert() -> some View {
        Group {
            if showAlert {
                ZStack {
                    Color.white
                        .opacity(0.01)
                        .onTapGesture {
                            closeAlert()
                        }
                    
                    VStack {
                        HStack {
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color(hexcode: "FFFFFF"))
                                .frame(width: 150, height: 90)
                                .overlay(
                                    VStack {
                                        Button {
                                            
                                        } label: {
                                            HStack(alignment: .center, spacing: 10) {
                                                HStack {
                                                    Image("Enquiry")
                                                        .resizable()
                                                        .frame(width: 18, height: 14)
                                                        .foregroundColor(
                                                            Color(hexcode: "000000")
                                                                .opacity(0.54)
                                                        )
                                                }
                                                .frame(width: 30)
                                                
                                                TextWithFont(text: "문의", font: .regular, size: 16)
                                                    .foregroundColor(
                                                        Color(hexcode: "000000")
                                                            .opacity(0.87)
                                                    )
                                                
                                                Spacer()
                                            }
                                            .frame(maxWidth: .infinity)
                                        }
                                        
                                        Button {
                                             
                                        } label: {
                                            HStack(alignment: .center, spacing: 10) {
                                                HStack {
                                                    Image("Plus")
                                                        .resizable()
                                                        .frame(width: 14, height: 14)
                                                        .foregroundColor(
                                                            Color(hexcode: "000000")
                                                                .opacity(0.54)
                                                        )
                                                }
                                                .frame(width: 30)
                                                
                                                TextWithFont(text: "추가 제출", font: .regular, size: 16)
                                                    .foregroundColor(
                                                        Color(hexcode: "000000")
                                                            .opacity(0.87)
                                                    )
                                                
                                                Spacer()
                                            }
                                            .frame(maxHeight: .infinity)
                                        }
                                    }
                                    .padding(14)
                                )
                                .rectangleShadows(firstX: 0, firstY: 3, secondX: 0, secondY: 8)
                                .offset(x: alertPoint.x, y: alertPoint.y)
                            
                            Spacer()
                        }
                        
                        Spacer()
                    }
                }
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
                .ignoresSafeArea()
            }
       }
    }
                
}
