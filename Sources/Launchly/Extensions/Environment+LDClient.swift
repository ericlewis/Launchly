//
//  Environment+LaunchDarkly.swift
//  Launchly
//
//  Created by Eric Lewis on 10/6/20.
//

import SwiftUI
import LaunchDarkly

struct LaunchDarklyClientReferenceEnvironmentKey: EnvironmentKey {
    static let defaultValue: LDClient = LDClient.get()!
}

public extension EnvironmentValues {
    var launchDarklyClient: LDClient {
        get {
            return self[LaunchDarklyClientReferenceEnvironmentKey]
        }
        set {
            self[LaunchDarklyClientReferenceEnvironmentKey] = newValue
        }
    }
}
