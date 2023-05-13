//
//  MySubscribeView.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/14.
//

import SwiftUI

struct MySubscribeView: View {

    @StateObject var viewModel = MySubscribeViewModel()
    
}

extension MySubscribeView {
    
    var body: some View {
        BaseView(appState: viewModel.appState) {
            mainBody()
                .showNavigationBar(NavigationBar(useDismissButton: false, title: "9in.team"))
        }
    }
    
    func mainBody() -> some View {
        VStack(spacing: 20) {
            NavigationLink {
                SubscribeTagView()
            } label: {
                subscribing()
            }
            .padding(.horizontal, 20)

            ScrollView {
                Rectangle()
                    .frame(height: 0.1)
                    .foregroundColor(Color.clear)

                ForEach(viewModel.subscribes, id: \.self) { subscriber in
                    SubscribeCellView(subscribe: subscriber)
                        .padding(.horizontal, 20)
                }

            }
        }
    }
    
    func subscribing() -> some View {
        VStack(spacing: 4) {
            TextWithFont(text: "구독중", font: .bold, size: 14)
                .foregroundColor(ColorConstant.main.color())
                .multilineTextAlignment(.center)
            
            HStack {
                VStack(alignment: .center) {
                    TextWithFont(text: "스터디", font: .medium, size: 14)
                    
                    TextWithFont(text: "3", font: .medium, size: 14)
                }
                .frame(maxWidth: .infinity)
                .foregroundColor(ColorConstant.main.color())
                
                Rectangle()
                    .frame(width: 1, height: 47)
                    .foregroundColor(
                        ColorConstant.main.color()
                            .opacity(0.5)
                    )
                
                VStack(alignment: .center) {
                    TextWithFont(text: "프로젝트", font: .medium, size: 14)
                    
                    TextWithFont(text: "7", font: .medium, size: 14)
                }
                .frame(maxWidth: .infinity)
                .foregroundColor(ColorConstant.main.color())
            }
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(ColorConstant.main.color().opacity(0.5),
                            lineWidth: 1)
            )
        }
    }
                
}

#if DEBUG
struct MySubscribeView_Previews: PreviewProvider {
    static var previews: some View {

        NavigationView {
            MySubscribeView()
        }

    }
}
#endif
