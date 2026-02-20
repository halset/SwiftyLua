//
//  TypeChecker+Optional.swift
//  SwiftyLua
//
//  Created by Thomas Bonk on 20.02.26.
//  Copyright 2025 Thomas Bonk <thomas@meandmymac.de>
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation
import lua4swift

/**
 Wrap a `TypeChecker` so that Lua `nil` is accepted as argument.
 */
public func optional(_ typeChecker: @escaping TypeChecker) -> TypeChecker {
  return { vm, value in
    if value.kind() == .nil {
      return nil
    }

    return typeChecker(vm, value)
  }
}

public extension Value {
  /**
   A convenience type checker that accepts either `Self` or `nil`.
   */
  static var optionalArg: TypeChecker {
    return optional(Self.arg)
  }
}
