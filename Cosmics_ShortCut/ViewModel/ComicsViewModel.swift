//
//  ComicsViewModel.swift
//  Cosmics_ShortCut
//
//  Created by Caroline Klakegg on 21/10/2022.
//

import Foundation

class ComicViewModel: ObservableObject {
    
    // Tutorial used: https://youtu.be/bxCDL3kY8XA
    
    @Published var isFetching: Bool = false
    @Published var comic: Comics? = nil
    
    @Published var errorMessage = ""
    
 
    
    
   /*  public var title: String {
         comic?.month ?? ""
    }*/
    
    init(/*comic: Comic*/) {
       // self.comic = comic
    }
    
    
    
    func fetchData() async {
        let urlString = "https://xkcd.com/614/info.0.json"
        
        guard let url = URL(string: urlString) else { return }
        
        do {
            isFetching = true
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            self.comic = try JSONDecoder().decode(Comics.self, from: data)
            
            if let response = response as? HTTPURLResponse, response.statusCode >= 300 {
                self.errorMessage = "Failed to hit endpoint with bad status codede"
             
            }
            
            isFetching = false
            
        } catch {
            isFetching = false
            print("Failed to reach endpoint: \(error)")
        }
    }
}

