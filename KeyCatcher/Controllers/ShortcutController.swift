//
//  ShortcutController.swift
//  KeyCatcher
//
//  Created by Mohammad Al-Ahdal on 2022-05-07.
//

import SwiftUI
import Collections

class ShortcutController: ObservableObject {
    private static let FILE_NAME: String = ".kc.config"
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    @Published var shortcuts: OrderedDictionary<String, Shortcut> {
        didSet {
            saveToJSON()
        }
    }
    init () {
        shortcuts = OrderedDictionary<String, Shortcut>()
        readFromJSON()
    }
    
    func addShortcut(_ sc: Shortcut) {
        shortcuts[sc.id] = sc
    }
    
    func removeShortcut(_ sc: Shortcut) {
        shortcuts.removeValue(forKey: sc.id)
    }
    
    private func readFromJSON() {
        print("Reading from ~/\(ShortcutController.FILE_NAME)")
        let filePath = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent(ShortcutController.FILE_NAME)
        let jsonData = try! Data(contentsOf: filePath, options: .mappedIfSafe)
        
        do {
            let scs = try decoder.decode([Shortcut].self, from: jsonData)
            scs.forEach({sc in
                shortcuts[sc.id] = sc
            })
            print("Read \(jsonData.description)") // "Read # bytes"
        } catch {
            print("Read failed for KeyCatcher Config")
        }

    }

    private func saveToJSON() {
        print("Saving to ~/\(ShortcutController.FILE_NAME)")
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try! encoder.encode(shortcuts.values.elements)
        let filePath = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent(ShortcutController.FILE_NAME)
        
        do {
            try jsonData.write(to: filePath, options: .atomic)
            print("Saved \(jsonData.description)") // "Saved # bytes"
        } catch {
            print("Save failed for KeyCatcher Config")
        }
    }
    
    func executeShortcutIfAvailable(_ sc: Shortcut) -> Bool {
        guard let resolvedShortcut = shortcuts[sc.id] else {
            return false
        }
        print(shell(resolvedShortcut.command))
        return true
    }
}
