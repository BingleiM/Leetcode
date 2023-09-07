//
//  LCHashMap.swift
//  Leetcode
//
//  Created by 马冰垒 on 2022/5/23.
//  哈希表

import Foundation

class LCHashMap {
    /*
     242.有效的字母异位词
     https://leetcode.cn/problems/valid-anagram/
     给定两个字符串 s 和 t ，编写一个函数来判断 t 是否是 s 的字母异位词。
     示例 1: 输入: s = "anagram", t = "nagaram" 输出: true
     示例 2: 输入: s = "rat", t = "car" 输出: false
     说明: 你可以假设字符串只包含小写字母
     */
    class func isAnagram(_ s: String, _ t: String) -> Bool {
        if s.count != t.count { return false }
        // 只有26个字母, 所以定义了一个包含26个字符的数组
        var record = Array(repeating: 0, count: 26)
        let aUnicodeScalar = "a".unicodeScalars.first!.value
        for c in s.unicodeScalars {
            record[Int(c.value - aUnicodeScalar)] += 1
        }
        for c in t.unicodeScalars {
            record[Int(c.value - aUnicodeScalar)] -= 1
        }
        for value in record {
            if value != 0 {
                return false
            }
        }
        return true
    }
    
    /*
     349. 两个数组的交集
     https://leetcode.cn/problems/intersection-of-two-arrays/
     
     题意：给定两个数组，编写一个函数来计算它们的交集。

     示例 1：

     输入：nums1 = [1,2,2,1], nums2 = [2,2]
     输出：[2]
     示例 2：

     输入：nums1 = [4,9,5], nums2 = [9,4,9,8,4]
     输出：[9,4]
     解释：[4,9] 也是可通过的
     */
    class func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        if nums1.count == 0 || nums2.count == 0 { return [] }
        var set1 = Set<Int>()
        var set2 = Set<Int>()
        for num in nums1 {
            set1.insert(num)
        }
        for num in nums2 {
            if set1.contains(num) {
                set2.insert(num)
            }
        }
        return Array(set2)
    }
    
    /*
     第202题. 快乐数
     https://leetcode.cn/problems/happy-number/
     
     编写一个算法来判断一个数 n 是不是快乐数。
     「快乐数」定义为：对于一个正整数，每一次将该数替换为它每个位置上的数字的平方和，然后重复这个过程直到这个数变为 1，也可能是 无限循环 但始终变不到 1。如果 可以变为  1，那么这个数就是快乐数。
     如果 n 是快乐数就返回 True ；不是，则返回 False 。
     示例：

     输入：19
     输出：true
     解释：
     1^2 + 9^2 = 82
     8^2 + 2^2 = 68
     6^2 + 8^2 = 100
     1^2 + 0^2 + 0^2 = 1
     */
    class func isHappy(_ n: Int) -> Bool {
        var set = Set<Int>()
        var num = n
        while true {
            let sum = getSum(num)
            if sum == 1 {
                return true
            }
            // 如果 sum 出现过, 则说明陷入无限循环
            if set.contains(sum) {
                return false
            } else {
                set.insert(sum)
            }
            num = sum
        }
    }
    // number 每个位置上的数字的平方和
    class func getSum(_ number: Int) -> Int {
        if number == 1 { return 1 }
        var sum = 0
        var num = number
        while num > 0 {
            let temp = num % 10
            sum += (temp * temp)
            num /= 10
        }
        return sum
    }
    
    /*
     1. 两数之和
     https://leetcode.cn/problems/two-sum/
     
     给定一个整数数组 nums 和一个整数目标值 target，请你在该数组中找出 和为目标值 target  的那 两个 整数，并返回它们的数组下标。
     示例:
     给定 nums = [2, 7, 11, 15], target = 9
     因为 nums[0] + nums[1] = 2 + 7 = 9
     你可以假设每种输入只会对应一个答案。但是，数组中同一个元素在答案里不能重复出现。
     */
    class func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        if nums.count == 0 { return [] }
        // 值: 下标
        var map = [Int: Int]()
        for (index, value) in nums.enumerated() {
            if let index1 = map[target - value] {
                return [index1, index]
            }
            map[value] = index
        }
        return []
    }
    
    /*
     18. 四数之和
     https://leetcode.cn/problems/4sum/
     给你一个由 n 个整数组成的数组 nums ，和一个目标值 target 。请你找出并返回满足下述全部条件且不重复的四元组 [nums[a], nums[b], nums[c], nums[d]] （若两个四元组元素一一对应，则认为两个四元组重复）：

     0 <= a, b, c, d < n
     a、b、c 和 d 互不相同
     nums[a] + nums[b] + nums[c] + nums[d] == target
     你可以按 任意顺序 返回答案 。

     示例 1：

     输入：nums = [1,0,-1,0,-2,2], target = 0
     输出：[[-2,-1,1,2],[-2,0,0,2],[-1,0,0,1]]
     示例 2：

     输入：nums = [2,2,2,2,2], target = 8
     输出：[[2,2,2,2]]
     */
