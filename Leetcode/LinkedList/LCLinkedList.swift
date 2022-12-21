//
//  LCLinkedList.swift
//  Leetcode
//
//  Created by 马冰垒 on 2022/5/22.
//  链表相关

import Foundation

// 单向链表
class ListNode: NSObject {
    var val: Int
    var next: ListNode?
    
    override init() {
        self.val = 0
        self.next = nil
    }
    
    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    
    init(_ val: Int, _ next: ListNode?) {
        self.val = val
        self.next = next
    }
}

extension ListNode {
    override var hash: Int {
        var hasher = Hasher()
        hasher.combine(val)
        hasher.combine(ObjectIdentifier(self))
        return hasher.finalize()
    }
    
    static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    override var description: String {
        return "<\(Self.self), val: \(val)>"
    }
}

/*
 707.设计链表
 https://leetcode.cn/problems/design-linked-list/
 在链表类中实现这些功能：

 get(index)：获取链表中第 index 个节点的值。如果索引无效，则返回-1。
 addAtHead(val)：在链表的第一个元素之前添加一个值为 val 的节点。插入后，新节点将成为链表的第一个节点。
 addAtTail(val)：将值为 val 的节点追加到链表的最后一个元素。
 addAtIndex(index,val)：在链表中的第 index 个节点之前添加值为 val  的节点。如果 index 等于链表的长度，则该节点将附加到链表的末尾。如果 index 大于链表长度，则不会插入节点。如果index小于0，则在头部插入节点。
 deleteAtIndex(index)：如果索引 index 有效，则删除链表中的第 index 个节点。
 */
class LCLinkedList: NSObject {
    private var dummyHead: ListNode?
    private var size: Int
    
    override var description: String {
        var vals: [Int] = []
        var curNode = dummyHead?.next
        while curNode != nil {
            vals.append(curNode!.val)
            curNode = curNode!.next
        }
        return vals.map { String($0) }.joined(separator: " -> ")
    }
    
    override init() {
        // 这里设置的是一个虚拟头节点, 而不是真正的头结点
        dummyHead = ListNode()
        size = 0
    }
    
    init?(vals: [Int]) {
        guard vals.count > 0 else { return nil }
        let dummyHead = ListNode()
        var curNode = dummyHead
        vals.map { ListNode($0) }.forEach { node in
            curNode.next = node
            curNode = node
        }
        self.dummyHead = dummyHead
        self.size = vals.count
    }
    
    // 获取到第index个节点数值，如果index是非法数值直接返回-1， 注意index是从0开始的，第0个节点就是头结点
    func get(_ index: Int) -> Int {
        if index > size || index < 0 { return -1 }
        var currentNode = dummyHead
        for _ in 0...index {
            currentNode = currentNode?.next
        }
        return currentNode?.val ?? -1
    }

    // 在链表最前面插入一个节点，插入完成后，新插入的节点为链表的新的头结点
    func addAtHead(_ val: Int) {
        let newHead = ListNode(val)
        newHead.next = dummyHead?.next
        dummyHead?.next = newHead
        size += 1
    }

    // 在链表最后面添加一个节点
    func addAtTail(_ val: Int) {
        let newTail = ListNode(val)
        var currentNode: ListNode? = dummyHead
        while let curNext = currentNode?.next {
            currentNode = curNext
        }
        currentNode?.next = newTail
        size += 1
    }

    // 在第index个节点之前插入一个新节点，例如index为0，那么新插入的节点为链表的新头节点。
        // 如果index 等于链表的长度，则说明是新插入的节点为链表的尾结点
        // 如果index大于链表的长度，则返回空
    func addAtIndex(_ index: Int, _ val: Int) {
        if index > size { return }
        let newNode = ListNode(val)
        var currentNode = dummyHead
        var curIndex = index
        while curIndex > 0 {
            currentNode = currentNode?.next
            curIndex -= 1
        }
        newNode.next = currentNode?.next
        currentNode?.next = newNode
        size += 1
    }

    // 删除第index个节点，如果index 大于等于链表的长度，直接return，注意index是从0开始的
    func deleteAtIndex(_ index: Int) {
        if index >= size || index < 0 { return }
        var currentNode = dummyHead
        for _ in 0..<index {
            currentNode = currentNode?.next
        }
        currentNode?.next = currentNode?.next?.next
        size -= 1
    }
    
