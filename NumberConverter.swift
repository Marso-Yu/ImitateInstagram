//
//  NumberConverter.swift
//  ImitateInstagram
//
//  Created by Marso on 2021/1/3.
//

import Foundation
func NumCoverter(_ number: Int) -> String {
    if number > 1000000{
        return "\(number / 1000000),\((number % 1000000)/1000),\(number % 1000)"
    }else if number > 1000{
        return "\(number / 1000),\(number % 1000)"
    }else{
    return String(number)
    }
}
