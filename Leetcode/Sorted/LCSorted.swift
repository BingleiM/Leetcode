//
//  LCSorted.swift
//  Leetcode
//
//  Created by 马冰垒 on 2022/5/26.
//

import Foundation

class LCSorted: NSObject {
    
    /* 最大公约数 */
    class func gcd(_ a: Int, _ b: Int) -> Int {
      let r = a % b
      if r != 0 {
        return gcd(b, r)
      } else {
        return b
      }
    }
}
