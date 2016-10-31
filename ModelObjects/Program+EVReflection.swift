//
//  Program+EVReflection.swift
//  JSONShootout
//
//  Created by Edwin Vermeer on 26/10/2016.
//  Copyright © 2016 SwiftBit. All rights reserved.
//

import EVReflection

// If you change the base class of ProgramObject from NSObject to EVObject then you don't need this extension.
extension ProgramObject : EVReflectable {
    public override func setValue(_ value: Any?, forUndefinedKey key: String) {
        // Easy way to ignore all unknown keys
    }
}
