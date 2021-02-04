//
//  LogUtil.swift
//  lens_review_ios
//
//  Created by sance on 2021/02/04.
//

import SwiftUI
import os.log

class LogUtil
{
    static let logger = LogUtil()

    private init() {}
    
    func viewLog(log: String, type: OSLogType = .default) -> EmptyView
    {
        os_log("[WGH UI] %{public}@", type: type, log)
        
        return EmptyView()
    }
    
    func log(log: String, type: OSLogType = .default)
    {
        os_log("[WGH] %{public}@", type: type, log)
    }
}
