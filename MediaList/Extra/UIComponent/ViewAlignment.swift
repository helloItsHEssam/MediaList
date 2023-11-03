//
//  ViewAlignment.swift
//  MediaList
//
//  Created by Hessam Mahdiabadi on 11/3/23.
//

import SwiftUI
import MediaListColor

struct ViewAlignment: ViewModifier {

    private var alignment: Alignment = .topLeading
    
    init(alignment: Alignment = .topLeading) {
        self.alignment = alignment
    }

    func body(content: Content) -> some View {
        
        ZStack(alignment: alignment) {
            MediaListTheme.background
                .ignoresSafeArea()
            
            content
        }
    }
}