//    class func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
//
//    }
    
    /*
     第454题.四数相加II
     给定四个包含整数的数组列表 A , B , C , D ,计算有多少个元组 (i, j, k, l) ，使得 A[i] + B[j] + C[k] + D[l] = 0。

     为了使问题简单化，所有的 A, B, C, D 具有相同的长度 N，且 0 ≤ N ≤ 500 。所有整数的范围在 -2^28 到 2^28 - 1 之间，最终结果不会超过 2^31 - 1 。

     例如:

     输入: A = [ 1, 2] B = [-2,-1] C = [-1, 2] D = [ 0, 2] 输出: 2 解释: 两个元组如下:

     (0, 0, 0, 1) -> A[0] + B[0] + C[0] + D[1] = 1 + (-2) + (-1) + 2 = 0
     (1, 1, 0, 0) -> A[1] + B[1] + C[0] + D[0] = 2 + (-1) + (-1) + 0 = 0
     */
    class func fourSumCount(_ nums1: [Int], _ nums2: [Int], _ nums3: [Int], _ nums4: [Int]) -> Int {
        // ab和: ab和出现的次数
        var countDic = [Int: Int]()
        for a in nums1 {
            for b in nums2 {
                let key = a + b
                countDic[key] = countDic[key, default: 0] + 1
            }
        }
        
        // 通过 0 - (c + d) 作为 key, 去累加 ab 和出现的次数
        var result = 0
        for c in nums3 {
            for d in nums4 {
                let key = 0 - (c + d)
                result += countDic[key, default: 0]
            }
        }
        return result
    }
    
    /*
     383. 赎金信
     https://leetcode.cn/problems/ransom-note/
     给定一个赎金信 (ransom) 字符串和一个杂志(magazine)字符串，判断第一个字符串 ransom 能不能由第二个字符串 magazines 里面的字符构成。如果可以构成，返回 true ；否则返回 false。
     (题目说明：为了不暴露赎金信字迹，要从杂志上搜索各个需要的字母，组成单词来表达意思。杂志字符串中的每个字符只能在赎金信字符串中使用一次。)

     你可以假设两个字符串均只含有小写字母。

     canConstruct("a", "b") -> false
     canConstruct("aa", "ab") -> false
     canConstruct("aa", "aab") -> true
     */
    // 两层 for 循环, 时间复杂度是 O(n^2)
    class func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
        var rs = ransomNote
        for a in magazine.indices {
            for b in rs.indices {
                if magazine[a] == rs[b] {
                    rs.remove(at: b)
                    break
                }
            }
        }
        if rs.count == 0 {
            return true
        }
        return false
    }
    
    // 时间复杂度 O(n), 空间复杂度 O(1)
    class func canConstruct1(_ ransomNote: String, _ magazine: String) -> Bool {
        if ransomNote.count == 0 { return true }
        if magazine.count == 0 { return false }
        var record = Array(repeating: 0, count: 26)
        let aUnicodeScalars = "a".unicodeScalars.first!.value
        for c in magazine.unicodeScalars {
            record[Int(c.value - aUnicodeScalars)] += 1
        }
        for c in ransomNote.unicodeScalars {
            record[Int(c.value - aUnicodeScalars)] -= 1
            if record[Int(c.value - aUnicodeScalars)] < 0 {
                return false
            }
        }
        return true
    }
    
    /*
     第15题. 三数之和
     https://leetcode.cn/problems/3sum/
     给你一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？请你找出所有满足条件且不重复的三元组。
     注意： 答案中不可以包含重复的三元组。
     示例：
     给定数组 nums = [-1, 0, 1, 2, -1, -4]，
     满足要求的三元组集合为： [ [-1, 0, 1], [-1, -1, 2] ]
     */
    class func threeSum(_ nums: [Int]) -> [[Int]] {
        if nums.count < 3 { return [] }
        var res = [[Int]]()
        // 做排序
        let sorted = nums.sorted()
        // 双指针法
        for i in 0..<sorted.count {
            if sorted[i] > 0 {
                return res
            }
            if i > 0, sorted[i] == sorted[i - 1] { // 去重
                continue
            }
            var left = i + 1
            var right = sorted.count - 1
            while left < right {
                let sum = sorted[i] + sorted[left] + sorted[right]
                if sum < 0 {
                    left += 1
                } else if sum > 0 {
                    right -= 1
                } else {
                    res.append([sorted[i], sorted[left], sorted[right]])
                    while left < right, sorted[left] == sorted[left + 1] {
                        left += 1
                    }
                    while left < right, sorted[right] == sorted[right - 1] {
                        right -= 1
                    }
                    left += 1
                    right -= 1
                }
            }
        }
        return res
    }
    
    /*
     第18题. 四数之和
     https://leetcode.cn/problems/4sum/
     题意：给定一个包含 n 个整数的数组 nums 和一个目标值 target，判断 nums 中是否存在四个元素 a，b，c 和 d ，使得 a + b + c + d 的值与 target 相等？找出所有满足条件且不重复的四元组。
     注意：

     答案中不可以包含重复的四元组。

     示例： 给定数组 nums = [1, 0, -1, 0, -2, 2]，和 target = 0。 满足要求的四元组集合为： [ [-1, 0, 0, 1], [-2, -1, 1, 2], [-2, 0, 0, 2] ]
     */
    class func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        guard nums.count > 0 else { return [] }
        var res = [[Int]]()
        let sorted = nums.sorted()
        for k in 0..<sorted.count {
            if k > 0, sorted[k] == sorted[k - 1] { // 去重
                continue
            }
            let target2 = target - sorted[k]
            for i in (k + 1) ..< sorted.count {
                if i > (k + 1), sorted[i] == sorted[i - 1] { // 去重
                    continue
                }
                var left = i + 1
                var right = sorted.count - 1
                while left < right {
                    let sum = sorted[i] + sorted[left] + sorted[right]
                    if sum > target2 {
                        right -= 1
                    } else if sum < target2 {
                        left += 1
                    } else {
                        res.append([sorted[k], sorted[i], sorted[left], sorted[right]])
                        while left < right, sorted[left] == sorted[left + 1] {
                            left += 1
                        }
                        while left < right, sorted[right] == sorted[right - 1] {
                            right -= 1
                        }
                        left += 1
                        right -= 1
                    }
                }
            }
        }
        return res
    }
}