    /*
     203.移除链表元素
     https://leetcode.cn/problems/remove-linked-list-elements/
     
     题意：删除链表中等于给定值 val 的所有节点。

     示例 1：
     输入：head = [1,2,6,3,4,5,6], val = 6
     输出：[1,2,3,4,5]

     示例 2：
     输入：head = [], val = 1
     输出：[]

     示例 3：
     输入：head = [7,7,7,7], val = 7
     输出：[]
     */
    class func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        // 设置一个虚拟头节点再进行删除操作
        let dummyNode = ListNode()
        dummyNode.next = head
        // 记录遍历的当前节点
        var currentNode = dummyNode
        while let curNext = currentNode.next {
            if curNext.val == val {
                // 值相同, 将当前 node 的 next 指针指向下一个 node, 从链表中移除该节点
                currentNode.next = curNext.next
            } else {
                // 值不同, 切换当前 node
                currentNode = curNext
            }
        }
        return dummyNode.next
    }
    
    /*
     206.反转链表
     https://leetcode.cn/problems/reverse-linked-list/
     
     给你单链表的头节点 head ，请你反转链表，并返回反转后的链表。
     输入：head = [1,2,3,4,5]
     输出：[5,4,3,2,1]
     */
    
    /// 双指针法 (迭代)
    /// - Parameter head: 头结点
    /// - Returns: 翻转后的链表头结点
    class func reverseList(_ head: ListNode?) -> ListNode? {
        if head == nil || head?.next == nil { return head }
        var pre: ListNode? = nil
        var cur: ListNode? = head
        var temp: ListNode? = nil
        while cur != nil {
            temp = cur?.next  // 保存一下 cur的下一个节点，因为接下来要改变cur->next
            cur?.next = pre // 翻转操作
            // 更新 pre 和 cur 指针
            pre = cur
            cur = temp
        }
        return pre
    }
    
    /// 递归
    /// - Parameter head: 头结点
    /// - Returns: 翻转后的链表头结点
    class func reverseList2(_ head: ListNode?) -> ListNode? {
        return reverse(pre: nil, cur: head)
    }
    private class func reverse(pre: ListNode?, cur: ListNode?) -> ListNode? {
        if cur == nil { return pre }
        let temp: ListNode? = cur?.next
        cur?.next = pre
        return reverse(pre: cur, cur: temp)
    }
    
    /*
     24. 两两交换链表中的节点
     https://leetcode.cn/problems/swap-nodes-in-pairs/
     
     给定一个链表，两两交换其中相邻的节点，并返回交换后的链表。
     你不能只是单纯的改变节点内部的值，而是需要实际的进行节点交换。
     
     示例 1：
     输入：head = [1,2,3,4]
     输出：[2,1,4,3]
     示例 2：

     输入：head = []
     输出：[]
     示例 3：

     输入：head = [1]
     输出：[1]
     */
    class func swapPairs(_ head: ListNode?) -> ListNode? {
        if head == nil || head?.next == nil {
            return head
        }
        let dummyHead = ListNode() // 设置一个虚拟头节点
        dummyHead.next = head // 将虚拟头节点指向 head, 方便后面做删除操作
        var cur: ListNode? = dummyHead
        while cur?.next != nil, cur?.next?.next != nil {
            let temp1 = cur?.next // 记录临时节点
            let temp2 = cur?.next?.next?.next // 记录临时节点

            cur?.next = cur?.next?.next // 步骤一
            cur?.next?.next = temp1 // 步骤二
            cur?.next?.next?.next = temp2 // 步骤三
            cur = cur?.next?.next // cur移动两位，准备下一轮交换
        }
        return dummyHead.next
    }
    
    /*
     19.删除链表的倒数第N个节点
     https://leetcode.cn/problems/remove-nth-node-from-end-of-list/
     
     给你一个链表，删除链表的倒数第 n 个结点，并且返回链表的头结点。
     示例 1：
     输入：head = [1,2,3,4,5], n = 2
     输出：[1,2,3,5]
     示例 2：

     输入：head = [1], n = 1
     输出：[]
     示例 3：

     输入：head = [1,2], n = 1
     输出：[1]
     */
    class func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        if n <= 0 || head == nil {
            return head
        }
        
        let dummyHead = ListNode()
        dummyHead.next = head
        var fast: ListNode? = dummyHead
        var slow: ListNode? = dummyHead
        // fast 指针向后移动 n
        for _ in 0..<n {
            fast = fast?.next
        }
        while fast?.next != nil {
            fast = fast?.next
            slow = slow?.next
        }
        // 将节点移除
        slow?.next = slow?.next?.next
        return dummyHead.next
    }
    
    /*
     面试题 02.07. 链表相交
     https://leetcode.cn/problems/intersection-of-two-linked-lists-lcci/
     
     给你两个单链表的头节点 headA 和 headB ，请你找出并返回两个单链表相交的起始节点。如果两个链表没有交点，返回 null 。

     图示两个链表在节点 c1 开始相交：
     输入：intersectVal = 8, listA = [4,1,8,4,5], listB = [5,0,1,8,4,5], skipA = 2, skipB = 3
     输出：Intersected at '8'
     解释：相交节点的值为 8 （注意，如果两个链表相交则不能为 0）。
     */
    class func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        guard headA != nil, headB != nil else {
            return nil
        }
        var curA = headA
        var curB = headB
        var lenA = 0, lenB = 0
        while curA != nil { // 求链表A的长度
            curA = curA?.next
            lenA += 1
        }
        while curB != nil { // 求链表B的长度
            curB = curB?.next
            lenB += 1
        }
        curA = headA
        curB = headB
        
        // 让 curA 为最长链表的头，lenA为其长度
        if lenB > lenA {
            swap(&lenA, &lenB)
            swap(&curA, &curB)
        }
        // 求长度差
        let gap = lenA - lenB
        // 让 curA 和 curB 在同一起点上（末尾位置对齐）
        for _ in 0..<gap {
            curA = curA?.next
        }
        // 遍历 curA 和 curB, 遇到相同就直接返回
        while curA != nil {
            if curA == curB {
                return curA
            }
            curA = curA?.next
            curB = curB?.next
        }
        return nil
    }
    
    /*
     142.环形链表II
     https://leetcode.cn/problems/linked-list-cycle-ii/
     
     给定一个链表的头节点 head ，返回链表开始入环的第一个节点。 如果链表无环，则返回 null。

     如果链表中有某个节点，可以通过连续跟踪 next 指针再次到达，则链表中存在环。 为了表示给定链表中的环，评测系统内部使用整数 pos 来表示链表尾连接到链表中的位置（索引从 0 开始）。如果 pos 是 -1，则在该链表中没有环。注意：pos 不作为参数进行传递，仅仅是为了标识链表的实际情况。

     不允许修改 链表。
     */
    class func detectCycle(_ head: ListNode?) -> ListNode? {
        if head == nil { return nil }
        // 定义两个快、慢指针
        var slow: ListNode? = head
        var fast: ListNode? = head
        while fast != nil, fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
            if slow == fast { // 两个指针环内相遇
                var node1: ListNode? = slow
                var node2: ListNode? = head
                while node1 != node2 {
                    node1 = node1?.next
                    node2 = node2?.next
                }
                return node2 // 返回环的入口
            }
        }
        return nil
    }
    
    /* 给出一个链表和一个值x，要求将链表中所有小于x的值放到左边，所有大于或等于x 的 值放到右边， 并且原链表的节点顺序不能变
    例 如 : 1 → 5 → 3 → 2 → 4 → 2 ， 给 定 x = 3 ， 则 要 返国 1 → 2 → 2 → 5 → 3 → 4
    */
    class func partition(_ head: ListNode?, _ x: Int) -> ListNode? {
        var prevDummy = ListNode(0), postDummy = ListNode(0)
        var prev = prevDummy, post = postDummy
        var curNode = head
        
        // 用尾差法分别处理左边和右边
        while curNode != nil {
            if curNode!.val < x {
                prev.next = curNode
                prev = curNode!
            } else {
                post.next = curNode
                post = curNode!
            }
        }
        
        // 防止构成环
        post.next = nil
        // 左右拼接
        prev.next = postDummy.next
        
        return prevDummy.next
    }
}
