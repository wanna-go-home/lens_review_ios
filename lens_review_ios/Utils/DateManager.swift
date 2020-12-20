//
//  DateManager.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/12/13.
//

import Foundation

// X분, 시간, 일 전으로 수정할때 FreeBoard, FreeBoardDetail의 getDateTime도 Util 함수 쓰도록 수정할 예정임
func convertDateFormat(inputData: String, outputFormat: String) -> String
{
    var res = ""
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    
    if let date = dateFormatter.date(from: inputData) {
        dateFormatter.dateFormat = outputFormat
        res = dateFormatter.string(from: date)
    }
    
    return res
}
