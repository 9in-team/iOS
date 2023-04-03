//
//  File.swift
//  9in.team
//
//  Created by 조상현 on 2023/04/03.
//

import SwiftUI

struct LocationViewWrapper: UIViewRepresentable {
    
    var onUpdate: (CGPoint) -> Void
    
    func makeUIView(context: Context) -> LocationView {
        let view = LocationView()
        view.onUpdate = onUpdate
        return view
    }

    func updateUIView(_ uiView: LocationView, context: Context) {
    }
    
    class LocationView: UIView {
        
        var onUpdate: ((CGPoint) -> Void)?
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            isUserInteractionEnabled = true
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            isUserInteractionEnabled = true
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let touch = touches.first else { return }
            let location = touch.location(in: self)
            send(location)
        }

        func send(_ location: CGPoint) {
            if bounds.contains(location) {
                onUpdate?(CGPoint(x: round(location.x), y: round(location.y)))
            }
        }
        
    }
    
}

struct TouchLocater: ViewModifier {

    let perform: (CGPoint) -> Void

    func body(content: Content) -> some View {
        content
            .overlay(LocationViewWrapper(onUpdate: perform))
    }
    
}

extension View {
    
    func onTouch(perform: @escaping (CGPoint) -> Void) -> some View {
        modifier(TouchLocater(perform: perform))
    }
    
}
