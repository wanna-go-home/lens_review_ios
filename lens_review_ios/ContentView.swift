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
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var lensViewModel: LensListViewModel
    @EnvironmentObject var reviewListViewModel: ReviewListViewModel
    @EnvironmentObject var boardListViewModel: BoardListViewModel

    var body: some View {
        if !loginViewModel.isLoginSuccess {
            LoginView()
        } else {
            TabView{
                LensListView()
                    .tabItem {
                        Image(systemName: "list.dash")
                        Text("렌즈 리스트")
                    }
                    .onAppear(perform: {
                        lensViewModel.getLensList()
                    })
                ReviewListView()
                    .tabItem {
                        Image(systemName: "list.dash")
                        Text("리뷰 게시판")
                    }
                    .onAppear(perform: {
                        reviewListViewModel.getReviewList()
                    })
                BoardListView()
                    .tabItem {
                        Image(systemName: "list.dash")
                        Text("자유 게시판")
                    }
                    .onAppear(perform: {
                        boardListViewModel.getBoardList()
                    })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(LoginViewModel()).environmentObject(LensListViewModel()).environmentObject(ReviewListViewModel()).environmentObject(BoardListViewModel())
    }
}
