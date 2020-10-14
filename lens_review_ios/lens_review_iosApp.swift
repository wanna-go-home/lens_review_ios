//
//  lens_review_iosApp.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/10/10.
//

import SwiftUI

@main
struct lens_review_iosApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(LensViewModel())
        }
    }
}
