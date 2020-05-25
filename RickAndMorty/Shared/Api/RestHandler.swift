//
//  RestHandler.swift
//  RickAndMorty
//
//  Created by Evandro de Paula on 24/05/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import Foundation

enum CharacterError {
    case url
    case taskError(error: Error?)
    case noResponse
    case noData
    case reponseCode(code: Int)
    case jsonDecodeError
}


class RestHandler {

    private static let baseUrl = "https://rickandmortyapi.com/api/character/"
    private static let session =  URLSession(configuration: .ephemeral)
    
    class func loadCharacters (onComplete: @escaping ([Character]) -> Void, onError: @escaping (CharacterError) -> Void) {
        guard let url = URL(string: baseUrl) else {
            onError(.url)
            return
        }
    
        let task = session.dataTask(with: url) { (data, response, error) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else{
                    onError(.noResponse)
                    return
                }
                
                if response.statusCode == 200 {
                    guard let data = data else { return }
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        
                        if let informationDictionary = json as? [String: Any] {
                            
                            if let results = informationDictionary["results"] {
                                let resultsJsonData = try JSONSerialization.data(withJSONObject: results, options: [])
                                let characters = try JSONDecoder().decode([Character].self, from: resultsJsonData)
                                onComplete(characters)
                            }
                        }

                    }catch {
                        onError(.jsonDecodeError)
                    }
                    
                } else {
                    onError(.reponseCode(code: response.statusCode))
                }
                
            } else {
                onError(.taskError(error: error))
            }
        }

        task.resume()
    }
}
