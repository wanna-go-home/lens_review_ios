//
//  ContentView.swift
//  lens_review_ios
//
//  Created by suning on 2020/08/31.
//  Copyright © 2020 wannagohome. All rights reserved.
//

import SwiftUI

private let LENS_TAB = 1
private let REVIEW_TAB = 2
private let ARTICLE_TAB = 3

private let MIN_PAGE_NUM = 1
private let MAX_PAGE_NUM = 3

struct ContentView: View
{
    @State private var selection = LENS_TAB
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
                
                if(selection == LENS_TAB){
                    LensListView()
                }else if(selection == REVIEW_TAB){
                    ReviewListView()
                }else if(selection == ARTICLE_TAB){
                    BoardListView()
                }
            }
            .onAppear(perform: {
                lensViewModel.getLensList()
            })
            .gesture(
                DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
                    .onEnded { value in
                        if value.translation.width < 0 && value.translation.height > -30 && value.translation.height < 30 {
                            if selection < MAX_PAGE_NUM {
                                selection += 1
                            }
                        }
                        else if value.translation.width > 0 && value.translation.height > -30 && value.translation.height < 30 {
                            if selection > MIN_PAGE_NUM {
                                selection -= 1
                            }
                        }
                    }
            )
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
                Text("lens_tab".localized())
                Rectangle()
                    .frame(height:2)
                    .foregroundColor(selectionTabId == LENS_TAB ? .blue : .clear)
            }.onTapGesture {
                self.selectionTabId = LENS_TAB
            }
            
            Spacer()
            
            VStack(spacing: 8){
                Text("review_tab".localized())
                Rectangle()
                    .frame(height:2)
                    .foregroundColor(selectionTabId == REVIEW_TAB ? .blue : .clear)
            }.onTapGesture {
                self.selectionTabId = REVIEW_TAB
            }
            
            Spacer()
            
            VStack(spacing: 8){
                Text("article_tab".localized())
                Rectangle()
                    .frame(height:2)
                    .foregroundColor(selectionTabId == ARTICLE_TAB ? .blue : .clear)
            }.onTapGesture {
                self.selectionTabId = ARTICLE_TAB
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
