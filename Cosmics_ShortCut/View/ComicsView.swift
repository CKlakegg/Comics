//
//  ComicsView.swift
//  Cosmics_ShortCut
//
//  Created by Caroline Klakegg on 21/10/2022.
//

import Foundation
import SwiftUI

struct ComicView: View {
    
    @ObservedObject var viewModel = ComicViewModel()
    
    
    @State var showAlert: Bool = false
   
    
    //View with all the content from viewBuilder
    var body: some View {
        
        ZStack{
            //State in the loading of the view
            switch viewModel.state{
            case .idle:
                ProgressView()
            case .loading:
                ProgressView()
            case .loaded:
                showListOfFavoritesButton
                NavigationView{
                    content
                        .navigationTitle("Comics")
                }
                
            }
        }.task {
            await viewModel.fetchData(number: 1)
        }
        
        
        
    }
    
    
    //MARK: ViewBuilder for comicsView
    
    //Viewbulider with all the athoer viewbulider inside
    @ViewBuilder
    private var content: some View {
        VStack(spacing: 20){
            titleOfComic
            comicImage
            text
            date
            favButton
            navigationButtons
            showListOfFavoritesButton
          
            
        }
    }
    
    @ViewBuilder
    private var navigationButtons: some View {
        //TODO: Make buttons stay put in view when it is updating
        HStack {
            Button(
                action: {
                    Task {
                        await viewModel.previousComic()
                    }
                },
                label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(Color(.black))
                    Text("Previous")
                        .foregroundColor(Color(.black))
                }
            )
            Button(
                action: {
                    Task {
                        await viewModel.nextComic()
                    }
                },
                label: {
                    Text("Next")
                        .foregroundColor(Color(.black))
                    Image(systemName: "arrow.forward")
                        .foregroundColor(Color(.black))
                }
            )
        }
    }
    
    @ViewBuilder
    private var comicImage: some View {
        // If the published comic from the viewmodel is not null,
        // we try to use it.
        if viewModel.comic != nil {
            let url = URL(string: viewModel.comic?.img ?? "NaN")
            
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .padding(50)
            } placeholder: {
                ProgressView()
            }
        }
        
    }
    
    @ViewBuilder
    private var text: some View {
        Text(viewModel.comic?.alt ?? "")
            .padding(20)
        
    }
    
    @ViewBuilder
    private var titleOfComic: some View {
        Text(viewModel.comic?.title ?? "")
            .bold()
    }
    
    @ViewBuilder
    private var showListOfFavoritesButton: some View {
        NavigationLink(destination: FavComics()) {
            Text("Your Favorites")
                .foregroundColor(Color(.black))
            
        }
    }
    @ViewBuilder
    private var favButton: some View {
        //TODO: Add an actual function for adding to favorites list
        Button {
            showAlert = true
            print("Add to list")
        } label: {
            Image(systemName: "heart")
                .foregroundColor(Color.red)
        }
        .padding(.top, 32.0)
        .alert(isPresented: $showAlert) {
               Alert(
                   title: Text("Comics is added to favorites"),
                   message: Text("See all your favorites in comics favorites list")
                 
               )
           }
        
    }
    
    @ViewBuilder
    private var searchButton: some View {
        //TODO: Use webview insted so i can open in the application
        Button {
            //action for saving open url Link
            viewModel.didTapSearchLink()
            print("Open Url")
        } label: {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color(.black))
        }
    }
    
    
    @ViewBuilder
    private var date: some View {
        //TODO: Make date update when changing comics
        HStack{
            Text(viewModel.comic?.day ?? "")
            Text("/")
            Text(viewModel.comic?.month ?? "")
            Text("/")
            Text(viewModel.comic?.year ?? "")
            
        }
        
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ComicView()
    }
}
