//
//  ContentView.swift
//  lens_review_ios
//
//  Created by suning on 2020/08/31.
//  Copyright © 2020 wannagohome. All rights reserved.
//

import SwiftUI
import SlidingTabView

struct ContentView: View
{
    @State private var selection = 0
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var lensViewModel: LensListViewModel
    @EnvironmentObject var reviewListViewModel: ReviewListViewModel
    @EnvironmentObject var boardListViewModel: BoardListViewModel

    var body: some View {        
        if !loginViewModel.isLoginSuccess {
            LoginView()
        } else {
            VStack{
                SlidingTabView(selection: self.$selection, tabs: ["렌즈 리스트", "리뷰 게시판", "자유 게시판"], inactiveAccentColor: Color("BoardContentColor"))

                if(selection == 0){
                    LensListView()
                        .onAppear{ print("0 A")}
                        .onDisappear{ print("0 D")}
                }else if(selection == 1){
                    ReviewListView()
                        .onAppear{ print("1 A")}
                        .onDisappear{ print("1 D")}
                }else if(selection == 2){
                    BoardListView()
                        .onAppear{ print("2 A")}
                        .onDisappear{ print("2 D")}
                }
//                TabBarView(selectionTabId: $selection)
//                    .frame(height: 40)
//
//                TabView(selection: $selection){
//                    LensListView().tabItem{ Text("0")}.tag(1)
//                        .onAppear{ print("0 A")}
//                        .onDisappear{ print("0 D")}
//                    ReviewListView().tabItem{ Text("0")}.tag(2)
//                        .onAppear{ print("1 A")}
//                        .onDisappear{ print("1 D")}
//                    BoardListView().tabItem{ Text("0")}.tag(3)
//                        .onAppear{ print("2 A")}
//                        .onDisappear{ print("2 D")}
//                }
////                .onAppear(perform: {
////                    lensViewModel.getLensList()
////                })
//                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            .onAppear(perform: {
                lensViewModel.getLensList()
            })
            .animation(.none)
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
