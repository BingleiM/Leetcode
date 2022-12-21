//
//  LCArray.m
//  Leetcode
//
//  Created by 马冰垒 on 2022/5/21.
//

#import "LCArray.h"

@implementation LCArray

// 输入: nums = [-1,0,3,5,9,12], target = 9
// 输出: 4
+ (NSInteger)binarySearchTarget:(NSInteger)target inArray:(NSArray<NSNumber *> *)array {
    if (!array || !array.count) return -1;
    NSInteger left = 0;
    NSInteger right = array.count - 1;
    while (left <= right) {
        NSInteger middle = left + ((right - left) / 2); // 防止内存溢出, 等同于 (right + left) / 2
        if ([array[middle] integerValue] < target) { // target 在右区间 [middle + 1, right]
            return middle;
        } else if ([array[middle] integerValue] > target) { // target 在左区间 [left, middle - 1]
            right = middle - 1;
        } else { // // 直接找到目标值, 直接返回
            left = middle + 1;
        }
    }
    return -1;
}

// 输入：nums = [3,2,2,3], val = 3
// 输出：2, nums = [2,2]
// 时间复杂度：O(n)
// 空间复杂度：O(2)
+ (NSInteger)removeElement:(NSInteger)value inNumbers:(NSMutableArray<NSNumber *> *__autoreleasing *)nums {
    NSMutableArray *arr = *nums;
    if (!arr || !arr.count) return -1;
    NSInteger slowIndex = 0;
    for (NSInteger i = arr.count - 1; i >= 0; i--) {
        if ([arr[i] integerValue] == value) {
            [arr removeObjectAtIndex:i];
            slowIndex += 1;
        }
    }
    return arr.count - slowIndex;
}

+ (NSArray<NSNumber *> *)sortedSquares:(NSArray<NSNumber *> *)nums {
    if (!nums || !nums.count) return nil;
    // 指向新数组中的最后一个元素
    NSInteger k = nums.count - 1;
    // 指向原数组中的第一个元素
    NSInteger i = 0;
    // 指向原数组中的最后一个元素
    NSInteger j = nums.count - 1;
    NSMutableArray *result = nums.mutableCopy;
    for (int a = 0; a < nums.count; a ++) {
        NSInteger iSq = [nums[i] integerValue] * [nums[i] integerValue];
        NSInteger jSq = [nums[j] integerValue] * [nums[j] integerValue];
        if ( iSq > jSq) {
            result[k] = @(iSq);
            i += 1;
        } else {
            result[k] = @(jSq);
            j -= 1;
        }
        k -= 1;
    }
    return result.copy;
}

@end
