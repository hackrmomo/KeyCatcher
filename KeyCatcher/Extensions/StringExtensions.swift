//
//  StringExtensions.swift
//  KeyCatcher
//
//  Created by Mohammad Al-Ahdal on 2022-05-07.
//

import Foundation

extension String {

    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    func toKeycode() -> Keycode? {
        switch (self) {
            case "⏎": return .returnKey
            case "⇥": return .tab
            case "' '": return .space
            case "⇤": return .delete
            case "esc": return .escape

            case "←": return .leftArrow
            case "→": return .rightArrow
            case "↑": return .upArrow
            case "↓": return .downArrow

            case "F1": return .f1
            case "F2": return .f2
            case "F3": return .f3
            case "F4": return .f4
            case "F5": return .f5
            case "F6": return .f6
            case "F7": return .f7
            case "F8": return .f8
            case "F9": return .f9
            case "F10": return .f10
            case "F11": return .f11
            case "F12": return .f12
            case "F13": return .f13
            case "F14": return .f14
            case "F15": return .f15
            case "F16": return .f16
            case "F17": return .f17
            case "F18": return .f18
            case "F19": return .f19
            case "F20": return .f20
            case "A": return .a
            case "B": return .b
            case "C": return .c
            case "D": return .d
            case "E": return .e
            case "F": return .f
            case "G": return .g
            case "H": return .h
            case "I": return .i
            case "J": return .j
            case "K": return .k
            case "L": return .l
            case "M": return .m
            case "N": return .n
            case "O": return .o
            case "P": return .p
            case "Q": return .q
            case "R": return .r
            case "S": return .s
            case "T": return .t
            case "U": return .u
            case "V": return .v
            case "W": return .w
            case "X": return .x
            case "Y": return .y
            case "Z": return .z

            case "0": return .zero
            case "1": return .one
            case "2": return .two
            case "3": return .three
            case "4": return .four
            case "5": return .five
            case "6": return .six
            case "7": return .seven
            case "8": return .eight
            case "9": return .nine

            case "=": return .equals
            case "-": return .minus
            case ";": return .semicolon
            case "'": return .apostrophe
            case ",": return .comma
            case ".": return .period
            case "/": return .forwardSlash
            case "\\": return .backslash
            case "_": return .underscore
            case "[": return .leftBracket
            case "]": return .rightBracket
            
            default: return nil
        }
    }
}
