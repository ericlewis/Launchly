//
//  ObservableStatus.swift
//  Launchly
//
//  Created by Eric Lewis on 10/7/20.
//

import SwiftUI
import LaunchDarkly

final class ObservableStatus: ObservableObject {
    @Published var status: ConnectionInformation.ConnectionMode?
    
    let owner = "ConnectionMode" as LDObserverOwner
    var client: LDClient?

    func observe(client: LDClient) {
        self.client = client

        self.client?.observeCurrentConnectionMode(owner: owner) { [weak self] in
            self?.status = $0
        }
    }
    
    deinit {
        client?.stopObserving(owner: owner)
    }
}
