//
//  AXUIElement_Utils.swift
//  NMA
//
//  Created by endeavour42 on 23/06/2023.
//

import ApplicationServices

extension AXUIElement {
    
    static var systemWideRoot: AXUIElement {
        AXUIElementCreateSystemWide()
    }
    
    static func appElement(_ pid: pid_t) -> AXUIElement {
        AXUIElementCreateApplication(pid)
    }
    
    var attributes: [String]? {
        var names: CFArray?
        let err = AXUIElementCopyAttributeNames(self, &names)
        guard err == .success else { return nil }
        return names as! [String]?
    }
    
    var parameterizedAttributes: [String]? {
        var names: CFArray?
        let err = AXUIElementCopyParameterizedAttributeNames(self, &names)
        guard err == .success else { return nil }
        return names as! [String]?
    }
    
    func parameterizedAttributeValue(_ attribute: String, parameter: String) -> CFTypeRef? {
        var value: CFTypeRef?
        let err = AXUIElementCopyParameterizedAttributeValue(self, attribute as CFString, parameter as CFString, &value)
        return value
    }
    
    func attributeValueCount(_ attribute: String) -> Int {
        var count = -1
        let err = AXUIElementGetAttributeValueCount(self, attribute as CFString, &count)
        return count
    }
    
    func attributeValue(_ attribute: String) -> CFTypeRef? {
        if attribute == "AXSections" {
            return "AXSections:TODO" as CFString
        }
        var value: CFTypeRef?
        let err = AXUIElementCopyAttributeValue(self, attribute as CFString, &value)
        assert(err == .apiDisabled || err == .success || err == .noValue || err == .attributeUnsupported || err == .failure || err == .cannotComplete || err == .invalidUIElement || err == .illegalArgument)
        return value
    }
    
    var actions: [String]? {
        var names: CFArray?
        let err = AXUIElementCopyActionNames(self, &names)
        guard err == .success else { return nil }
        return names as! [String]?
    }
    
    func actionDescription(_ action: String) -> String? {
        var description: CFString?
        let err = AXUIElementCopyActionDescription(self, action as CFString, &description)
        guard err == .success, let description else { return nil }
        return description as String
    }
    
    func element(at point: CGPoint) -> AXUIElement? {
        var element: AXUIElement?
        let err = AXUIElementCopyElementAtPosition(self, Float(point.x), Float(point.y), &element)
        guard err == .success else { return nil }
        return element
    }
    
//    var identifier: Int {
//        attributeValue(kAXIdentifierAttribute) as! Int
//    }
    
    var children: [AXUIElement]? {
        attributeValue(kAXChildrenAttribute) as! [AXUIElement]?
    }
    
    var focusedUIElement: AXUIElement? {
        attributeValue(kAXFocusedUIElementAttribute) as! AXUIElement?
    }
    
    var isFrontmostUIElement: Bool {
        attributeValue(kAXFrontmostAttribute) as! CFBoolean? == kCFBooleanTrue
    }
    
    var role: String? {
        attributeValue(kAXRoleAttribute) as! String?
    }
    
    var roleDescription: String? {
        attributeValue(kAXRoleDescriptionAttribute) as! String?
    }
    
    var mainWindow: AXUIElement? {
        attributeValue(kAXMainWindowAttribute) as! AXUIElement?
    }
    
    var focusedWindow: AXUIElement? {
        attributeValue(kAXFocusedWindowAttribute) as! AXUIElement?
    }
    
    var extrasMenuBar: AXUIElement? {
        attributeValue(kAXExtrasMenuBarAttribute) as! AXUIElement?
    }
    
    var title: String? {
        attributeValue(kAXTitleAttribute) as! String?
    }
    
    var childrenInNavigationOrder: [AXUIElement]? {
        attributeValue("AXChildrenInNavigationOrder") as! [AXUIElement]?
    }
    
    var isEnhancedUserInterface: Bool {
        attributeValue("AXEnhancedUserInterface") as! CFBoolean? == kCFBooleanTrue
    }
    
    var preferredLanguage: String? {
        attributeValue("AXPreferredLanguage") as! String?
    }
    
    var isHidden: Bool {
        attributeValue(kAXHiddenAttribute) as! CFBoolean? == kCFBooleanTrue
    }
    
