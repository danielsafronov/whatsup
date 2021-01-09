//
//  Store.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 06.01.2021.
//

import Foundation
import CoreData
import Combine

protocol StoreProtocol {
    func observe<V>(_ request: NSFetchRequest<V>) -> AnyPublisher<[V], Error>
    func find<V>(_ request: NSFetchRequest<V>) -> V?
    func store(_ obejct: NSManagedObject) -> Void
    func delete(_ object: NSManagedObject) -> Void
}

struct Store: StoreProtocol {
    let context: NSManagedObjectContext
    
    private let storeTrack = StoreTrack()
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    private var track: AnyPublisher<Void, Error> {
        return storeTrack.subject
            .map { _ in }
            .eraseToAnyPublisher()
    }
    
    func observe<V>(_ observe: NSFetchRequest<V>) -> AnyPublisher<[V], Error> {
        storeTrack.emit()
        
        return track
            .flatMap {
                RequestPublisher<[V], Error>(context: context) { context in
                    do {
                        let data = try context.fetch(observe)
                        return data
                    } catch {
                        fatalError("Unresolved error \(error)")
                    }
                }
            }
            .eraseToAnyPublisher()
    }
    
    func find<V>(_ request: NSFetchRequest<V>) -> V? {
        do {
            let data = try context.fetch(request)
            return data.first
        } catch {
            fatalError("Unresolved error \(error)")
        }
    }
    
    func store(_ object: NSManagedObject) -> Void {
        do {
            context.insert(object)
            
            try context.save()
            storeTrack.emit()
        } catch {
            fatalError("Unresolved error \(error)")
        }
    }
    
    func delete(_ object: NSManagedObject) -> Void {
        do {
            context.delete(object)
            
            try context.save()
            storeTrack.emit()
        } catch {
            fatalError("Unresolved error \(error)")
        }
    }
}

private struct StoreTrack {
    let subject: CurrentValueSubject<Bool, Error>
    
    init() {
        self.subject = CurrentValueSubject(false)
    }
    
    func emit() {
        subject.value = true
    }
}

struct RequestPublisher<Output, Failure>: Publisher where Failure : Error {
    typealias Output = Output
    typealias Failure = Failure
    
    private let context: NSManagedObjectContext
    private let action: (NSManagedObjectContext) -> Output
    
    init(context: NSManagedObjectContext, _ action: @escaping (NSManagedObjectContext) -> Output) {
        self.context = context
        self.action = action
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        subscriber.receive(
            subscription: RequestSubscription<S, Output>(
                subscriber: subscriber,
                context: context,
                action: action
            )
        )
    }
}

class RequestSubscription<S, Output>: Subscription where S : Subscriber {
    private var subscriber: S?
    private var context: NSManagedObjectContext
    private var action: (NSManagedObjectContext) -> Output
    
    init(subscriber: S, context: NSManagedObjectContext, action: @escaping (NSManagedObjectContext) -> Output) {
        self.subscriber = subscriber
        self.context = context
        self.action = action
    }
    
    func request(_ demand: Subscribers.Demand) {
        _ = subscriber?.receive(action(context) as! S.Input)
    }
    
    func cancel() {
        self.subscriber = nil
    }
}
