//
//  LDClient+Combine.swift
//  Launchly
//
//  Created by Eric Lewis on 10/7/20.
//

import Combine
import LaunchDarkly

extension LDClient {
    public struct ObservePublisher<T: LDFlagValueConvertible>: Combine.Publisher {
        public typealias Output = T
        public typealias Failure = Never
        
        private let key: LDFlagKey
        private let client: LDClient

        init(_ key: LDFlagKey, client: LDClient) {
            self.key = key
            self.client = client
        }
        
        public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
            let subscription = LDClient.ObserveSubscription(subscriber: subscriber, key: key, client: client)
            subscriber.receive(subscription: subscription)
        }
    }
    
    fileprivate final class ObserveSubscription<SubscriberType: Subscriber>: Combine.Subscription where SubscriberType.Input: LDFlagValueConvertible, SubscriberType.Failure == Never {
        private let subscriber: SubscriberType
        private let client: LDClient
        private let key: LDFlagKey
        
        init(subscriber: SubscriberType, key: LDFlagKey, client: LDClient) {
            self.subscriber = subscriber
            self.key = key
            self.client = client

            client.observe(key: key, owner: self as LDObserverOwner) { [weak self] in
                _ = self?.subscriber.receive($0.newValue as! SubscriberType.Input)
            }
        }
        
        func request(_ demand: Subscribers.Demand) {
            if demand > 0 {
                _ = subscriber.receive(client.variation(forKey: key)!)
            }
        }
        
        func cancel() {
            client.stopObserving(owner: self as LDObserverOwner)
        }
    }
    
    public func observePublisher<T: LDFlagValueConvertible>(forKey: LDFlagKey) -> LDClient.ObservePublisher<T> {
        ObservePublisher(forKey, client: self)
    }
}
