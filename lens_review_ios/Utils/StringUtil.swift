//
//  StringUtil.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/12/27.
//

import Foundation

extension String
{
//    var localized: String
    func localized() -> String 
    {
       return NSLocalizedString(self, tableName: "Localizable", value: self, comment: "")
    }
    
    func localized(with argument: CVarArg = [], comment: String = "") -> String {
        return String(format: self.localized(), argument)
    }
}
