//
//  LensDetailView.swift
//  lens_review_ios
//
//  Created by suning on 2020/09/27.
//  Copyright © 2020 wannagohome. All rights reserved.
//

import SwiftUI

struct LensDetailView: View
{
    var selectedLensId: Int
    @ObservedObject var lensDetailViewModel: LensDetailViewModel = LensDetailViewModel()
    
    var body: some View {
        VStack{
            Text(lensDetailViewModel.lens.name)
            Text("\(lensDetailViewModel.lens.price)")
        }.onAppear(perform: LensDetail)
    }
    
    func LensDetail()
    {
        lensDetailViewModel.getLensDetail(id: selectedLensId)
    }
}

struct LensDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LensDetailView(selectedLensId: 1)
    }
}
