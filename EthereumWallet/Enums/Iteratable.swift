//
//  Iteratable.swift
//  EthereumWallet
//
//  Created by Gor Hakobyan on 2/13/20.
//  Copyright © 2020 Gor Hakobyan. All rights reserved.
//

import Foundation

protocol Iteratable {}

extension RawRepresentable {
    static func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
        var i = 0
        return AnyIterator {
            let next = withUnsafePointer(to: &i) {
                $0.withMemoryRebound(to: T.self, capacity: 1) { $0.pointee }
            }
            if next.hashValue != i { return nil }
            i += 1
            return next
        }
    }
}

extension Iteratable where Self: RawRepresentable, Self: Hashable {
    static func hashValues() -> AnyIterator<Self> {
        return iterateEnum(self)
    }
    
    static func rawValues() -> [Self.RawValue] {
        return hashValues().map({$0.rawValue})
    }
}
