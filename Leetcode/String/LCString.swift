//
//  LCString.swift
//  Leetcode
//
//  Created by 马冰垒 on 2022/5/24.
//

import Foundation

class LCString {
    /*
     344.反转字符串
     https://leetcode.cn/problems/reverse-string/
     编写一个函数，其作用是将输入的字符串反转过来。输入字符串以字符数组 char[] 的形式给出。
     不要给另外的数组分配额外的空间，你必须原地修改输入数组、使用 $O(1)$ 的额外空间解决这一问题。

     你可以假设数组中的所有字符都是 ASCII 码表中的可打印字符。

     示例 1：
     输入：["h","e","l","l","o"]
     输出：["o","l","l","e","h"]

     示例 2：
     输入：["H","a","n","n","a","h"]
     输出：["h","a","n","n","a","H"]
     */
    class func reverseString(_ s: inout [Character]) {
        if s.count <= 1 { return }
        // 写法1
        for i in 0..<s.count/2 {
            let j = s.count - 1 - i
            s.swapAt(i, j)
//            let temp = s[i]
//            s[i] = s[j]
//            s[j] = temp
        }
        // 写法2
//        var left = 0
//        var right = s.count - 1
//        while left < right {
//            // 使用元祖
//            (s[left], s[right]) = (s[right], s[left])
//            left += 1
//            right -= 1
//        }
    }
    
    /*
     541. 反转字符串II
     https://leetcode.cn/problems/reverse-string-ii/
     给定一个字符串 s 和一个整数 k，从字符串开头算起，每计数至 2k 个字符，就反转这 2k 字符中的前 k 个字符。

     如果剩余字符少于 k 个，则将剩余字符全部反转。
     如果剩余字符小于 2k 但大于或等于 k 个，则反转前 k 个字符，其余字符保持原样。
     示例 1：
     输入：s = "abcdefg", k = 2
     输出："bacdfeg"
     示例 2：
     输入：s = "abcd", k = 2
     输出："bacd"
     */
    class func reverseStr(_ s: String, _ k: Int) -> String {
        var ch = Array(s)
        for i in stride(from: 0, to: s.count, by: 2 * k) {
            var left = i
            var right = min(s.count - 1, left + k + 1)
            while left < right {
                ch.swapAt(left, right)
//                (ch[left], ch[right]) = (ch[right], ch[left])
                left += 1
                right -= 1
            }
        }
        return String(ch)
    }
    
    func replaceSpace(_ s: String) -> String {
        var strArray = Array(s)
        var count = 0
        for i in strArray {
            if i == " " {
                count += 1
            }
        }
        var left = strArray.count - 1
        var right = strArray.count + count * 2 - 1
        for _ in 0..<(count * 2) {
            strArray.append(" ")
        }
        while left < right {
            if strArray[left] == " " {
                strArray[right] = "0"
                strArray[right - 1] = "2"
                strArray[right - 2] = "%"
                left -= 1
                right -= 3
            } else {
                strArray[right] = strArray[left]
                left -= 1
                right -= 1
            }
        }
        return String(strArray)
    }
    
    /*
     题目：剑指Offer 05.替换空格
     https://leetcode.cn/problems/ti-huan-kong-ge-lcof/
     请实现一个函数，把字符串 s 中的每个空格替换成"%20"。
     示例 1：
     输入：s = "We are happy."
     输出："We%20are%20happy."
     */
    class func replaceSpace(_ s: String) -> String {
        var strArr = Array(s)
        var count = 0
        // 统计空格出现的个数
        for i in strArr {
            if i == " " {
                count += 1
            }
        }
        // left 指向原数组的最后一个元素
        var left = strArr.count - 1
        // right 指向扩容后数组的最后一个元素（这里还没对数组进行实际上的扩容）
        var right = strArr.count + count * 2 - 1
        // 对原数组进行扩容
        for _ in 0..<(count * 2) {
            strArr.append(" ")
        }
        // 从后向前替换空格
        while left < right {
            if strArr[left] == " " {
                strArr[right] = "0"
                strArr[right - 1] = "2"
                strArr[right - 2] = "%"
                left -= 1
                right -= 3
            } else {
                strArr[right] = strArr[left]
                left -= 1
                right -= 1
            }
        }
        return String(strArr)
    }
    
    /*
     151.翻转字符串里的单词
     https://leetcode.cn/problems/reverse-words-in-a-string/
     给你一个字符串 s ，颠倒字符串中 单词 的顺序。
     单词 是由非空格字符组成的字符串。s 中使用至少一个空格将字符串中的 单词 分隔开。
     返回 单词 顺序颠倒且 单词 之间用单个空格连接的结果字符串。
     注意：输入字符串 s中可能会存在前导空格、尾随空格或者单词间的多个空格。返回的结果字符串中，单词间应当仅用单个空格分隔，且不包含任何额外的空格。

     示例 1：
     输入：s = "the sky is blue"
     输出："blue is sky the"
     示例 2：
     输入：s = "  hello world  "
     输出："world hello"
     解释：颠倒后的字符串中不能存在前导空格和尾随空格。
     示例 3：
     输入：s = "a good   example"
     输出："example good a"
     解释：如果两个单词间有多余的空格，颠倒后的字符串需要将单词间的空格减少到仅有一个。
     */
    class func reverseWords(_ s: String) -> String {
        let array = Array(s)
        var res = Array<String>()
        var left = 0
        var right = left + 1
        
        while left < right, right < array.count {
            if array[left] == " " {
                left += 1
                right += 1
                continue
            }
            while right < array.count {
                if array[right] == " " {
                    let word = (s as NSString).substring(with: NSRange(location: left, length: right - left))
                    res.append(word)
                    res.append(" ")
                    left = right
                    right += 1
                    break
                }
            }
        }
        
        return res.joined()
    }
}
