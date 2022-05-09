//
//  KeyCatcherApp.swift
//  KeyCatcher
//
//  Created by Mohammad Al-Ahdal on 2022-05-06.
//

import SwiftUI
import ApplicationServices
import CoreGraphics
import Quartz

@main
struct KeyCatcherApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            VStack{}
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    private var statusItem: NSStatusItem!
    private var popover: NSPopover!
    private var pc: PermissionsChecker!
    private var sc: ShortcutController!
    

    @MainActor func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let window = NSApplication.shared.windows.first {
            window.close()
        }
        statusItem = NSStatusBar.system.statusItem(withLength: 18)
        popover = NSPopover()
        
        pc = PermissionsChecker()
        sc = ShortcutController()
        
        if let statusBarButton = statusItem.button {
            statusBarButton.image = #imageLiteral(resourceName: "StatusBarIcon")
            statusBarButton.image?.size = NSSize(width: 18.0, height: 18.0)
            statusBarButton.image?.isTemplate = true
            statusBarButton.action = #selector(togglePopover)
        }
        
        popover.contentSize = NSSize(width: 500, height: 700)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: ContentView(pc: pc, sc: sc))
        
        // adapted from https://github.com/iMasanari/eikana-bata/
        
        let eventMaskList = [
                    CGEventType.keyDown.rawValue,
                    CGEventType.flagsChanged.rawValue
                ]
                
                let eventMask = eventMaskList.reduce(0) {(prev, mask) in prev | (1 << mask) }
                let observer = UnsafeMutableRawPointer(Unmanaged.passRetained(self).toOpaque())
                
                let callback: CGEventTapCallBack = {(proxy, type, event, refcon) in
                    if let observer = refcon {
                        let selfPtr = Unmanaged<AppDelegate>.fromOpaque(observer).takeUnretainedValue()
                        return selfPtr.eventCallback(proxy: proxy, type: type, event: event)
                    }
                    
                    return Unmanaged.passUnretained(event)
                }
                
                guard let eventTap = CGEvent.tapCreate(
                    tap: .cgSessionEventTap,
                    place: .headInsertEventTap,
                    options: .defaultTap,
                    eventsOfInterest: CGEventMask(eventMask),
                    callback: callback,
                    userInfo: observer
                    ) else {
                        print("failed to create event tap")
                        exit(1)
                }
                
                let runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, eventTap, 0)
                
                CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, .commonModes)
                CGEvent.tapEnable(tap: eventTap, enable: true)
                CFRunLoopRun()
    }
    
    private func eventCallback(proxy: CGEventTapProxy, type: CGEventType, event: CGEvent) -> Unmanaged<CGEvent>? {
        let keycode: CGKeyCode = CGKeyCode(event.getIntegerValueField(.keyboardEventKeycode))
        let modifiers = event.flags.intersection([.maskCommand, .maskShift, .maskControl, .maskAlternate])
        
        let shortcut = Shortcut().getShortcutFromKeyPress(modifiers, keycode)
        let shortcutTriggered = sc.executeShortcutIfAvailable(shortcut);
        if (shortcutTriggered) {
            return nil
        }

        return Unmanaged.passRetained(event)
}
    
    @objc func togglePopover() {
        if let button = statusItem.button {
            if popover.isShown {
                popover.performClose(nil)
            } else {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }
}
