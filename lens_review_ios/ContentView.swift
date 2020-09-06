//
//  ContentView.swift
//  lens_review_ios
//
//  Created by suning on 2020/08/31.
//  Copyright © 2020 wannagohome. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            Button(action:getlensdata) {Text("Test")}
        }
    }
    
    func getlensdata()
    {
        LensAPI().getAllLensInfo()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
