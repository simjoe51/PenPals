//
//  Letter.swift
//  PenPals
//
//  Created by Joseph Simeone on 2/7/21.
//

import Foundation

struct Letter: Codable {
    //MARK: Variables
    let data: String
    let sender: String
    let recipient: String
    
    @discardableResult
    static func letterFromNotification(_ notification: [String: AnyObject]) -> Letter? {
        guard
            let data = notification[]
    }
    
    init(data: String, sender: String, recipient: String) {
        self.data = data
        self.recipient = recipient
        self.sender = sender
    }
    
    
}
