//
//  StringUtil.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/12/27.
//

import Foundation

extension String
{
     var localized: String
     {
       return NSLocalizedString(self, tableName: "Localizable", value: self, comment: "")
    }
}
