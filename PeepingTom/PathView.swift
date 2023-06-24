//
//  PathView.swift
//  PeepingTom
//
//  Created by endeavour42 on 24/06/2023.
//

import SwiftUI

struct PathView: NSViewRepresentable {
    var items: [(String, NSImage?)]
    
    func makeNSView(context: Context) -> NSPathControl {
        let c = NSPathControl()
        update(c)
        return c
    }
    
    func updateNSView(_ c: NSPathControl, context: Context) {
        update(c)
    }
    
    private func update(_ c: NSPathControl) {
        //c.pathStyle = NSPathControl.Style.popUp
        c.pathItems = items.map { v in
            let item = NSPathControlItem()
            item.title = v.0
            item.image = v.1
            return item
        }
        print("PATH ITEMS: ", c.pathItems)
        print()
    }
}


