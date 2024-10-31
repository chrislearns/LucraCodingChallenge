//
//  OptionalView.swift
//  LucraCodingChallenge
//
//  Created by Christopher Guirguis on 10/31/24.
//

import SwiftUI

struct OptionalView<Value, Content: View>: View {
    var value: Value?
    @ViewBuilder var content: (Value) -> Content
    var fallbackContent: (() -> AnyView)?
    var body: some View {
        if let value {
            content(value)
        } else {
            fallbackContent?()
        }
    }
}
