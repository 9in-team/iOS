//
//  DebugModel.swift
//  NineInTeam
//
//  Created by Heonjin Ha on 2023/05/13.
//

import Foundation

#if DEBUG

enum TestObject {
    static let team = Team(teamId: 0,
                           subject: "열심히 할 사람 구함",
                           openChatUrl: "http://9in-proejct.chat",
                           templates: [],
                           hashtags: [HashTag("KOTLIN"), HashTag("JAVA"), HashTag("MYSQL")],
                           type: .project,
                           requiredRoles: [
                            Role(title: "프론트앤드", count: 2),
                            Role(title: "백엔드", count: 3)
                           ])
}
#endif
