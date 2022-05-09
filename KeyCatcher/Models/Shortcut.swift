//
//  Shortcut.swift
//  KeyCatcher
//
//  Created by Mohammad Al-Ahdal on 2022-05-07.
//

import Foundation
import AppKit


class Shortcut: CustomStringConvertible, Identifiable, ObservableObject, Equatable, Hashable, Codable {
    static func == (lhs: Shortcut, rhs: Shortcut) -> Bool {
        lhs.id == rhs.id
    }
    
    private enum CodingKeys: String, CodingKey {
        case keyCombo
        case command
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id: String { description.toBase64() }
    @Published var modifiers: Set<Modifiers>!
    @Published var key: String!
    @Published var command: String!
    
    internal var description: String {
        get {
            var returnString = ""
            if modifiers.contains(.shift) {returnString += Modifiers.shift.rawValue}
            if modifiers.contains(.ctrl) {returnString += Modifiers.ctrl.rawValue}
            if modifiers.contains(.alt) {returnString += Modifiers.alt.rawValue}
            if modifiers.contains(.cmd) {returnString += Modifiers.cmd.rawValue}
            if returnString == "" {returnString = key}
            else {returnString += " + " + key}
            return returnString
        }
        set (value) {
            // do nothing >:(
        }
    }
    
    init () {
        self.modifiers = []
        self.key = ""
        self.command = ""
    }
    
    convenience init(_ sc: Shortcut) {
        self.init()
        self.modifiers = sc.modifiers
        self.key = sc.key
    }
    
    convenience init(_ keyCombo: String, _ command: String) {
        self.init()
        if let desc = keyCombo.fromBase64()?.components(separatedBy: " + ") {
            let modifiers = desc[0]
            modifiers.forEach { char in
                if let modKey = Modifiers.init(rawValue: "\(char)") {
                    self.modifiers.insert(modKey)
                }
            }
            self.key = desc[1]
            self.command = command;
        }
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let keyCombo = try container.decode(String.self, forKey: .keyCombo)
        let command = try container.decode(String.self, forKey: .command)
        self.init(keyCombo, command)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .keyCombo)
        try container.encode(self.command, forKey: .command)
    }
    
    private func resolveSpecialCharactersIfAny (_ key: UInt16) -> String {
        return Keycode(rawValue: key)?.toString() ?? self.key
    }
    
    func getShortcutFromKeyPress(_ capturedModifiers: CGEventFlags, _ key: UInt16) -> Shortcut {
        modifiers.removeAll()
        if capturedModifiers.contains(.maskShift) {modifiers.insert(.shift)}
        if capturedModifiers.contains(.maskControl) {modifiers.insert(.ctrl)}
        if capturedModifiers.contains(.maskAlternate) {modifiers.insert(.alt)}
        if capturedModifiers.contains(.maskCommand) {modifiers.insert(.cmd)}
        
        self.key = resolveSpecialCharactersIfAny(key)
        
        return self;
    }
    
    func getShortcutFromKeyPress(_ capturedModifiers: NSEvent.ModifierFlags, _ key: UInt16) -> Shortcut {
        modifiers.removeAll()
        if capturedModifiers.contains(.shift) {modifiers.insert(.shift)}
        if capturedModifiers.contains(.control) {modifiers.insert(.ctrl)}
        if capturedModifiers.contains(.option) {modifiers.insert(.alt)}
        if capturedModifiers.contains(.command) {modifiers.insert(.cmd)}
        
        self.key = resolveSpecialCharactersIfAny(key)
        
        return self;
    }
}


