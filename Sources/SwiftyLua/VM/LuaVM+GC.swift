//
//  LuaVM+GC.swift
//  SwiftyLua
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//

import Foundation
import lua4swift

public extension LuaVM {

    /// Run a full Lua garbage-collection cycle.
    ///
    /// Call this periodically (e.g. after a full portrayal pass) to release
    /// compiled Lua chunks, tables, and other objects that have been
    /// dereferenced on the Swift side but not yet reclaimed by Lua's
    /// incremental collector.
    ///
    /// Uses `collectgarbage("collect")` via the Lua runtime to avoid
    /// depending on the exact `lua_gc` C-API signature (which changed to
    /// variadic in Lua 5.4).
    func collectGarbage() {
        _ = vm.eval("collectgarbage('collect')")
    }

    /// Step the Lua GC incrementally.
    ///
    /// A lighter alternative to `collectGarbage()` that can be called more
    /// frequently without stalling the calling thread.
    func stepGarbage() {
        _ = vm.eval("collectgarbage('step')")
    }
}
