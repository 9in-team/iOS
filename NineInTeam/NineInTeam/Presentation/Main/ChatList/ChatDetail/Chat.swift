//
//  Chat.swift
//  NineInTeam
//
//  Created by 조상현 on 2023/06/28.
//

struct ChatResponse: Codable {
    
    var result: String
    var chats: [Chat]
    
}

struct Chat: Codable, Hashable {
    
    var roomId: Int
    var userId: String
    var message: String
    var createdAt: String
    
}
