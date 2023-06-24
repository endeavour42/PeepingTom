//
//  Utils.swift
//  PeepingTom
//
//  Created by endeavour42 on 24/06/2023.
//

import Cocoa
import ApplicationServices

func getCFType(_ value: CFTypeRef) -> String {
    if CFGetTypeID(value) == AXUIElementGetTypeID() {
        return "AXUIElement"
    } else if CFGetTypeID(value) == AXValueGetTypeID() {
        return "AXValue"
    } else if CFGetTypeID(value) == CFStringGetTypeID() {
        return "CFString"
    } else if CFGetTypeID(value) == CFBooleanGetTypeID() {
        return "CFBoolean"
    } else if CFGetTypeID(value) == CFArrayGetTypeID() {
        return "CFArray"
    } else if CFGetTypeID(value) == CFDictionaryGetTypeID() {
        return "CFDictionary"
    } else {
        fatalError()
    }
}

extension NSApplication.ActivationPolicy {
    var name: String {
        switch self {
        case .regular: return "regular app"
        case .accessory: return "accessory app"
        case .prohibited: return "non ui process"
        @unknown default:
            fatalError()
        }
    }
}

// this is bad in general... but ok for this test
extension String: Identifiable {
    public var id: String { self }
}

