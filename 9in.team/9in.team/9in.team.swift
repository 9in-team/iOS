//
//  _in_teamApp.swift
//  9in.team
//
//  Created by 조상현 on 2022/12/25.
//

import SwiftUI
import KakaoSDKCommon

@main
struct NineInTeamApp: App {
    
    init() {
        KakaoSDK.initSDK(appKey: PrivateConstant.kKakaoNativeAppKey)
    }
    
    var body: some Scene {
        WindowGroup {
            SignUp()
        }
    }
    
}
