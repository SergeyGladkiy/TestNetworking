//
//  File.swift
//  TestNetworking
//
//  Created by Serg on 01.05.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

struct UserProfile: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
