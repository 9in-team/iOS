//
//  DebugModel.swift
//  NineInTeam
//
//  Created by Heonjin Ha on 2023/05/13.
//

import Foundation

#if DEBUG
let dummyTeam = Team(teamId: 1,
                     subject: "SUBJECT",
                     leader: "LEADER",
                     hashtags: ["HASHTAG1", "HASHTAG2", "HASHTAG3"],
                     lastModified: "23시간 전")
#endif
