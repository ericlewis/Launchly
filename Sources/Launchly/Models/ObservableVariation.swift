//
//  ObservableVariation.swift
//  Launchly
//
//  Created by Eric Lewis on 10/6/20.
//

import SwiftUI
import Combine
import LaunchDarkly

final class ObservableVariation<T: LDFlagValueConvertible>: ObservableObject {
    @Published var flag: T?
    
    let key: LDFlagKey
    var client: LDClient?
    var cancellable: AnyCancellable?

    init(_ key: LDFlagKey) {
        self.key = key
    }
    
    func observe(client: LDClient) {
        self.client = client
        
        // shoot off an inital request probably based on cache (might not be needed)
        // flag = self.client?.variation(forKey: key)
        
        cancellable = self.client?.observePublisher(forKey: key).sink { [weak self] in
            self?.flag = $0
        }
    }
    
    deinit {
        cancellable?.cancel()
    }
}
