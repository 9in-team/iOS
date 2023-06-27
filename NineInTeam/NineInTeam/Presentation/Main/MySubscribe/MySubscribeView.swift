//
//  MySubscribeView.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/14.
//

import SwiftUI

struct MySubscribeView: View {

    @EnvironmentObject var coordinator: Coordinator
    
    @StateObject var viewModel = MySubscribeViewModel()
    
}

extension MySubscribeView {
    
    var body: some View {
        BaseView(appState: viewModel.appState, coordinator: coordinator) {
            mainBody()
                .showNavigationBar(NavigationBar(coordinator: coordinator,
                                                 useDismissButton: false,
                                                 title: "9in.team"))
        }
    }
    
    func mainBody() -> some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 20) {
                Button {
                    coordinator.push(destination: .subscribeTag)
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
                        
            Button {
                coordinator.push(destination: .myWish)
            } label: {
                Circle()
                    .frame(width: 56, height: 56)
                    .foregroundColor(
                        Color(hexcode: "9C27B0")
                    )
                    .circleShadows([Shadow(color: .black, opacity: 0.12, radius: 18, locationY: 1),
                                    Shadow(color: .black, opacity: 0.14, radius: 10, locationY: 6),
                                    Shadow(color: .black, opacity: 0.2, radius: 5, locationY: 3)])
                    .overlay(
                        Image("Like")
                            .resizable()
                            .frame(width: 20, height: 18)
                    )
            }
            .padding(.trailing, 14)
        }
    }
    
    func subscribing() -> some View {
        VStack(spacing: 4) {
            TextWithFont(text: "구독중", font: .robotoBold, size: 14)
                .foregroundColor(ColorConstant.main.color())
                .multilineTextAlignment(.center)
            
            HStack {
                VStack(alignment: .center) {
                    TextWithFont(text: "스터디", font: .robotoMedium, size: 14)
                    
                    TextWithFont(text: "3", font: .robotoMedium, size: 14)
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
                    TextWithFont(text: "프로젝트", font: .robotoMedium, size: 14)
                    
                    TextWithFont(text: "7", font: .robotoMedium, size: 14)
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
