//
//  MediaItemView.swift
//  MediaList
//
//  Created by Hessam Mahdiabadi on 11/3/23.
//

import SwiftUI
import MediaListUIComponent
import MediaListColor
import Domain

struct MediaItemView: View {
    
    private var media: Media
    private var screenSize: CGSize
    @State private var image: Image?
    
    init(media: Media, screenSize: CGSize) {
        self.media = media
        self.screenSize = screenSize
    }
    
    var body: some View {
        ZStack {
            PreviewImage(image: $image)
                .frame(width: screenSize.width, height: screenSize.width * 1.25)
                .clipped()
        }
        .overlay(alignment: .bottom) {
            HStack {
                Color.clear
                    .frame(width: 30, height: 30)
                
                Spacer()
                ListText(content: media.title ?? "")
                
                Spacer()
                Color.green
                    .frame(width: 30, height: 30)
            }
            .padding([.all], 8)
            .frame(maxWidth: .infinity)
            .background(MediaListTheme.supplementaryBackground)
        }
    }
}
