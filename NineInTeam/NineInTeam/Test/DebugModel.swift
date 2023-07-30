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
                         teamTemplates: [ ],
                         types: [HashTag("KOTLIN"), HashTag("JAVA"), HashTag("MYSQL")],
                         subjectType: .project,
                         roles: [
                            Role(name: "프론트앤드", count: 2),
                            Role(name: "백엔드", count: 3)
                         ])
}
#endif