    var menuBar: AXUIElement? {
        attributeValue(kAXMenuBarAttribute) as! AXUIElement?
    }
    var windows: [AXUIElement]? {
        attributeValue(kAXWindowsAttribute) as! [AXUIElement]?
    }
    
    var topLevelElements: [AXUIElement]? {
        attributeValue("AXFunctionRowTopLevelElements") as! [AXUIElement]?
    }
    
    var closeButton: AXUIElement? {
        attributeValue(kAXCloseButtonAttribute) as! AXUIElement?
    }
    
    var minimizeButton: AXUIElement? {
        attributeValue(kAXMinimizeButtonAttribute) as! AXUIElement?
    }
    
    var zoomButton: AXUIElement? {
        attributeValue(kAXZoomButtonAttribute) as! AXUIElement?
    }
    
    var fullScreenButton: AXUIElement? {
        attributeValue(kAXFullScreenButtonAttribute) as! AXUIElement?
    }
    
    var defaultButton: AXUIElement? {
        attributeValue(kAXDefaultButtonAttribute) as! AXUIElement?
    }
    
    var cancelButton: AXUIElement? {
        attributeValue(kAXCancelButtonAttribute) as! AXUIElement?
    }
    
    var menuItemMarkChar: String? {
        attributeValue(kAXMenuItemMarkCharAttribute) as! String?
    }
    
    var isMinimized: Bool {
        attributeValue(kAXMinimizedAttribute) as! CFBoolean? == kCFBooleanTrue
    }
    
    var placeholderValue: String? {
        attributeValue(kAXPlaceholderValueAttribute) as! String?
    }
    
    var isFullScreen: Bool {
        attributeValue("AXFullScreen") as! CFBoolean? == kCFBooleanTrue
    }
    
    var size: CGSize? {
        let val = attributeValue(kAXSizeAttribute)
        guard let val else { return nil }
        let v = val as! AXValue
        assert(AXValueGetType(v) == .cgSize)
        var size = CGSize.zero
        let done = AXValueGetValue(v, .cgSize, &size)
        assert(done)
        return size
    }
    
    var position: CGPoint? {
        let val = attributeValue(kAXPositionAttribute)
        guard let val else { return nil }
        let v = val as! AXValue
        assert(AXValueGetType(v) == .cgPoint)
        var pos = CGPoint.zero
        let done = AXValueGetValue(v, .cgPoint, &pos)
        assert(done)
        return pos
    }
    
    var frame: CGRect? {
        let val = attributeValue("AXFrame")
        guard let val else { return nil }
        let v = val as! AXValue
        assert(AXValueGetType(v) == .cgRect)
        var rect = CGRect.zero
        let done = AXValueGetValue(v, .cgRect, &rect)
        assert(done)
        return rect
    }
    
    var isEnabled: Bool {
        attributeValue(kAXEnabledAttribute) as! CFBoolean? == kCFBooleanTrue
    }
    
    var selectedTextRange: CFRange? {
        let val = attributeValue(kAXSelectedTextRangeAttribute)
        guard let val else { return nil }
        let v = val as! AXValue
        assert(AXValueGetType(v) == .cfRange)
        var range = CFRange()
        let done = AXValueGetValue(v, .cfRange, &range)
        assert(done)
        return range
    }
    
    var selectedText: String? {
        attributeValue(kAXSelectedTextAttribute) as! String?
    }
    
    var focusedApplication: AXUIElement? {
        attributeValue(kAXFocusedApplicationAttribute) as! AXUIElement?
    }
}

