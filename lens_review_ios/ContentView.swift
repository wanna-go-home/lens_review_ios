//
//  ContentView.swift
//  lens_review_ios
//
//  Created by seonhee on 2020/10/10.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    @ObservedObject var lensDB: LensViewModel = LensViewModel(lens: [])
        
    var body: some View {
        List
        {
            ForEach(lensDB.lens) { len in
                HStack {
                    Text(len.name)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
