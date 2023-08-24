//
//  _in_teamApp.swift
//  9in.team
//
//  Created by 조상현 on 2022/12/25.
//

import SwiftUI
import KakaoSDKCommon
import Firebase

@main
struct NineInTeamApp: App {
    
    @StateObject var viewModel = SignViewModel()
    
    init() {
        if let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_APP_KEY"] as? String {
            KakaoSDK.initSDK(appKey: kakaoAppKey)
        }
        
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            WritePostView()
        }
    }
    
}
