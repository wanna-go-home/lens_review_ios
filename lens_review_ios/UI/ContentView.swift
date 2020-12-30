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
    @State private var selection = 1
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var lensViewModel: LensListViewModel
    @EnvironmentObject var reviewListViewModel: ReviewListViewModel
    @EnvironmentObject var boardListViewModel: BoardListViewModel

    var body: some View {        
        if !loginViewModel.isLoginSuccess {
            LoginView()
        } else {
            VStack{
                TabBarView(selectionTabId: $selection)
                    .frame(height: 40)
                
                TabView(selection: $selection){
                    LensListView()
                        .tabItem {
                            Image(systemName: "list.dash")
                            Text("렌즈 리스트")
                        }.tag(1)
                    ReviewListView()
                        .tabItem {
                            Image(systemName: "list.dash")
                            Text("리뷰 게시판")
                        }.tag(2)
                    BoardListView()
                        .tabItem {
                            Image(systemName: "list.dash")
                            Text("자유 게시판")
                        }.tag(3)
                }
                .onAppear(perform: {
                    lensViewModel.getLensList()
                })
                .tabViewStyle(PageTabViewStyle())
            }
        }
    }
}

struct TabBarView: View
{
    @Binding var selectionTabId: Int
    
    var body : some View {
        HStack{
            Spacer()

            VStack(spacing: 8){
                Text("렌즈 리스트")
                Rectangle()
                    .frame(height:2)
                    .foregroundColor(selectionTabId == 1 ? .blue : .clear)
            }.onTapGesture {
                self.selectionTabId = 1
            }
            
            Spacer()
            
            VStack(spacing: 8){
                Text("리뷰 게시판")
                Rectangle()
                    .frame(height:2)
                    .foregroundColor(selectionTabId == 2 ? .blue : .clear)
            }.onTapGesture {
                self.selectionTabId = 2
            }
            
            Spacer()
            
            VStack(spacing: 8){
                Text("자유 게시판")
                Rectangle()
                    .frame(height:2)
                    .foregroundColor(selectionTabId == 3 ? .blue : .clear)
            }.onTapGesture {
                self.selectionTabId = 3
            }
            
            Spacer()
        }
        .font(.system(size: 16))
        .padding(3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(LoginViewModel()).environmentObject(LensListViewModel()).environmentObject(ReviewListViewModel()).environmentObject(BoardListViewModel())
    }
}
