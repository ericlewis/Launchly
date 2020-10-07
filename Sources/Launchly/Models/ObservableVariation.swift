//
//  ObservableVariation.swift
//  Launchly
//
//  Created by Eric Lewis on 10/6/20.
//

import SwiftUI
import LaunchDarkly

final class ObservableVariation<T: LDFlagValueConvertible>: ObservableObject {
    @Published var flag: T?
    
    let key: LDFlagKey
    var client: LDClient?

    init(_ key: LDFlagKey) {
        self.key = key
    }
    
    func observe(client: LDClient) {
        self.client = client
        
        // shoot off an inital request probably based on cache
        flag = self.client?.variation(forKey: key)
        
        // spin up observer if we aren't aren't interested in observing (this make the class name annoying)
        self.client?.observe(key: key, owner: key as LDObserverOwner) { [weak self] in
            self?.flag = $0.newValue as? T
        }
    }
    
    deinit {
        // this class will get tossed when recreating the propertyWrapper, so lets kill our observation
        client?.stopObserving(owner: key as LDObserverOwner)
    }
}
