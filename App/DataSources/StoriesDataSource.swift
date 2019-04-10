//
//  StoriesDataSource.swift
//  Code Challenge
//
//  Copyright © 2019 Code Coding Challenge. All rights reserved.
//

import Foundation

public final class StoriesDataSource {
    
    public var didLoadData: () -> Void = { }
    public var count: Int { return stories.count }
    
    private var storiesOriginal = Stories(stories: [], nextUrl: "") {
        didSet {
            stories = storiesOriginal
        }
    }
    private var stories = Stories(stories: [], nextUrl: "")
    
    public init() {}
    
    public func item(at index: Int) -> Story {
        return stories.stories[index]
    }
    
    public func searchBy(title: String, _ completion: () -> Void) {
        if title.isEmpty {
            stories = storiesOriginal
        } else {
            stories = storiesOriginal.filter(title, by: \.title)
        }
//        stories = storiesOriginal.filter {
//            $0.title.contains(title)
//        }
        completion()
    }
    
    public func load() {
        API.fetchStories { [weak self] result in
            switch result {
            case .failure:
                print("nothing to see here yet")
            case let .success(response):
                
                self?.storiesOriginal = response
//                self?.storiesOriginal = response.stories
                DispatchQueue.main.async {
                    self?.didLoadData()
                }
            }
        }
    }
    
    func loadNext() {
        API.fetchNextStories(with: storiesOriginal.nextUrl) { [weak self] result in
            switch result {
            case .failure:
                print("nothing to see here yet")
            case let .success(response):
                let originalStoriesArray = self?.storiesOriginal.stories ?? []
                self?.storiesOriginal = Stories(stories: response.stories + originalStoriesArray, nextUrl: response.nextUrl)
                DispatchQueue.main.async {
                    self?.didLoadData()
                }
            }
        }
    }
}
