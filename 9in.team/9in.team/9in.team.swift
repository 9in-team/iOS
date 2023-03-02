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
        KakaoSDK.initSDK(appKey: PrivateConstant.kKakaoNativeAppKey)
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ApplicationSwitcher()
        }
    }
    
}
