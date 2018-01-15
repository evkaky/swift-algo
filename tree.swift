class Node {
    var left: Node?
    var right: Node?
    var parent: Node?
    var data: Int

    var isLeaf: Bool {
        return left == nil && right == nil
    }

    init(_ data: Int, left: Node? = nil, right: Node? = nil, parent: Node? = nil) {
        self.data = data
        self.left = left
        self.right = right
        self.parent = parent
    }
}

func preorder(_ src: Node?) {
    if src != nil {
        print(src!.data)
        preorder(src!.left)
        preorder(src!.right)
    }
}

func inorder(_ src: Node?) {
    if src != nil {
        inorder(src!.left)
        print(src!.data)
        inorder(src!.right)
    }
}

func binSearchRecursive(_ src: Node?, _ key: Int) -> Bool {
    if src == nil {
        return false
    }
    if key == src?.data {
        return true
    }
    if key > src!.data {
        return binSearchRecursive(src!.right, key)
    } else {
        return binSearchRecursive(src!.left, key)
    }
}

func binTreeInsertIterative(_ root: Node, _ key: Int) {
    var current: Node? = root
    var parent: Node? = nil
    while current != nil {
        parent = current
        if key > current!.data {
            current = current!.right
        } else {
            current = current!.left
        }
    }
    if key > parent!.data {
        parent!.right = Node(key)
    } else {
        parent!.left = Node(key)
    }
}

func binTreeInsertRecursive(_ root: Node, _ key: Int) {
    func inner(_ src: Node?) -> Node? {
        if src == nil {
            return nil
        } else if key > src!.data {
            return inner(src!.right) ?? src
        } else {
            return inner(src!.left) ?? src
        }
    }

    let latest = inner(root)
    if key > latest!.data {
        latest!.right = Node(key)
    } else {
        latest!.left = Node(key)
    }
}

func binTreeInsertStack(_ root: Node, _ key: Int) {
    var latest: Node?
    var stack = [Node?]()
    stack.append(root)
    while !stack.isEmpty {

    }
}

func sameTrees(_ root1: Node?, _ root2: Node?) -> Bool {
    if root1 == nil && root2 == nil {
        return true
    }
    if root1 == nil || root2 == nil {
        return false
    }
    return root1!.data == root2!.data
          && sameTrees(root1!.left, root2!.left)
          && sameTrees(root1!.right, root2!.right)
}

func size(_ src: Node?) -> Int {
    if src == nil {
        return 0
    }
    return 1 + size(src!.left) + size(src!.right)
}

func height(_ src: Node?) -> Int {
    if src == nil {
        return 0
    }
    return 1 + max(height(src!.left), height(src!.right))
}

func rootToLeafSumRecursive(src: Node, sum: Int, path: inout [Int]) -> Bool {
    let newSum = sum - src.data
    if newSum < 0 {
        return false
    }
    if src.isLeaf {
        if newSum == 0 {
            path.append(src.data)
            return true
        } else {
            return false
        }
    } else {
        if src.left != nil {
            if rootToLeafSumRecursive(src: src.left!, sum: newSum, path: &path) {
                path.append(src.data)
                return true
            }
        }
        if src.right != nil {
            if rootToLeafSumRecursive(src: src.right!, sum: newSum, path: &path) {
                path.append(src.data)
                return true
            }
        }
        return false
    }
}

func isTreeBinary(_ src: Node) -> Bool {
    func inner(_ src: Node?, start: Int, end: Int) -> Bool {
        if src == nil {
            return true
        } else {
            return src!.data >= start && src!.data <= end
                  && inner(src!.left, start: start, end: src!.data)
                  && inner(src!.right, start: src!.data, end: end)
        }
    }

    return inner(src, start: Int.min, end: Int.max)
}

func isTreeBinary2(_ src: Node) -> Bool {
    func inner(_ src: Node, start: Int, end: Int) -> Bool {
        guard src.data >= start && src.data <= end else {
            return false
        }
        if src.left != nil {
            if !inner(src.left!, start: start, end: src.data) {
                return false
            }
        }
        if src.right != nil {
            if !inner(src.right!, start: src.data, end: end) {
                return false
            }
        }
        return true
    }

    return inner(src, start: Int.min, end: Int.max)
}

func levelOrderTraversal(_ root: Node) {
    var queue = [Node]()
    queue.append(root)
    while !queue.isEmpty {
        let top = queue.first!
        queue.removeFirst()
        print(top)
        if top.left != nil {
            queue.append(top.left!)
        }
        if top.right != nil {
            queue.append(top.right!)
        }
    }
}

