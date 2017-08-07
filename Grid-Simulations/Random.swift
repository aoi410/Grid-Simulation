//
//  Random.swift
//  Grid-Simulations
//
//  Created by Dion Larson on 6/12/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation

public func randomZeroToOne() -> Double {
    return Double(arc4random_uniform(UInt32.max)) / Double(UInt32.max)
}

extension MutableCollection where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffle() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in startIndex ..< endIndex - 1 {
            let j = Int(arc4random_uniform(UInt32(endIndex - i))) + i
            if i != j {
                swap(&self[i], &self[j])
            }
        }
    }
}

extension Collection {
    /// Return a copy of `self` with its elements shuffled
    func shuffled() -> [Iterator.Element] {
        var list = Array(self)
        list.shuffle()
        return list
    }
}
