//
//  API.swift
//  Code Challenge
//
//  Copyright © 2019 Code Coding Challenge. All rights reserved.
//

import Foundation

public enum Result<T> {
    case success(T)
    case failure(Error)
}

extension String: Error {}
public typealias Handler = (Result<Stories>) -> Void

public class API {
    public static func fetchStories(offset: Int = 0, limit: Int = 30, fields: String = "id,title,cover,user", _ handler: @escaping Handler) {
        guard let url = URL(string: "https://www.Code.com/api/v3/stories?offset=\(offset)&limit=\(limit)&fields=stories(\(fields))&filter=new") else {
            handler(.failure("Malformed URL"))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                handler(.failure(error))
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let stories = try decoder.decode(Stories.self, from: data)
                    handler(.success(stories))
                } catch {
                    handler(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
    public static func fetchNextStories(with string: String, _ handler: @escaping Handler) {
        guard let url = URL(string: string) else {
            handler(.failure("Malformed URL"))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                handler(.failure(error))
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let stories = try decoder.decode(Stories.self, from: data)
                    handler(.success(stories))
                } catch {
                    handler(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}



func json(forResource resource: String) {
    let bundle = Bundle.init(for: ViewController.self)
    let jsonFile = bundle.path(forResource: resource, ofType: "json")
    
    guard let jsonPathString = jsonFile else {
        fatalError()
    }
    
    let url = URL(fileURLWithPath: jsonPathString)
    
    let data = try? Data(contentsOf: url)
    
    guard let jsonData = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted) else {
        fatalError()
    }
    
    let string = String(data: jsonData, encoding: .utf8)
    
    print(string)
}

