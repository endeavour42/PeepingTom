//
//  PeepingTomApp.swift
//  PeepingTom
//
//  Created by endeavour42 on 23/06/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        InspectorView().padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

@main struct PeepingTomApp: App {
    var body: some Scene {
        WindowGroup { ContentView() }
    }
}
