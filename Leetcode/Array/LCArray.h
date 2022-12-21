//
//  LCArray.h
//  Leetcode
//
//  Created by 马冰垒 on 2022/5/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCArray : NSObject

/*
 704.二分查找
 https://leetcode.cn/problems/binary-search/
给定一个 n 个元素有序的（升序）整型数组 nums 和一个目标值 target  ，写一个函数搜索 nums 中的 target，如果目标值存在返回下标，否则返回 -1。

输入: nums = [-1,0,3,5,9,12], target = 9
输出: 4
解释: 9 出现在 nums 中并且下标为 4
示例 2:

输入: nums = [-1,0,3,5,9,12], target = 2
输出: -1
解释: 2 不存在 nums 中因此返回 -1
*/

+ (NSInteger)binarySearchTarget:(NSInteger)target inArray:(NSArray<NSNumber *> *)array;

/*
 27.移除元素
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
 */
+ (NSInteger)removeElement:(NSInteger)value inNumbers:(NSMutableArray<NSNumber *> *_Nullable*)nums;

/*
 977.有序数组的平方
 https://leetcode.cn/problems/squares-of-a-sorted-array/
 给你一个按 非递减顺序 排序的整数数组 nums，返回 每个数字的平方 组成的新数组，要求也按 非递减顺序 排序。

 示例 1： 输入：nums = [-4,-1,0,3,10] 输出：[0,1,9,16,100] 解释：平方后，数组变为 [16,1,0,9,100]，排序后，数组变为 [0,1,9,16,100]

 示例 2： 输入：nums = [-7,-3,2,3,11] 输出：[4,9,9,49,121]
 */
+ (NSArray<NSNumber *> *)sortedSquares:(NSArray<NSNumber *> *)nums;

/*
 209.长度最小的子数组
 https://leetcode.cn/problems/minimum-size-subarray-sum/
 
 给定一个含有 n 个正整数的数组和一个正整数 s ，找出该数组中满足其和 ≥ s 的长度最小的 连续 子数组，并返回其长度。如果不存在符合条件的子数组，返回 0。
 示例：
 输入：s = 7, nums = [2,3,1,2,4,3] 输出：2 解释：子数组 [4,3] 是该条件下的长度最小的子数组。
 解题思路
 理解为窗口的滑动
 窗口就是 满足其和 ≥ s 的长度最小的 连续 子数组。
 窗口的起始位置如何移动：如果当前窗口的值大于s了，窗口就要向前移动了（也就是该缩小了）。
 窗口的结束位置如何移动：窗口的结束位置就是遍历数组的指针，窗口的起始位置设置为数组的起始位置就可以了。
 */
+ (NSInteger)minSubArrayLen:(NSArray<NSNumber *> *)nums target:(NSNumber *)target;

@end

NS_ASSUME_NONNULL_END
