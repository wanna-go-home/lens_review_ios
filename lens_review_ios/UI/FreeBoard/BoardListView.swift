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
            ScrollView
            {
                VStack(alignment: .leading)
                {
                    ForEach(boardListViewModel.boardList) { board_ in
                        FreeBoardRow(board_: board_)
                        NavigationLink(destination: Text(board_.title))
                        {
                            // NavigationLink 적용 시 화살표 안 뜨게 하기 위함
                            EmptyView()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .frame(minHeight: 100)
            }
            .padding([.leading, .trailing])
            .navigationBarHidden(true)
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
                Text("\(board_.viewCnt)")
                    .font(.system(size: 11))
                Text("\(board_.likeCnt)")
                    .font(.system(size: 11))
                Text("\(board_.replyCnt)")
                    .font(.system(size: 11))
                Text("\(board_.getDateTime())")
                    .font(.system(size: 11))
            }
            .frame(height: 18)
            .padding([.leading, .trailing], 12)
            
            ScrollDivider()
        }
    }
}

struct BoardListView_Previews: PreviewProvider {
    static var previews: some View {
//        BoardListView().environmentObject(BoardListViewModel())
        FreeBoardRow(board_: FreeBoardPreview())
    }
}
