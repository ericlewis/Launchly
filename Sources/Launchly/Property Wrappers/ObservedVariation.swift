//
//  ObservedFlag.swift
//  Launchly
//
//  Created by Eric Lewis on 10/6/20.
//

import SwiftUI
import LaunchDarkly

@propertyWrapper
public struct ObservedVariation: DynamicProperty {
    @Environment(\.launchDarklyClient) var client
    @ObservedObject var observer: ObservableVariation
    
    let defaultValue: Bool
    
    public var wrappedValue: Bool {
        observer.isEnabled ?? defaultValue
    }
    
    public init(_ key: String, defaultValue: Bool) {
        self.defaultValue = defaultValue
        self.observer = ObservableVariation(key)
        self.observer.observe(client: client)
    }
}
