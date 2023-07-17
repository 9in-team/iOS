//
//  ChatRoom.swift
//  NineInTeam
//
//  Created by 조상현 on 2023/07/02.
//

struct ChatRoomResponse: Codable {
    
    var result: String
    var chatRooms: [ChatRoom]
    
}

struct ChatRoom: Codable, Hashable {
    
    var roomId: Int
    var relatedTeamId: Int
    var relatedTeamSubject: String
    var recentMessage: String
    
}
