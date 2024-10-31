//
//  PresentationButton.swift
//  LucraCodingChallenge
//
//  Created by Christopher Guirguis on 10/31/24.
//

import SwiftUI

public enum PresentationButtonMode: Equatable {
    case popover
    case sheet(detents: Set<PresentationDetent>)
    case fullscreen
}

public struct PresentationButton<S: View, B: View>: View {
    public init(presentationMode: PresentationButtonMode,
                @ViewBuilder sheetContent: @escaping (Binding<Bool>) -> S,
                @ViewBuilder buttonContent: @escaping () -> B) {
        self.presentationMode = presentationMode
        self.sheetContent = sheetContent
        self.buttonContent = buttonContent
    }
    @State public var showSheet = false
    public var presentationMode: PresentationButtonMode = .sheet(detents: [.large])
    @ViewBuilder public var sheetContent: (Binding<Bool>) -> S
    @ViewBuilder public var buttonContent: () -> B
    
    var sheetDetents: Set<PresentationDetent>? {
        if case .sheet(let detents) = presentationMode {
            return detents
        } else {
            return nil
        }
    }
    public var body: some View {
        
        Button {
            self.showSheet = true
        } label: {
            buttonContent()
        }
        .ifLet(sheetDetents) {view, value in
            return view.sheet(isPresented: $showSheet){
                sheetContent($showSheet)
                    .presentationDetents(value)
            }
        }
        .if(presentationMode == .popover) {view in
            view.popover(isPresented: $showSheet){
                sheetContent($showSheet)
                    .presentationCompactAdaptation(.popover)
            }
        }
        .if(presentationMode == .fullscreen) {view in
            view.fullScreenCover(isPresented: $showSheet){
                sheetContent($showSheet)
            }
        }
    }
}
