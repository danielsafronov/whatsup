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
    func fetch<V>(_ action: @escaping (_ context: NSManagedObjectContext) -> NSFetchRequest<V>) -> AnyPublisher<[V], Error>
    func store(_ action: @escaping (_ context: NSManagedObjectContext) -> Void) -> Void
    func delete(_ action: @escaping (_ context: NSManagedObjectContext) -> Void) -> Void
}

struct Store: StoreProtocol {
    private let context: NSManagedObjectContext
    private let storeTrack = StoreTrack()
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    private var track: AnyPublisher<Void, Error> {
        return storeTrack.subject
            .map { _ in }
            .eraseToAnyPublisher()
    }
    
    func fetch<V>(_ action: @escaping (_ context: NSManagedObjectContext) -> NSFetchRequest<V>) -> AnyPublisher<[V], Error> {
        storeTrack.emit()
        
        return track
            .flatMap {
                RequestPublisher<[V], Error>(context: context) { context in
                    do {
                        let data = try context.fetch(action(context))
                        return data
                    } catch {
                        fatalError("Unresolved error \(error)")
                    }
                }
            }
            .eraseToAnyPublisher()
    }
    
    func store(_ action: @escaping (_ context: NSManagedObjectContext) -> Void) -> Void {
        action(context)
        
        do {
            try context.save()
            storeTrack.emit()
        } catch {
            let nsError = error as NSError
            print(nsError.localizedDescription)
        }
    }
    
    func delete(_ action: @escaping (_ context: NSManagedObjectContext) -> Void) -> Void {
        action(context)
        
        do {
            try context.save()
            storeTrack.emit()
        } catch {
            let nsError = error as NSError
            print(nsError.localizedDescription)
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
        subscriber?.receive(action(context) as! S.Input)
    }
    
    func cancel() {
        self.subscriber = nil
    }
}