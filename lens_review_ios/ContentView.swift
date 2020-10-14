//
//  ContentView.swift
//  lens_review_ios
//
//  Created by suning on 2020/08/31.
//  Copyright © 2020 wannagohome. All rights reserved.
//

import SwiftUI

struct ContentView: View
{
    
//    @ObservedObject var lensViewModel: LensViewModel = LensViewModel()
    @EnvironmentObject var lensViewModel: LensViewModel

    var body: some View {
        TabView{
            LensListView()
            Text("2")
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("자유 게시판")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(LensViewModel())
    }
}

struct LensListView: View {
    
    @EnvironmentObject var lensViewModel: LensViewModel
    
    var body: some View {
        NavigationView
        {
            List
            {
                ForEach(lensViewModel.lensList) { lens_ in
                    HStack {
                        NavigationLink(destination: LensDetailView(selectedLensId: lens_.id))
                        {
                            Text(lens_.name)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Lens List"))
        }.tabItem {
            Image(systemName: "list.dash")
            Text("렌즈 리스트")
        }
    }
}
