//
//  ProcessModel.swift
//  PeepingTom
//
//  Created by endeavour42 on 24/06/2023.
//

import Cocoa

class ProcessModel: ObservableObject {
    @Published var elements: [NamedElement] = []

    init() {
        elements = NSWorkspace.shared.runningApplications.map { v in
            NamedElement(element: .appElement(v.processIdentifier), name: v.localizedName, type: v.activationPolicy.name, icon: v.icon)
        }
        elements.insert(NamedElement(element: .systemWideRoot, name: "<systemWideRoot>", type: "<current>"), at: 0)
    }
}