extension AXUIElement {
    func debug(level: Int = 0) {
        func indent(_ level: Int) -> String {
            (0 ..< level).reduce("") { r, e in
                r + "    "
            }
        }
        
        print(indent(level), "attributes:")
        for attribute in attributes ?? [] {
            let value = attributeValue(attribute)
            let count = attributeValueCount(attribute)
            print(indent(level), "  - \(attribute), count: \(count), value: \(String(describing: value))")
        }
        
        print(indent(level), "parameterizedAttributes:")
        for attribute in parameterizedAttributes ?? [] {
            let value = parameterizedAttributeValue(attribute, parameter: "")
            print(indent(level), "  - \(attribute): \(String(describing: value))")
        }
        
        print(indent(level), "actions:")
        for action in self.actions ?? [] {
            let description = actionDescription(action)
            print(indent(level), "  - \(action): \(description)")
        }

        print(indent(level), "children: \(String(describing: children))")
        print(indent(level), "childrenInNavigationOrder: \(String(describing: childrenInNavigationOrder))")
        print(indent(level), "focusedUIElement: \(String(describing: focusedUIElement))")
        print(indent(level), "isFrontmostUIElement: \(String(describing: isFrontmostUIElement))")
        print(indent(level), "role: \(String(describing: role))")
        print(indent(level), "roleDescription: \(String(describing: roleDescription))")
        print(indent(level), "mainWindow: \(String(describing: mainWindow))")
        print(indent(level), "focusedWindow: \(String(describing: focusedWindow))")
        print(indent(level), "extrasMenuBar: \(String(describing: extrasMenuBar))")
        print(indent(level), "title: \(String(describing: title))")
        print(indent(level), "isEnhancedUserInterface: \(String(describing: isEnhancedUserInterface))")
        print(indent(level), "preferredLanguage: \(String(describing: preferredLanguage))")
        print(indent(level), "isHidden: \(String(describing: isHidden))")
        print(indent(level), "menuBar: \(String(describing: menuBar))")
        print(indent(level), "windows: \(String(describing: windows))")
        print(indent(level), "topLevelElements: \(String(describing: topLevelElements))")
        print(indent(level), "closeButton: \(String(describing: closeButton))")
        print(indent(level), "defaultButton: \(String(describing: defaultButton))")
        print(indent(level), "fullScreenButton: \(String(describing: fullScreenButton))")
        print(indent(level), "menuItemMarkChar: \(String(describing: menuItemMarkChar))")
        print(indent(level), "isMinimized: \(String(describing: isMinimized))")
        print(indent(level), "minimizeButton: \(String(describing: minimizeButton))")
        print(indent(level), "zoomButton: \(String(describing: zoomButton))")
        print(indent(level), "cancelButton: \(String(describing: cancelButton))")
        print(indent(level), "placeholderValue: \(String(describing: placeholderValue))")
        print(indent(level), "isFullScreen: \(String(describing: isFullScreen))")
        print(indent(level), "topLevelElements: \(String(describing: size))")
        print(indent(level), "position: \(String(describing: position))")
        print(indent(level), "frame: \(String(describing: frame))")
        print(indent(level), "isEnabled: \(String(describing: isEnabled))")
        print(indent(level), "selectedTextRange: \(String(describing: selectedTextRange))")
        print(indent(level), "selectedText: \(String(describing: selectedText))")
        print(indent(level), "focusedApplication: \(String(describing: focusedApplication))")

        for child in children ?? [] {
            child.debug(level: level + 1)
        }
        
        if let focusedApplication {
            focusedApplication.debug(level: level + 1)
        }
    }
}


extension AXUIElement {
    
    static func effectiveType(_ type: String, value: CFTypeRef) -> String {
        if type == "AXValue" {
            let value = value as! AXValue
            let valueType = AXValueGetType(value)
            switch valueType {
            case .cgPoint:
                return "\(type).cgPoint"
            case .cgSize:
                return "\(type).cgSize"
            case .cgRect:
                return "\(type).cgRect"
            case .cfRange:
                return "\(type).cfRange"
            default: fatalError()
            }
        } else {
            return type
        }
    }
    
    static func effectiveValue(_ value: CFTypeRef, type: String) -> String {
        if type == "CFDictionary" {
            return "DICT"
        } else if type == "CFArray" {
            let array = value as! [AnyObject]
            let count = array.count
            var elementType = "?"
            if count != 0 {
                let elem = array[0]
                elementType = getCFType(elem)
                return "\(count) x \(elementType)"
            } else {
                return "empty array"
            }
        } else if type == "AXValue" {
            let value = value as! AXValue
            let valueType = AXValueGetType(value)
            switch valueType {
            case .cgPoint:
                var v = CGPoint()
                AXValueGetValue(value, valueType, &v)
                return "\(v)"
            case .cgSize:
                var v = CGSize()
                AXValueGetValue(value, valueType, &v)
                return "\(v)"
            case .cgRect:
                var v = CGRect()
                AXValueGetValue(value, valueType, &v)
                return "\(v)"
            case .cfRange:
                var v = CFRange()
                AXValueGetValue(value, valueType, &v)
                return "\(v)"
            default: fatalError()
            }
        } else {
            return "\(value)"
        }
    }
}
