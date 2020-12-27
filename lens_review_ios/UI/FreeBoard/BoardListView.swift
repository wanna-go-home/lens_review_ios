//
//  BoardListView.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/10/15.
//

import SwiftUI

struct BoardListView: View {

    @EnvironmentObject var boardListViewModel: BoardListViewModel
    
    var body: some View {
        NavigationView
        {
            ZStack
            {
                ScrollView(showsIndicators: false)
                {
                    LazyVStack(alignment: .leading)
                    {
                        ForEach(boardListViewModel.boardList) { board_ in
                            NavigationLink(destination: FreeBoardDetailView(selectedArticleId: board_.id))
                            {
                                FreeBoardRow(board_: board_)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .frame(minHeight: 100)
                }
                .padding([.leading, .trailing])
                .navigationBarHidden(true)
                .onAppear(perform: {
                    boardListViewModel.getBoardList()
                })
                
                FloatingWriteBtn()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct FreeBoardRow: View {
    
    var board_: FreeBoardPreview
    
    // color 해야함
    var body: some View {
        VStack(alignment: .leading)
        {
            // 상단
            VStack(alignment: .leading) {
                Text("\(board_.title)")
                    .font(.system(size: 18))
                    .foregroundColor(.black)
                    .padding(.top, 5)
                Text("\(board_.content)")
                    .font(.system(size: 12))
                    .foregroundColor(Color("BoardContentColor"))
                    .padding(.top, 5)
                Text("\(board_.nickname)")
                    .font(.system(size: 11))
                    .foregroundColor(.black)
                    .padding(.top, 15)
            }
            .padding([.leading, .trailing], 12)
            .padding(.top, 20)
            
            Divider()
            
            // 하단
            HStack(spacing: 5) {
                
                Image("view")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:14, height: 14)
                    .foregroundColor(Color("IconColor"))
                Text("\(board_.viewCnt)")
                    .font(.system(size: 11))
                
                Image("like")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:14, height: 14)
                    .padding(.leading, 10)
                    .foregroundColor(Color("IconColor"))
                Text("\(board_.likeCnt)")
                    .font(.system(size: 11))
                
                Image("reply")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:14, height: 14)
                    .padding(.leading, 10)
                    .foregroundColor(Color("IconColor"))
                Text("\(board_.replyCnt)")
                    .font(.system(size: 11))
                
                Spacer()
                
                Text("\(board_.getDateTime())")
                    .font(.system(size: 11))
            }
            .frame(height: 18)
            .padding([.leading, .trailing], 12)
            
            ScrollDivider()
        }
    }
}

struct FloatingWriteBtn: View
{
    var body: some View {
        HStack
        {
            Spacer()
            VStack
            {
                Spacer()

                NavigationLink(destination: FreeBoardWriteView())
                {
                    ZStack
                    {
                        Circle()
                            .fill(Color("FloatingColor"))
                            .shadow(color:Color.black.opacity(0.3), radius: 3)
                            .frame(width: 50, height: 50)
                    
                        Image("write")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                    }
                    .padding()
                }
            }
        }
    }
}

struct BoardListView_Previews: PreviewProvider {
    static var previews: some View {
//        BoardListView().environmentObject(BoardListViewModel())
        FreeBoardRow(board_: FreeBoardPreview())
    }
}
