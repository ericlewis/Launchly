//
//  ObservableVariation.swift
//  Launchly
//
//  Created by Eric Lewis on 10/6/20.
//

import SwiftUI
import LaunchDarkly

final class ObservableVariation: ObservableObject {
    @Published var isEnabled: Bool?
    
    let key: String
    var client: LDClient?

    init(_ key: String) {
        self.key = key
    }
    
    func observe(client: LDClient) {
        self.client = client
        
        // shoot off an inital request probably based on cache
        isEnabled = self.client?.variation(forKey: key)
        
        // spin up observer if we aren't aren't interested in observing (this make the class name annoying)
        self.client?.observe(key: key, owner: key as LDObserverOwner) { [weak self] in
            self?.isEnabled = $0.newValue as? Bool
        }
    }
    
    deinit {
        // this class will get tossed when recreating the propertyWrapper, so lets kill our observation
        client?.stopObserving(owner: key as LDObserverOwner)
    }
}
