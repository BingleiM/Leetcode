//
//  LCArray.swift
//  Leetcode
//
//  Created by 马冰垒 on 2022/5/21.
//  数组

import Foundation

class LCArray: NSObject {
    /*
     二分查找
     https://leetcode.cn/problems/binary-search/
    给定一个 n 个元素有序的（升序）整型数组 nums 和一个目标值 target  ，写一个函数搜索 nums 中的 target，如果目标值存在返回下标，否则返回 -1。

    输入: nums = [-1,0,3,5,9,12], target = 9
    输出: 4
    解释: 9 出现在 nums 中并且下标为 4
    示例 2:

    输入: nums = [-1,0,3,5,9,12], target = 2
    输出: -1
    解释: 2 不存在 nums 中因此返回 -1
     
    解题思路
    区间 [left, right]
    */
    class func binarySearch(_ nums: [Int], _ target: Int) -> Int {
        if nums.count == 0 {
            return NSNotFound
        }
        var left = 0
        var right = nums.count - 1
        while left <= right {
            let middle = left + (right - left) / 2
            if target > nums[middle] { // target 在 [middle + 1, right] 区间
                left = middle + 1
            } else if target < nums[middle] { // target 在 [left, middle - 1] 区间
                right = middle - 1
            } else {
                return middle
            }
        }
        return NSNotFound
    }
    
