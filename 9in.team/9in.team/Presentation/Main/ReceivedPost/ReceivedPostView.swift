//
//  ReceivedPost.swift
//  NineInTeam
//
//  Created by Heonjin Ha on 2023/04/10.
//

import SwiftUI
import WebKit

struct ReceivedPostView: View {

    enum Options {
        case none
        case apply
        case deny
    }

    let navigationTitle = "받은 지원서"

    @StateObject private var viewModel = ReceivedPostViewModel()

    @State private var selectedButton: Options = .none
    @State private var message: String = "저희 같이 스터디 잘 해봐요 :) 전달된 채팅방 링크 통해서 들어와주세요!"

}

extension ReceivedPostView {

    var body: some View {
        BaseView(appState: viewModel.appState) {
            mainBody()
        }
        .showNavigationBar(NavigationBar(useDismissButton: true, title: navigationTitle))
        .ignoresSafeArea(edges: [.bottom, .horizontal])

    }

    func mainBody() -> some View {
        ScrollView(showsIndicators: false) {

            ZStack(alignment: .leading) {

                VStack(alignment: .leading, spacing: 13) {

                    TextWithFont(text: "알고리즘 스터디원 구합니다", font: .regular, size: 24)
                        .padding(.horizontal, 12)

                    ZStack {
                        VStack(alignment: .leading, spacing: 0) {

                            profileField
                                .padding(.top, 5)
                                .padding(.bottom, 12)

                            Divider()
                                .padding(.bottom, 10)

                            answerView()
                                .padding(.bottom, 15)

                            choiceButton

                            Rectangle()
                                .fill(.clear)
                                .frame(height: 20)

                            PostTextEditor(text: $message)

                            Rectangle()
                                .fill(.clear)
                                .frame(height: 20)

                            Button {
                                print("메세지 전송")
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color(hexcode: "42A5F5"))
                                    ZStack {
                                        TextWithFont(text: "메시지 전송", font: .medium, size: 15)
                                            .foregroundColor(Color(hexcode: "FFFFFF"))
                                            .padding(.horizontal, 22)
                                            .padding(.vertical, 8)
                                    }
                                    .frame(width: 120, height: 42)

                                }
                            }
                            .padding(.bottom, 20)
                        }
                        .padding(.horizontal, 12)

                    }
                    .rectangleShadows(firstX: 0, firstY: 1, secondX: 0, secondY: 3)
                    .padding(.horizontal, 12)

                }

            }

        }
    }

    var profileField: some View {
        HStack {
            VStack(alignment: .leading) {
                roleLabel(title: "프론트엔드 개발자")
                TextWithFont(text: "1시간 전", font: .regular, size: 12)
                    .padding(.leading, 4)
                    .opacity(0.38)
            }
            Spacer()
            VStack(spacing: 0) {
                profileImage()
                TextWithFont(text: "여섯글자임..", font: .regular, size: 12)
                    .frame(width: 70, height: 20)
            }
        }
    }

    func roleLabel(title: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hexcode: "000000"))
                .opacity(0.08)
            Text(title)
                .font(.system(size: 13))
                .padding(.horizontal, 10)
                .padding(.vertical, 7)
        }
        .frame(width: 121, height: 32)
    }

    func profileImage() -> some View {
        ZStack {
            Circle()
                .fill(Color(hexcode: "E0E0E0"))
            Image("Avatar")
                .resizable()
                .scaledToFit()
        }
        .frame(width: 40, height: 40)

    }

    func questionLabel(text: String) -> some View {
        TextWithFont(text: text, font: .regular, size: 14)
            .foregroundColor(
                Color(hexcode: "000000")
                    .opacity(0.6)
            )
    }

    func answerField() -> some View {
        VStack(alignment: .leading, spacing: 6) {
            TextWithFont(text: "답변", font: .bold, size: 12)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.6)
                )
            TextWithFont(text: "Ruby I", font: .regular, size: 16)

            divider()
        }
    }

    func divider() -> some View {
        Rectangle()
            .fill(Color(hexcode: "000000").opacity(0.42))
            .frame(height: 1)
    }

    func answerView() -> some View {
        VStack(alignment: .leading, spacing: 12) {

            questionLabel(text: "1. solved.ac 티어가 어떻게 되세요?")

            answerField()
                .padding([.top, .horizontal], 10)

            questionLabel(text: "2. solved.ac 프로필 사진 찍어주세요")

            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color(hexcode: "D9D9D9"))
                    .frame(height: 90)
                Image("Image")
                    .frame(width: 18, height: 18)
            }
            .padding(.horizontal, 12)

            questionLabel(text: "3. 포트폴리오 첨부해주세요")
            HStack {
                Image("File")
                    .resizable()
                    .frame(width: 16, height: 20)

                TextWithFont(text: "포트폴리오.pdf", font: .regular, size: 14)
            }
            .padding(.horizontal, 12)

            questionLabel(text: "4. 열심히 하실거죠?")

            HStack {
                Image("Choice")
                    .resizable()
                    .frame(width: 18, height: 18)

                TextWithFont(text: "네", font: .regular, size: 14)
            }
            .padding([.horizontal], 9)
        }
    }

    var choiceButton: some View {
        HStack(spacing: 0) {
            Rectangle()
                .fill(selectedButton == .apply ? Color(hexcode: "1976D2") : Color(hexcode: "AEAEB2"))
                .overlay {
                    HStack {
                        Image("Check")
                            .resizable()
                            .frame(width: 15, height: 12)
                        TextWithFont(text: "승인", font: .medium, size: 14)
                            .foregroundColor(Color(hexcode: "FFFFFF"))
                    }
                }
                .onTapGesture {
                    if selectedButton == .apply {
                        selectedButton = .none
                    } else {
                        selectedButton = .apply
                    }
                }
            Rectangle()
                .fill(Color(hexcode: "1565C0"))
                .frame(width: 1)

            Rectangle()
                .fill(selectedButton == .deny ? Color(hexcode: "D32F2F") : Color(hexcode: "8E8E93"))
                .overlay {
                    HStack {
                        Image("Xmark")
                            .resizable()
                            .frame(width: 12, height: 12)
                        TextWithFont(text: "거절", font: .medium, size: 14)
                            .foregroundColor(Color(hexcode: "FFFFFF"))
                    }
                }
                .onTapGesture {
                    if selectedButton == .deny {
                        selectedButton = .none
                    } else {
                        selectedButton = .deny
                    }
                }
        }
        .frame(height: 36)
        .cornerRadius(4, corners: .allCorners)
        .rectangleShadows(firstX: 0, firstY: 1, secondX: 0, secondY: 2)
    }

}
