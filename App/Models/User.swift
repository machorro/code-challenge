//
//  User.swift
//  Code Challenge
//
//  Copyright © 2019 Code Coding Challenge. All rights reserved.
//

import Foundation

public struct User: Decodable {
    public let name: String
    public let avatar: URL
    public let fullname: String
}
