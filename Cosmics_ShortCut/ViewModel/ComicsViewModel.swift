//
//  ComicsViewModel.swift
//  Cosmics_ShortCut
//
//  Created by Caroline Klakegg on 21/10/2022.
//

import Foundation
import UIKit


enum ComicsViewModelState {
    case idle
    case loading
    case loaded
}

class ComicViewModel: ObservableObject {
    
   
    @Published var isFetching: Bool = false
    @Published var comic: Comics? = nil
    @Published var errorMessage = ""
    
    // This var should never go below 0 since it might mess the comic.
    @Published var internalComicCounter: Int = 1

    @Published var state = ComicsViewModelState.idle
    
    init() {
        
      
    }
    
    //TODO: finish the storing
    //Saving the comics
   /* private var favComicList: [number: self.internalComicCounter ] = {
        return UserDefaults.standard.dictionary(forKey: Constants.SAVED_COMICS_IN_LIST)
    }() {
        didSet {
            storefavComicList()
        }
    }
    private func storefavComicList() {
        // TODO: replace it with sqlite-storage at some point
        ComicStorage.standard.set(favComicList, forKey:  Constants.SAVED_COMICS_IN_LIST)
        // TODO: send update to widget
    }*/
    
    
    
     //Navigation to Search, open url til browser
    public func didTapSearchLink(){
        //TODO: Make it open a webview in app
        //Solved it this way because the function in the search input doesnt work
        guard let url = URL(string: "https://relevantxkcd.appspot.com/") else {
            return
        }
        UIApplication.shared.openURL(url)
    }
    
    
    //func for next comic
    func nextComic() async {
        await fetchData(number: self.internalComicCounter)
        internalComicCounter = (internalComicCounter + 1)
    }
    
    //func for previous comic
    func previousComic() async {
        await fetchData(number: self.internalComicCounter)
        if internalComicCounter > 1 {
            internalComicCounter = (internalComicCounter - 1)
        }
    }
    
    func fetchData(number: Int) async {
        
        let urlString = URL(string: "https://xkcd.com/\(internalComicCounter)/info.0.json")
        
        do {
            isFetching = true
            
            let (data, response) = try await URLSession.shared.data(from: urlString!)
            
            self.comic = try JSONDecoder().decode(Comics.self, from: data)
             self.state = .loaded
            
            if let response = response as? HTTPURLResponse, response.statusCode >= 300 {
                self.errorMessage = "Failed to hit endpoint with bad status codede"
                self.state = .loaded
            }
            
            
            isFetching = false
            
        } catch {
            isFetching = false
            print("Failed to reach endpoint: \(error)")
        }
    }
}
