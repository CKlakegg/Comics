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
      
    var body: some View {
        //ContentView with all viewBuilder
        NavigationView{
            VStack() {
                // If the state in the viewModel is fetching, we show a progress view.
                if viewModel.isFetching {
                    ProgressView()
                }
                HStack(spacing: 50){
                    titleOfComic
                    
                    Button {
                        //action for saving comic
                        UserDefaults.standard.set(true, forKey: "Key")
                       
                    } label: {
                        Image(systemName: "heart")
                            .foregroundColor(Color(.red))
                    }

                }
                comicImage
                date
               
                
                
            }
                .navigationTitle("Comics")
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        Button {
                            //action for show prev comic
                           
                        } label: {
                            Image(systemName: "arrow.backward")
                                .foregroundColor(Color(.black))
                            Text("Previous")
                                .foregroundColor(Color(.black))
                        }

                        Spacer()
                        Button {
                            //action for refreching comic
                            UserDefaults.standard.bool(forKey: "Key")
                            
                        } label: {
                            Text("Next")
                                .foregroundColor(Color(.black))
                            Image(systemName: "arrow.forward")
                              .foregroundColor(Color(.black))
                        }

                    }
                }
         
            }
          .task {
            await viewModel.fetchData()
        }
    }
    
    
    //MARK: ViewBuilder for contentView
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
    private var titleOfComic: some View {
        Text(viewModel.comic?.title ?? "")
            .bold()
    }
    
    @ViewBuilder
    private var date: some View {
        HStack{
            Text(viewModel.comic?.day ?? "")
            Text("/")
            Text(viewModel.comic?.month ?? "")
            Text("/")
            Text(viewModel.comic?.year ?? "")
            
        }
        
    }
    
    @ViewBuilder
    private var preview: some View {
        Button {
            //action for refreching comic
           
        } label: {
            Image(systemName: "arrow.backward")
            Text("New Comic")
        }
        .foregroundColor(Color(.black))
        .padding()
        .clipShape(Capsule())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ComicView()
    }
}
