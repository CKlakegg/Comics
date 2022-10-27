//
//  File.swift
//  Comics_ShortCut
//
//  Created by Caroline Klakegg on 25/10/2022.
//

import Foundation
import SwiftUI

struct FavComics: View{
    
    @ObservedObject var viewModel = ComicViewModel()
    
    
    var body: some View {
        
        Text("My Favorites")
    }

}


