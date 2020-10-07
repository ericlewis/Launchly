//
//  ObservedStatus.swift
//  Launchly
//
//  Created by Eric Lewis on 10/7/20.
//

import SwiftUI
import LaunchDarkly

@propertyWrapper
public struct ObservedStatus: DynamicProperty {
    @Environment(\.launchDarklyClient) var client
    @ObservedObject var observer: ObservableStatus
        
    public var wrappedValue: ConnectionInformation.ConnectionMode? {
        observer.status
    }
    
    public init() {
        self.observer = ObservableStatus()
        self.observer.observe(client: client)
    }
}
