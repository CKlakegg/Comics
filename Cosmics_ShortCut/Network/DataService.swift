//
//  DataService.swift
//  Cosmics_ShortCut
//
//  Created by Caroline Klakegg on 24/10/2022.
//

import Foundation

// Service used for fetching and parsing the comics from the API
struct DataService {
    
    // Method used to fetch the comic.
    func fetchComic() async throws -> Comics{
        
        // Endpoint url for fetching. In this case, 614 represents the comic we are fetching.
        let urlString: String = "https://xkcd.com/614/info.0.json"
        
        // When unwrapping the URL we handle the error if the link somehow is optional (nullable).
        guard let url = URL(string: urlString) else { throw NSError() }
        
        // The actual request.
        let request = URLRequest(url: url)
        
        // The data using await, being parsed.
        let (data, _) = try await URLSession.shared.data(for: request)
        
        // Here we decode the reponse using the comic model and return the first element.
        let comic = try JSONDecoder().decode([Comics].self, from: data)
        return comic[0]
    }
}
