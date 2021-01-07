//
//  NumberConverter.swift
//  ImitateInstagram
//
//  Created by Marso on 2021/1/3.
//

import Foundation
func NumCoverter(_ number: Int) -> String {
    if number > 1000000{
        let millionNumber = number / 1000000

        let thousandNumber = String(format:"%03d",(number % 1000000) / 1000)

        let lessThanThousnadNumber = String(format:"%03d",number % 1000)
        
        return "\(millionNumber),\(thousandNumber),\(lessThanThousnadNumber)"

    }else if number > 1000{
        let thousandNumber = number / 1000
        
        let lessThanThousnadNumber = String(format:"%03d",number % 1000)
        
        return "\(thousandNumber),\(lessThanThousnadNumber)"
 
    }else{
    return String(number)
    }
}
