//
//  PermissionsChecker.swift
//  KeyCatcher
//
//  Created by Mohammad Al-Ahdal on 2022-05-07.
//

import ApplicationServices
import Foundation

@MainActor
class PermissionsChecker: ObservableObject {
    @Published var trusted: Bool!;
    
    init() {
        trusted = AXIsProcessTrusted()
    }
    
    func promptToTrust() -> Bool {
        trusted = AXIsProcessTrusted();
        return AXIsProcessTrustedWithOptions([kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true] as NSDictionary)
    }
}
