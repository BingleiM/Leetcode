//
//  ViewController.swift
//  Leetcode
//
//  Created by 马冰垒 on 2022/5/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // MARK: -- 数组 --
        // 704.二分查找
        // 输入: nums = [-1,0,3,5,9,12], target = 9
        // 输出: 4
        do {
            let nums = [-1, 0, 3, 5, 9, 12], target = 9
            let result = LCArray.binarySearch(nums, target)
            debugPrint("===> 704.二分查找, 输入: nums = \(nums), target = \(target), 输出: \(result)")
        }
        
        // 27.移除元素
        // 输入：nums = [0,1,2,2,3,0,4,2], val = 2
        // 输出：5, nums = [0,1,4,0,3]
        // 解释：函数应该返回新的长度 5, 并且 nums 中的前五个元素为 0, 1, 3, 0, 4。注意这五个元素可为任意顺序。你不需要考虑数组中超出新长度后面的元素。
        do {
            let input = [0, 1, 2, 2, 3, 0, 4, 2]
            var nums = input
            let index = LCArray.removeElement(&nums, 2)
            debugPrint("===> 27.移除元素, 输入: nums = \(input), 输出: \(index), \(nums)")
        }
        
        // 977.有序数组的平方
        // 输入：nums = [-4,-1,0,3,10] 输出：[0,1,9,16,100] 解释：平方后，数组变为 [16,1,0,9,100]，排序后，数组变为 [0,1,9,16,100]
        do {
            let nums = [-4, -1, 0, 3, 10]
            let result = LCArray.sortedSquares(nums)
            debugPrint("===> 977.有序数组的平方, 输入: nums = \(nums), 输出: \(result)")
        }
        
        // MARK: -- 链表 --
        do {
            let vals = [1, 5, 3, 2, 4, 2]
            let list = LCLinkedList(vals: vals)
            debugPrint(list?.description)
        }
    }
}

