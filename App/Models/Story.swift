//
//  Story.swift
//  Code Challenge
//
//  Copyright © 2019 Code Coding Challenge. All rights reserved.
//

import Foundation

public struct Story: Decodable {
    public let id: String
    public let title: String
    public let user: User
    public let cover: URL
}
