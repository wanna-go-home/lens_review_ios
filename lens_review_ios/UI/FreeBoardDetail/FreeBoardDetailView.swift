//
//  FreeBoardDetailView.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/12/06.
//

import SwiftUI

struct FreeBoardDetailView: View
{
    var selectedArticleId: Int
    @ObservedObject var freeBoardDetailViewModel:FreeBoardDetailViewModel = FreeBoardDetailViewModel()
    
    var body: some View {
        VStack {
            FreeBoardDetailRow(article_:freeBoardDetailViewModel.article)
        }.onAppear(perform: callFreeBoardDetail)
    }
    
    func callFreeBoardDetail()
    {
        freeBoardDetailViewModel.getFreeBoardDetail(id: selectedArticleId)
    }
}

struct FreeBoardDetailRow: View
{
    var article_: FreeBoardDetail
    
    var body: some View
    {
        Text(article_.title)
        Text(article_.content)
    }
}

struct FreeBoardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FreeBoardDetailView(selectedArticleId: 6)
    }
}
