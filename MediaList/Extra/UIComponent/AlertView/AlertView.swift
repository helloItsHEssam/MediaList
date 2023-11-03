//
//  AlertView.swift
//  MediaList
//
//  Created by Hessam Mahdiabadi on 11/3/23.
//

import SwiftUI
import MediaListColor

struct AlertView: View {
    typealias TryAgainCallBackType = () -> Void
    
    private var content: AlertContent
    private var tryAgain: TryAgainCallBackType

    init(content: AlertContent, tryAgain: @escaping TryAgainCallBackType) {
        self.content = content
        self.tryAgain = tryAgain
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.opacity(0.7)
                    .ignoresSafeArea()
                
                VStack(spacing: 32) {
                    MesageAlertTextView(content: content.message ?? "Error")
                        .padding([.leading, .trailing, .top], 20)
                    
                    AlertButtonView(title: "try again!") {
                        tryAgain()
                    }
                    .padding(.bottom, 20)
                }
                .frame(width: geometry.size.width - 80)
                .background(MediaListTheme.supplementaryBackground)
                .cornerRadius(12)
                .transition(.scale)
            }
        }
    }
}
