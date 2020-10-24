//
//  BoardListViewModel.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/10/15.
//

import Combine

class BoardListViewModel: ObservableObject
{
    @Published var boardList = [FreeBoardPreview]()

    init(board: [FreeBoardPreview] = [])
    {
        getBoardList()
    }

    func getBoardList()
    {
        LensAPIClient.getFreeBoardPreview {result in
            switch result{
            case .success(let board_):
                self.boardList.append(contentsOf: board_)
                print(board_)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
