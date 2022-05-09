//
//  Keys.swift
//  KeyCatcher
//
//  Created by Mohammad Al-Ahdal on 2022-05-07.
//

import Foundation

enum Modifiers: String {
    case alt = "⎇"
    case shift = "⇧"
    case cmd = "⌘"
    case ctrl = "⌃"
}


// Code: https://gist.github.com/swillits/df648e87016772c7f7e5dbed2b345066
enum Keycode: UInt16 {
    
    // Layout-independent Keys
    // eg.These key codes are always the same key on all layouts.
    case returnKey                  = 0x24
    case tab                        = 0x30
    case space                      = 0x31
    case delete                     = 0x33
    case escape                     = 0x35
    case leftArrow                  = 0x7B
    case rightArrow                 = 0x7C
    case downArrow                  = 0x7D
    case upArrow                    = 0x7E
    case f1                         = 0x7A
    case f2                         = 0x78
    case f4                         = 0x76
    case f5                         = 0x60
    case f6                         = 0x61
    case f7                         = 0x62
    case f3                         = 0x63
    case f8                         = 0x64
    case f9                         = 0x65
    case f10                        = 0x6D
    case f11                        = 0x67
    case f12                        = 0x6F
    case f13                        = 0x69
    case f14                        = 0x6B
    case f15                        = 0x71
    case f16                        = 0x6A
    case f17                        = 0x40
    case f18                        = 0x4F
    case f19                        = 0x50
    case f20                        = 0x5A
    
    // US-ANSI Keyboard Positions
    // eg. These key codes are for the physical key (in any keyboard layout)
    // at the location of the named key in the US-ANSI layout.
    case a                          = 0x00
    case b                          = 0x0B
    case c                          = 0x08
    case d                          = 0x02
    case e                          = 0x0E
    case f                          = 0x03
    case g                          = 0x05
    case h                          = 0x04
    case i                          = 0x22
    case j                          = 0x26
    case k                          = 0x28
    case l                          = 0x25
    case m                          = 0x2E
    case n                          = 0x2D
    case o                          = 0x1F
    case p                          = 0x23
    case q                          = 0x0C
    case r                          = 0x0F
    case s                          = 0x01
    case t                          = 0x11
    case u                          = 0x20
    case v                          = 0x09
    case w                          = 0x0D
    case x                          = 0x07
    case y                          = 0x10
    case z                          = 0x06

    case zero                       = 0x1D
    case one                        = 0x12
    case two                        = 0x13
    case three                      = 0x14
    case four                       = 0x15
    case five                       = 0x17
    case six                        = 0x16
    case seven                      = 0x1A
    case eight                      = 0x1C
    case nine                       = 0x19
    
    case equals                     = 0x18
    case minus                      = 0x1B
    case semicolon                  = 0x29
    case apostrophe                 = 0x27
    case comma                      = 0x2B
    case period                     = 0x2F
    case forwardSlash               = 0x2C
    case backslash                  = 0x2A
    case underscore                 = 0x32
    case leftBracket                = 0x21
    case rightBracket               = 0x1E
    
    func toString() -> String {
        switch (self) {
            case .returnKey: return "⏎"
            case .tab: return "⇥"
            case .space: return "' '"
            case .delete: return "⇤"
            case .escape: return "esc"
                
            case .leftArrow: return "←"
            case .rightArrow: return "→"
            case .upArrow: return "↑"
            case .downArrow: return "↓"
                
            case .f1: return "F1"
            case .f2: return "F2"
            case .f3: return "F3"
            case .f4: return "F4"
            case .f5: return "F5"
            case .f6: return "F6"
            case .f7: return "F7"
            case .f8: return "F8"
            case .f9: return "F9"
            case .f10: return "F10"
            case .f11: return "F11"
            case .f12: return "F12"
            case .f13: return "F13"
            case .f14: return "F14"
            case .f15: return "F15"
            case .f16: return "F16"
            case .f17: return "F17"
            case .f18: return "F18"
            case .f19: return "F19"
            case .f20: return "F20"
                
            case .a: return "A"
            case .b: return "B"
            case .c: return "C"
            case .d: return "D"
            case .e: return "E"
            case .f: return "F"
            case .g: return "G"
            case .h: return "H"
            case .i: return "I"
            case .j: return "J"
            case .k: return "K"
            case .l: return "L"
            case .m: return "M"
            case .n: return "N"
            case .o: return "O"
            case .p: return "P"
            case .q: return "Q"
            case .r: return "R"
            case .s: return "S"
            case .t: return "T"
            case .u: return "U"
            case .v: return "V"
            case .w: return "W"
            case .x: return "X"
            case .y: return "Y"
            case .z: return "Z"
                
            case .zero: return "0"
            case .one: return "1"
            case .two: return "2"
            case .three: return "3"
            case .four: return "4"
            case .five: return "5"
            case .six: return "6"
            case .seven: return "7"
            case .eight: return "8"
            case .nine: return "9"
                
            case .equals: return "="
            case .minus: return "-"
            case .semicolon: return ";"
            case .apostrophe: return "'"
            case .comma: return ","
            case .period: return "."
            case .forwardSlash: return "/"
            case .backslash: return "\\"
            case .underscore: return "_"
            case .leftBracket: return "["
            case .rightBracket: return "]"
        }
    }
}

