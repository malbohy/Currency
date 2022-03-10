//
//  UIViewExtenstions.swift
//  AccessabilityIdExtenstions
//
//  Created by mohamed albohy on 07/07/2021.
//
import Foundation
public extension FileManager {
    
    static var documentDirectoryURL: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    static var documentDirectoryPath: String {
        return documentDirectoryURL.path
    }
    
    static func createDirectory(atPath path: String) -> Bool {
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try  FileManager.default.createDirectory(atPath: path,
                                                         withIntermediateDirectories: true, attributes: nil)
                return true
            } catch {
                print("Couldn't create document directory at path \(path)")
                return false
            }
        } else {
            print("Document is already exist in path \(path)")
            return true
        }
    }
    
    static func contents(atPath path: String) -> [String] {
        var items = [String]()
        do {
            items = try FileManager.default.contentsOfDirectory(atPath: path)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return items
    }
    
    static func removeItem(atPath path: String) -> Bool {
        // Check if file exists
        if FileManager.default.fileExists(atPath: path) {
            do {
                // Delete file
                try  FileManager.default.removeItem(atPath: path)
                return true
            } catch let error as NSError {
                print("Couldn't delete file at path \(path) with error: \(error.localizedDescription)")
                return false
            }
        } else {
            print("File does not exist in path \(path)")
            return true
        }
    }

    static func moveItem(at sourceURL: URL, to destinationURL: URL) -> Bool {
        // Check if file exists
        if FileManager.default.fileExists(atPath: sourceURL.path) {
            do {
                // Delete file
                try  FileManager.default.moveItem(at: sourceURL, to: destinationURL)
                return true
            } catch let error as NSError {
                print("Couldn't move file at path \(sourceURL.path) with error: \(error.localizedDescription)")
                return false
            }
        } else {
            print("File does not exist in path \(sourceURL.path)")
            return true
        }
    }

    static func fileSizeByMB(atPath path: String) -> Float? {
        guard let size = try? FileManager.default.attributesOfItem(atPath: path)[FileAttributeKey.size],
            let fileSize = size as? UInt64 else {
                return nil
        }
        
        return Float(fileSize / (1024 * 1024))
    }
}