func postorderIterative(_ root: Node) {
    var stack1 = [Node]()
    var stack2 = [Node]()
    stack1.append(root)
    while !stack1.isEmpty {
        let top = stack1.popLast()!
        stack2.append(top)
        if top.left != nil {
            stack1.append(top.left!)
        }
        if top.right != nil {
            stack1.append(top.right!)
        }
    }
    print(stack2.reversed().map {
        $0.data
    })
}

func preorderIterative(_ root: Node) {
    var stack = [Node]()
    stack.append(root)
    while !stack.isEmpty {
        let top = stack.popLast()!
        print(top.data)
        if top.right != nil {
            stack.append(top.right!)
        }
        if top.left != nil {
            stack.append(top.left!)
        }
    }
}

func inorderIterative(_ root: Node) {
    var stack = [Node]()
    var curr: Node? = root
    while true {
        if curr != nil {
            stack.append(curr!)
            curr = curr!.left
        } else {
            if stack.isEmpty {
                break
            }
            let top = stack.popLast()!
            print(top.data)
            if top.right != nil {
                curr = top.right
            }
        }
    }
}

func levelOrderTraversal2(_ root: Node) {
    var queue = [Node]()
    queue.append(root)
    var levelCnt = 1
    while !queue.isEmpty {
        var currCnt = 0
        for _ in 1...levelCnt {
            let top = queue.first!
            queue.removeFirst()
            print(top.data, terminator: " ")
            if top.left != nil {
                queue.append(top.left!)
                currCnt += 1
            }
            if top.right != nil {
                queue.append(top.right!)
                currCnt += 1
            }
        }
        levelCnt = currCnt
        print()
    }
}

func levelOrderTraversalReverse(_ root: Node) {
    var stack = [Node]()
    var queue = [Node]()
    queue.append(root)
    while !queue.isEmpty {
        let top = queue.first!
        queue.removeFirst()
        stack.append(top)
        if top.right != nil {
            queue.append(top.right!)
        }
        if top.left != nil {
            queue.append(top.left!)
        }
    }
    print(stack.reversed().map {
        $0.data
    })
}

func spiralLevelOrderTraversal(_ root: Node) {
    var stack1 = [Node]()
    var stack2 = [Node]()
    stack2.append(root)
    while !stack1.isEmpty || !stack2.isEmpty {
        while !stack1.isEmpty {
            let top = stack1.popLast()!
            print(top.data, terminator: " ")
            if top.right != nil {
                stack2.append(top.right!)
            }
            if top.left != nil {
                stack2.append(top.left!)
            }
        }
        while !stack2.isEmpty {
            let top = stack2.popLast()!
            print(top.data, terminator: " ")
            if top.left != nil {
                stack1.append(top.left!)
            }
            if top.right != nil {
                stack1.append(top.right!)
            }
        }
    }
}

func spiralLevelOrderTraversal2(_ root: Node) {
    var deque = [Node]()
    deque.append(root)
    var currLevelCnt = 1
    var fromEnd = true
    while !deque.isEmpty {
        var nextLevelCnt = 0
        for _ in 1...currLevelCnt {
            if fromEnd {
                let last = deque.popLast()!
                print(last.data, terminator: " ")
                if last.left != nil {
                    deque.insert(last.left!, at: 0)
                    nextLevelCnt += 1
                }
                if last.right != nil {
                    deque.insert(last.right!, at: 0)
                    nextLevelCnt += 1
                }
            } else {
                let top = deque.removeFirst()
                print(top.data, terminator: " ")
                if top.right != nil {
                    deque.append(top.right!)
                    nextLevelCnt += 1
                }
                if top.left != nil {
                    deque.append(top.left!)
                    nextLevelCnt += 1
                }
            }
        }
        fromEnd = !fromEnd
        currLevelCnt = nextLevelCnt
    }
}

func lowestCommonAncestor(_ src: Node?, _ val1: Int, _ val2: Int) -> Int? {
    if src == nil {
        return nil
    }
    if src!.data == val1 || src!.data == val2 {
        return src!.data
    }
    let left = lowestCommonAncestor(src!.left, val1, val2)
    if left != val1 && left != val2 && left != nil {
        return left
    } else {
        let right = lowestCommonAncestor(src!.right, val1, val2)
        if left != nil && right != nil {
            return src!.data
        }
        if left == nil && right == nil {
            return nil
        }
        return left ?? right
    }
}

func postorderWithSingleStack(_ root: Node) {
    var stack = [Node]()
    var curr: Node? = root
    while !stack.isEmpty || curr != nil {
        if curr != nil {
            stack.append(curr!)
            curr = curr?.left ?? curr?.right
        } else {
            let top = stack.popLast()!
            print(top.data, terminator: " ")
            if stack.last?.right !== top {
                curr = stack.last?.right
            }
        }
    }
}
