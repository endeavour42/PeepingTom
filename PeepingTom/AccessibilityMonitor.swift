//
//  AccessibilityMonitor.swift
//  PeepingTom
//
//  Created by endeavour42 on 23/06/2023.
//

import ApplicationServices

class AccessibilityMonitor: ObservableObject {
    @Published var permissionGranted: Bool = false
    
    init() {
        // no way to get notifications about accessibility permission status?
        granted = AXIsProcessTrusted()
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            self.granted = AXIsProcessTrusted()
        }
    }
    
    private var granted: Bool {
        get { permissionGranted }
        set {
            if permissionGranted != newValue {
                permissionGranted = newValue
            }
        }
    }
    
    private func updatePermission(_ granted: Bool) {
        if permissionGranted != granted {
            permissionGranted = granted
        }
    }
    
    func requestPermission() {
        granted = AXIsProcessTrusted()
        if !granted {
            granted = AXIsProcessTrustedWithOptions([kAXTrustedCheckOptionPrompt.takeRetainedValue() : true] as CFDictionary)
        }
    }
}
