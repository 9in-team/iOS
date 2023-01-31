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
        KakaoSDK.initSDK(appKey: "78b20efcbe4535ce48a5ee2c4739745a")
    }
    
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
    
}
