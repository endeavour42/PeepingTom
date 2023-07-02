//
//  Model.swift
//  PeepingTom
//
//  Created by endeavour42 on 24/06/2023.
//

import SwiftUI

struct Row: Identifiable {
    var id: String
    var name: String
    var type: String
    var icon: NSImage?
    var value: String
}

struct NamedElement: Identifiable {
    var id: String { "\(ObjectIdentifier(element))" }
    var element: AXUIElement
    var name: String?
    var type: String?
    var icon: NSImage? = nil
}

enum ElementEnum {
    case element(NamedElement)
    case elements([NamedElement])
}

struct Item {
    var value: ElementEnum
    var actions: [String]?
    var title: String
    var icon: NSImage?
}


struct StackItem {
    var item: Item
    var selection: String
}

