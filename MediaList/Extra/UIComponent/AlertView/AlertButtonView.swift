//
//  AlertButtonView.swift
//  MediaList
//
//  Created by Hessam Mahdiabadi on 11/3/23.
//

import SwiftUI
import MediaListUIComponent
import MediaListColor

struct AlertButtonView: View {
    
    typealias Action = () -> Void
    
    private let action: Action
    private let title: String
    
    init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            DetailText(content: title)
                .padding(EdgeInsets(top: 12, leading: 32,
                                    bottom: 12, trailing: 32))
        }
        .background(MediaListTheme.background)
        .cornerRadius(12)
    }
}
