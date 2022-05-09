//
//  ContentView.swift
//  KeyCatcher
//
//  Created by Mohammad Al-Ahdal on 2022-05-06.
//

import SwiftUI
import ApplicationServices

struct ContentView: View {
    
    @StateObject private var pc: PermissionsChecker
    @StateObject private var sc: ShortcutController
    @State private var showingPopover: Bool = false
    @StateObject private var currentlyCreatingShortcut: Shortcut
    @State private var localEvent: Any?
    @State private var commandMap: [String : String] = [:]
    
    init(pc: PermissionsChecker, sc: ShortcutController) {
        self._pc = StateObject(wrappedValue: pc)
        self._sc = StateObject(wrappedValue: sc)
        self._currentlyCreatingShortcut = StateObject(wrappedValue: Shortcut())
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Key Catcher").font(.system(size: 30, weight: .light, design: .default)).padding()
            List{
                ForEach($sc.shortcuts.values, id: \.id) { shortcut in
                    HStack(alignment: .center){
                        Text(shortcut.description.wrappedValue).padding()
                        TextField("", text: shortcut.command).padding().textFieldStyle(.roundedBorder)
                        Button(action: {() in
                            sc.removeShortcut(shortcut.wrappedValue)
                        }) {
                            Label("", systemImage: "trash")
                        }.accentColor(.red).buttonStyle(.link)
                    }
                }
                Button(action: {() in
                    showingPopover = true
                    
                    localEvent = NSEvent.addLocalMonitorForEvents(matching: [.keyDown], handler: {(event) in
                        let modifiers = event.modifierFlags.intersection(.deviceIndependentFlagsMask)
                        let keys = event.keyCode
                        
                        _ = currentlyCreatingShortcut.getShortcutFromKeyPress(modifiers,keys)
                        return nil
                        }
                    )
                }) {
                    Label("Add", systemImage: "plus")
                }.buttonStyle(.link)
                    .popover(isPresented: $showingPopover, arrowEdge: .trailing) {
                        HStack(alignment: .center){
                            Text(currentlyCreatingShortcut.description).frame(width: 100, height: 30, alignment: .center).padding()
                            Button(action: {() in
                                if !currentlyCreatingShortcut.description.isEmpty {
                                    sc.addShortcut(Shortcut(currentlyCreatingShortcut))
                                }
                            }) {
                                Label("", systemImage: "plus")
                            }.padding(.trailing, 20).buttonStyle(.link)
                        }
                        .onDisappear(perform: {() in
                            if localEvent != nil {
                                NSEvent.removeMonitor(localEvent!)
                            } else {
                                print("Could not remove localEvent because it did not exist")
                            }
                        })
                    }
            }.listStyle(.sidebar)
        }.frame(width: 500, height: 700)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(pc: PermissionsChecker(), sc: ShortcutController())
    }
}
