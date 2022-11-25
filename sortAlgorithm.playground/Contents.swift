import Foundation

//MARK: bubble
extension Array where Element == Int {
    var bubbleSorted: Self {
        var list = self
        for i in 0..<list.count {
            for j in 0..<(list.count - 1 - i) {
                if list[j] > list[j+1] {
                    list.swapAt(j, j + 1)
                }
            }
        }
        
        return list
    }
    
    var selectionSorted: Self {
        var list = self
        for i in 0..<list.count - 1 {
            var minIdx = i
            for j in i + 1 ..< list.count {
                if list[minIdx] > list[j] {
                    minIdx = j
                }
            }
            list.swapAt(minIdx, i)
        }
        
        return list
    }
    
    var insertionSorted: Self {
        var list = self
        for i in 1..<list.count {
            let temp = list[i]
            var prev = i - 1
            
            while prev >= 0, list[prev] > temp  {
                list[prev + 1] = list[prev]
                prev -= 1
            }
            list[prev + 1] = temp
        }
        
        return list
    }
    
    var quickSorted: Self {
        guard self.count > 1 else { return self }
        var list = self
        
        let pivot = list[Int(list.count / 2)]
        let leftList = list.filter { $0 < pivot }
        let midList = list.filter { $0 == pivot }
        let rightList = list.filter { $0 > pivot }
        
        return leftList.quickSorted + midList + rightList.quickSorted
    }
    
    var mergeSorted: Self {
        guard self.count > 1 else { return self }
        let center: Int = self.count / 2
        let left = Array(self[0..<center])
        let right = Array(self[center..<self.count])
        
        func merge(_ first: [Int], _ second: [Int]) -> [Int] {
            var result = [Int]()
            var first = first
            var second = second
            
            while !first.isEmpty && !second.isEmpty {
                if first[0] < second[0] {
                    result.append(first.removeFirst())
                } else {
                    result.append(second.removeFirst())
                }
            }
            
            if !first.isEmpty {
                result.append(contentsOf: first)
            }
            
            if !second.isEmpty {
                result.append(contentsOf: second)
            }
            
            return result
        }
        
        return merge(left.mergeSorted, right.mergeSorted)
    }
    
    func heapSorted(reversed: Bool = false) -> Self {
        var tempList = self
        var result: [Int] = []
        
        for i in stride(from: self.count-1, to:-1, by: -1) {
            if i == 0 {
                guard let last = tempList.popLast() else { fatalError() }
                result.append(last)
            } else {
                tempList = makeMaxHeap(tempList)
                let temp = tempList[0]
                tempList[0] = tempList[i]
                tempList[i] = temp
                guard let last = tempList.popLast() else { fatalError() }
                result.append(last)
            }
        }
        
        if reversed == false {
            result.reverse()
            return result
        } else {
            return result
        }
        
        func makeMaxHeap(_ list: [Int]) -> [Int] {
            var result = list
            
            for i in 1..<list.count{
                var childNode = i
                repeat {
                    let root: Int = (childNode - 1) / 2
                    if result[root] < result[childNode]{
                        let temp = result[childNode]
                        result[childNode] = result[root]
                        result[root] = temp
                    }
                    childNode = root
                } while (childNode != 0)
            }
            
            return result
        }
    }
}

print([2,4,1,5,6,7,3,8].heapSorted(reversed: true))
