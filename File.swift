//
//  File.swift
//  
//
//  Created by Alek Matthiessen on 4/9/19.
//

import Foundation
import Firebase

struct Constants
{
    struct refs
    {
        static let databaseRoot = Database.database().reference()
        static let databaseChats = databaseRoot.child("chats")
    }
}
