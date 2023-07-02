//
//  ElementView.swift
//  PeepingTom
//
//  Created by endeavour42 on 24/06/2023.
//

import SwiftUI

struct ElementView: View {
    @State var item: Item
    @State private var selectedRow: String?
    @State var stack: [StackItem] = []

    var body: some View {
        ScrollViewReader { scrollReader in
            VStack {
                pathView()
                backButton(scrollReader: scrollReader)
                attributeTable()
                actionTable()
                openButton()
            }
        }
    }
    
    private func pathView() -> some View {
        PathView(items: stack.map { v in
            (v.item.title, v.item.icon)
        })
    }
    
    private func backButton(scrollReader: ScrollViewProxy) -> some View {
        HStack {
            Button {
                let sel = popView()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    scrollReader.scrollTo(sel)
                }
            } label: {
                Image(systemName: "arrowshape.backward.fill")
            }
            .disabled(!canPopElement)
            .keyboardShortcut(.cancelAction)
            Spacer()
        }
    }
    
    private func attributeTable() -> some View {
        Table(of: Row.self, selection: $selectedRow) {
            TableColumn("Attribute") { v in
                HStack {
                    if let icon = v.icon {
                        Image(nsImage: icon)
                            .resizable()
                            .frame(width: 32, height: 32)
                    }
                    Text(v.name)
                }
            }
            TableColumn("Type", value: \.type)
            TableColumn("Value", value: \.value)
        } rows: {
            switch item.value {
            case .element(let element):
                ForEach(element.element.attributes ?? []) { attribute in
                    let _ = print(attribute)
                    if let value = element.element.attributeValue(attribute) {
                        let type = getCFType(value)
                        let et = AXUIElement.effectiveType(type, value: value)
                        let ev = AXUIElement.effectiveValue(value, type: type)
                        TableRow(Row(id: attribute, name: attribute, type: et, value: "\(ev)"))
                    } else {
                        TableRow(Row(id: attribute, name: attribute, type: "–", value: "–"))
                    }
                }
            case .elements(let elements):
                let elements = elements
                ForEach(elements) { element in
                    TableRow(
                        Row(
                            id: element.id,
                            name: element.name ?? "\(ObjectIdentifier(element.element))",
                            type: element.type ?? "AXUIElement",
                            icon: element.icon,
                            value: "\(element)"
                        )
                    )
                }
            }
        }
    }

    private func actionTable() -> some View {
        Table(of: String.self, selection: $selectedRow) {
            TableColumn("Action", value: \.self)
        } rows: {
            let actions = switch item.value {
                case .element(let element):
                    element.element.actions ?? []
                default:
                    [] as [String]
            }
            ForEach(actions) { action in
                let _ = print(action)
                TableRow(action)
            }
        }
    }

    private func openButton() -> some View {
        HStack {
            Spacer()
            Button("Open") {
                let selectedRow = selectedRow!
                print("\(selectedRow)")
                
                switch item.value {
                case .element(let element):
                    let value = element.element.attributeValue(selectedRow)
                    let actions = element.element.actions
                    
                    if let array = value as? [AXUIElement] {
                        let value = ElementEnum.elements(array.map { NamedElement(element: $0)})
                        pushView(.init(value: value, actions: actions, title: "TODO"))
                    } else {
                        let subElement = value as! AXUIElement?
                        if let subElement {
                            let value = ElementEnum.element(NamedElement(element: subElement))
                            pushView(.init(value: value, actions: actions, title: "TODO"))
                        }
                    }
                    
                case .elements(let elements):
                    let el = elements.first { el in
                        "\(el.id)" == selectedRow
                    }
                    assert(el != nil)
                    pushView(.init(value: .element(el!), actions: el!.element.actions, title: "TODO"))
                }
            }
            .disabled(selectedRow == nil)
            .keyboardShortcut(.defaultAction)
            .buttonStyle(DefaultButtonStyle())
            .padding()
        }
    }
    
    private func pushItem(item: Item, selection: String) {
        stack.append(.init(item: item, selection: selection))
    }
    
    private func popElement() -> (Item, String) {
        let v = stack.popLast()!
        return (v.item, v.selection)
    }
    
    private var canPopElement: Bool {
        !stack.isEmpty
    }
    
    private func pushView(_ item: Item) {
        pushItem(item: self.item, selection: selectedRow!)
        selectedRow = nil
        self.item = item
    }
    
    private func popView() -> String {
        precondition(canPopElement)
        var sel = ""
        (item, sel) = popElement()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            selectedRow = sel
        }
        return sel
    }
}
