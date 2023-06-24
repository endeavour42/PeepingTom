//
//  InspectorView.swift
//  PeepingTom
//
//  Created by endeavour42 on 24/06/2023.
//

import SwiftUI

struct InspectorView: View {
    @StateObject private var processModel = ProcessModel()
    @StateObject private var monitor = AccessibilityMonitor()

    var body: some View {
        HStack {
            Text(monitor.permissionGranted ? "Granted" : "Please enable Accessibility permissions")
            if !monitor.permissionGranted {
                Button("request Again") {
                    monitor.requestPermission()
                }
            }
        }
        ElementView(item: .init(value: .elements(processModel.elements), title: "TODO"))
            .onAppear {
                monitor.requestPermission()
            }
    }
}
