//
//  Stories.swift
//  Code Challenge
//
//  Copyright © 2019 Code Coding Challenge. All rights reserved.
//

import Foundation

public struct Stories: Decodable {
    public let stories: [Story]
    public let nextUrl: String
    public var count: Int { return stories.count }
    
    public func filter(_ text: String, by kp: KeyPath<Story, String>) -> Stories {
        return Stories(stories: stories.filter {
            $0[keyPath: kp].lowercased().contains(text.lowercased())
        }, nextUrl: "")
    }
}
