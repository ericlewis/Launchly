//
//  ObservableStatus.swift
//  Launchly
//
//  Created by Eric Lewis on 10/7/20.
//

import SwiftUI
import Combine
import LaunchDarkly

final class ObservableStatus: ObservableObject {
    @Published var status: ConnectionInformation.ConnectionMode?
    
    var cancellable: AnyCancellable?
    
    func observe(client: LDClient) {
        cancellable = client.currentConnectionModePublisher()
            .sink { [weak self] in
                self?.status = $0
            }
    }
    
    deinit {
        cancellable?.cancel()
    }
}
