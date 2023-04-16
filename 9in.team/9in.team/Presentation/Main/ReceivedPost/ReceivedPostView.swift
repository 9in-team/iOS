//
//  ReceivedPost.swift
//  NineInTeam
//
//  Created by Heonjin Ha on 2023/04/10.
//

import SwiftUI
import WebKit

struct ReceivedPostView: View {

    enum ApprovalStatus {
        case none
        case apply
        case deny
    }

    private let navigationTitle = "받은 지원서"

    @StateObject private var viewModel = ReceivedPostViewModel()

    @State private var approvalStatus: ApprovalStatus = .none
    @State private var isApproved: Bool = false
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
            VStack(alignment: .leading, spacing: 13) {

                TextWithFont(text: "알고리즘 스터디원 구합니다", font: .regular, size: 24)

                contentView()
                    .padding(.horizontal, 12)
                    .overlay(content: {
                        isApproved
                        ? Color(hexcode: "000000").opacity(0.26)
                        : Color.clear
                    })
                    .cornerRadius(4)
                    .rectangleShadows(firstX: 0, firstY: 1, secondX: 0, secondY: 3)
                    .disabled(isApproved)
            }
            .padding(.horizontal, 20)
        }
    }

    func contentView() -> some View {
        Group {
            VStack(alignment: .leading, spacing: 0) {
                profileField()

                heightSpacer(20)

                postTemplateView()

                heightSpacer(15)

                approveButton()

                heightSpacer(20)

                if !isApproved || approvalStatus == .apply {
                    PostTextEditor(text: $message,
                                   isDisabled: isApproved && approvalStatus == .apply)
                    heightSpacer(20)
                }

                if isApproved == false {
                    sendMessageButton()
                    heightSpacer(20)
                }

                heightSpacer(10)
            }
        }
    }

    func profileField() -> some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    heightSpacer(15)

                    TextWithFont(text: "프론트엔드 개발자", font: .regular, size: 13)
                        .modifier(RoleLabel())
                    
                    heightSpacer(4)

                    TextWithFont(text: "1시간 전", font: .regular, size: 12)
                        .opacity(0.38)
                        .frame(height: 20)
                        .padding(.leading, 4)
                }

                Spacer()
                
                VStack(alignment: .center, spacing: 0) {
                    heightSpacer(12)

                    profileImage()
                        .frame(width: 40, height: 40)

                    TextWithFont(text: "여섯글자임..", font: .regular, size: 12)
                        .frame(width: 70, height: 20)
                }
                .frame(width: 70)
            }

            heightSpacer(10)

            Divider()
        }
    }

    func profileImage() -> some View {
        ZStack {
            Circle()
                .fill(Color(hexcode: "E0E0E0"))
            Image("Avatar")
                .resizable()
                .scaledToFit()
        }
    }

    func answerTextField() -> some View {
        VStack(alignment: .leading, spacing: 6) {
            TextWithFont(text: "답변", font: .bold, size: 12)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.6)
                )

            TextWithFont(text: "Ruby I", font: .regular, size: 16)
                .modifier(TextUnderLine())

        }
    }

    func postTemplateView() -> some View {
        VStack(alignment: .leading, spacing: 12) {

            answerTextField()
                .modifier(ApplyTemplate(question: "1. solved.ac 티어가 어떻게 되세요?"))

            RoundedRectangle(cornerRadius: 0)
                .fill(Color(hexcode: "D9D9D9"))
                .frame(height: 90)
                .overlay {
                    Image("Image")
                        .frame(width: 18, height: 18)
                }
                .modifier(ApplyTemplate(question: "2. solved.ac 프로필 사진 찍어주세요"))

            HStack {
                Image("File")
                    .resizable()
                    .frame(width: 16, height: 20)
                TextWithFont(text: "포트폴리오.pdf", font: .regular, size: 14)
            }
            .modifier(ApplyTemplate(question: "3. 포트폴리오 첨부해주세요"))

            HStack {
                Image("Choice")
                    .resizable()
                    .frame(width: 18, height: 18)

                TextWithFont(text: "네", font: .regular, size: 14)
            }
            .modifier(ApplyTemplate(question: "4. 열심히 하실거죠?"))
        }
    }

    func approveButton() -> some View {
        HStack(spacing: 0) {
            Rectangle()
                .fill(approvalStatus == .apply ? Color(hexcode: "1976D2") : Color(hexcode: "AEAEB2"))
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
                    if approvalStatus == .apply {
                        approvalStatus = .none
                    } else {
                        approvalStatus = .apply
                    }
                }

            Rectangle()
                .fill(Color(hexcode: "1565C0"))
                .frame(width: 1)

            Rectangle()
                .fill(approvalStatus == .deny ? Color(hexcode: "D32F2F") : Color(hexcode: "8E8E93"))
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
                    if approvalStatus == .deny {
                        approvalStatus = .none
                    } else {
                        approvalStatus = .deny
                    }
                }
        }
        .frame(height: 36)
        .cornerRadius(4)
        .rectangleShadows(firstX: 0, firstY: 1, secondX: 0, secondY: 2)
    }

    func sendMessageButton() -> some View {
        Button {
            switch approvalStatus {
            case .none:
                print("승인 또는 거절 눌러달라는 알럿 표시")
                return
            default:
                isApproved = true
            }
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
    }

    func textUnderLine() -> some View {
        Divider()
            .frame(height: 1)
            .foregroundColor(
                Color(hexcode: "000000")
                    .opacity(0.42)
            )
            .border(Color(hexcode: "000000").opacity(0.42), width: 1)
    }

    func heightSpacer(_ height: CGFloat) -> some View {
        Rectangle()
            .fill(.clear)
            .frame(height: height)
    }

}

struct ApplyTemplate: ViewModifier {

    let question: String

    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            TextWithFont(text: question, font: .regular, size: 14)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.6)
                )
            content
                .padding(.horizontal, 10)
        }
    }

}

struct TextUnderLine: ViewModifier {

    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 6.5) {
            content
            Divider()
                .frame(height: 1)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.42)
                )
                .border(Color(hexcode: "000000").opacity(0.42), width: 1)
        }
    }

}

struct RoleLabel: ViewModifier {

    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 10)
            .padding(.vertical, 7)
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(hexcode: "000000"))
                    .opacity(0.08)
            }
    }

}
