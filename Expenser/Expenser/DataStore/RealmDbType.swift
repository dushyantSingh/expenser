//
//  RealmDbType.swift
//  Expenser
//
//  Created by Dushyant Singh on 11/1/22.
//

import Foundation
import RealmSwift
import RxSwift

protocol RealmDbType: AnyObject {
    var dbName: String { get }
    var realm: Realm? { get set }
    var schemaVersion: UInt64 { get }
    var objectTypes: [Object.Type] { get }
    var changesObserved: PublishSubject<Void>? { get set }

    func initializeDB(completion: (_ success: Bool, _ error: Error?) -> Void)
    func save<T: Object>(object: T)
    func realmObjects<T: Object>(type: T.Type) -> [T]?
    func delete(object: Object) -> Error?
}

extension RealmDbType {
    func initializeDB(completion: (_ success: Bool, _ error: Error?) -> Void) {
        do { let dbURL = getDBURL(name: dbName)
            let config = Realm.Configuration(fileURL: dbURL,
                                             schemaVersion: schemaVersion,
                                             objectTypes: objectTypes)
            self.realm = try Realm(configuration: config)
            changesObserved = PublishSubject()
            completion(true, nil)
        } catch let error {
            completion(false, error)
        }
    }

    func save<T: Object>(object: T) {
        do {
            try self.realm?.write {
                self.realm?.add(object)
                changesObserved?.onNext(())
            }
        } catch (let error) {
            fatalError("RealmDB: (\(dbName)), save[T]: \(error.localizedDescription)")
        }
    }

    func realmObjects<T: Object>(type: T.Type) -> [T]? {
        guard let objects = self.realm?.objects(T.self) else {
            return nil
        }
        return Array(objects)
    }

    func delete(object: Object) -> Error? {
        do {
            try self.realm?.write {
                self.realm?.delete(object)
            }
        } catch {
            return error
        }
        return nil
    }
}

extension RealmDbType {
    private func getDBURL(name: String) -> URL {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                                .userDomainMask, true)[0]
        let url: URL =  URL(fileURLWithPath: documentsPath).appendingPathComponent("Realm")
        var isDir: ObjCBool = false
        if FileManager.default.fileExists(atPath: url.path, isDirectory: &isDir) {
            if !isDir.boolValue {
                createDirectory(url)
            }
        } else {
            createDirectory(url)
        }

        let dbURL = url.appendingPathComponent(name)
        return dbURL
    }

    private func createDirectory(_ path: URL) {
        do {
            try FileManager.default.createDirectory(at: path,
                                                    withIntermediateDirectories: true,
                                                    attributes: nil)
        } catch {
            fatalError("RealmDB: (\(dbName)), init: unable to create a directory at path \(path)")
        }
    }
}