    /*
     移除元素
     https://leetcode.cn/problems/remove-element/
     给你一个数组 nums 和一个值 val，你需要 原地 移除所有数值等于 val 的元素，并返回移除后数组的新长度。

     不要使用额外的数组空间，你必须仅使用 O(1) 额外空间并 原地 修改输入数组。

     元素的顺序可以改变。你不需要考虑数组中超出新长度后面的元素。

     输入：nums = [3,2,2,3], val = 3
     输出：2, nums = [2,2]
     解释：函数应该返回新的长度 2, 并且 nums 中的前两个元素均为 2。你不需要考虑数组中超出新长度后面的元素。例如，函数返回的新长度为 2 ，而 nums = [2,2,3,3] 或 nums = [2,2,0,0]，也会被视作正确答案。
     示例 2：

     输入：nums = [0,1,2,2,3,0,4,2], val = 2
     输出：5, nums = [0,1,4,0,3]
     解释：函数应该返回新的长度 5, 并且 nums 中的前五个元素为 0, 1, 3, 0, 4。注意这五个元素可为任意顺序。你不需要考虑数组中超出新长度后面的元素。
     解题思路: 双指针法（快慢指针法）
     时间复杂度：O(n)
     空间复杂度：O(1)
     */
    class func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var slowIndex = 0
        for fastIndex in 0..<nums.count {
            if val != nums[fastIndex] {
                nums[slowIndex] = nums[fastIndex]
                slowIndex += 1
            }
        }
        return slowIndex
    }
    
    /*
     有序数组的平方
     https://leetcode.cn/problems/squares-of-a-sorted-array/
     给你一个按 非递减顺序 排序的整数数组 nums，返回 每个数字的平方 组成的新数组，要求也按 非递减顺序 排序。

     示例 1： 输入：nums = [-4,-1,0,3,10] 输出：[0,1,9,16,100] 解释：平方后，数组变为 [16,1,0,9,100]，排序后，数组变为 [0,1,9,16,100]

     示例 2： 输入：nums = [-7,-3,2,3,11] 输出：[4,9,9,49,121]
     
     解题思路
     双指针
     时间复杂度：O(n)
     */
    class func sortedSquares(_ nums: [Int]) -> [Int] {
        guard nums.count > 0 else {
            return []
        }
        // 指向新数组最后一个元素
        var k = nums.count - 1
        // 指向原数组的第一个元素
        var i = 0
        // 指向原数组的最后一个元素
        var j = nums.count - 1
        // 初始化新数组(元素全部用 -1 填充)
        var result = Array<Int>.init(repeating: -1, count: nums.count)
        for _ in 0..<nums.count {
            if nums[i] * nums[i] > nums[j] * nums[j] {
                result[k] = nums[i] * nums[i]
                i += 1
            } else {
                result[k] = nums[j] * nums[j]
                j -= 1
            }
            k -= 1
        }
        return result
    }
    
    /*
     209.长度最小的子数组
     https://leetcode.cn/problems/minimum-size-subarray-sum/
     
     给定一个含有 n 个正整数的数组和一个正整数 s ，找出该数组中满足其和 ≥ s 的长度最小的 连续 子数组，并返回其长度。如果不存在符合条件的子数组，返回 0。
     示例：
     输入：s = 7, nums = [2,3,1,2,4,3] 输出：2 解释：子数组 [4,3] 是该条件下的长度最小的子数组。
     解题思路 时间复杂度 O(n)
     理解为窗口的滑动
     窗口就是 满足其和 ≥ s 的长度最小的 连续 子数组。
     窗口的起始位置如何移动：如果当前窗口的值大于s了，窗口就要向前移动了（也就是该缩小了）。
     窗口的结束位置如何移动：窗口的结束位置就是遍历数组的指针，窗口的起始位置设置为数组的起始位置就可以了。
     */
    class func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
        guard nums.count > 0 else {
            return 0
        }
        var result = Int.max
        var sum = 0
        var startIndex = 0
        for endIndex in 0..<nums.count {
            sum += nums[endIndex]
            
            while sum >= target {
                result = min(result, endIndex - startIndex + 1)
                // 这里打印的是满足条件的子数组
//                print(nums[startIndex...endIndex])
                sum -= nums[startIndex]
                startIndex += 1
            }
        }
        return result == Int.max ? 0 : result
    }
    
    /*
     59.螺旋矩阵II
     https://leetcode.cn/problems/spiral-matrix-ii/
     给你一个正整数 n ，生成一个包含 1 到 n2 所有元素，且元素按顺时针顺序螺旋排列的 n x n 正方形矩阵 matrix 。
     示例1:
     输入：n = 3
     输出：[[1,2,3],[8,9,4],[7,6,5]]
     
     示例 2:

     输入：n = 1
     输出：[[1]]
     
     解题思路
     模拟顺时针画矩阵的过程:

     填充上行从左到右
     填充右列从上到下
     填充下行从右到左
     填充左列从下到上
     由外向内一圈一圈这么画下去。
     */
    class func generateMatrix(_ n: Int) -> [[Int]] {
        /*
        let startx = 0, starty = 0 // 定义每循环一个圈的起始位置
        let loop = n / 2 // 每个圈循环几次，例如n为奇数3，那么loop = 1 只是循环一圈，矩阵中间的值需要单独处理
        let mid = n / 2 // 矩阵中间的位置，例如：n为3， 中间的位置就是(1，1)，n为5，中间位置为(2, 2)
        let count = 1 // 用来给矩阵中每一个空格赋值
        let offset = 1 // 每一圈循环，需要控制每一条边遍历的长度
//        int i, j
         */
        
        
        return []
    }
    
    /*
     01.06字符串压缩
     https://leetcode.cn/problems/compress-string-lcci/
     字符串压缩。利用字符重复出现的次数，编写一种方法，实现基本的字符串压缩功能。比如，字符串aabcccccaaa会变为a2b1c5a3。若“压缩”后的字符串没有变短，则返回原先的字符串。你可以假设字符串中只包含大小写英文字母（a至z）。

     示例1:

      输入："aabcccccaaa"
      输出："a2b1c5a3"
     示例2:

      输入："abbccd"
      输出："abbccd"
      解释："abbccd"压缩后为"a1b2c2d1"，比原字符串长度更长。
     */
    class func compressString(_ str: String) -> String {
        guard str.count > 0 else { return str }
        var chars: [String] = []
        for index in str.indices {
            chars.append("\(str[index])")
        }
        var result = chars.first!
        var startIndex = 0
        var count = 1
        for endIndex in 1..<chars.count {
            if chars[startIndex] == chars[endIndex] {
                count += 1
            } else {
                result.append("\(count)" + chars[endIndex])
                startIndex = endIndex
                count = 1
            }
        }
        result.append("\(count)")
//        print(result)
        return result.count >= str.count ? str : result
    }
}


