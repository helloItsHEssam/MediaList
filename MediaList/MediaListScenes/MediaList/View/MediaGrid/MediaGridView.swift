//
//  MediaGridView.swift
//  MediaList
//
//  Created by Hessam Mahdiabadi on 11/3/23.
//

import SwiftUI
import Domain

struct MediaGridView: View {
    
    private var mediaList: [Media]
    private var screenSize: CGSize
    
    init(mediaList: [Media], screenSize: CGSize) {
        self.mediaList = mediaList
        self.screenSize = screenSize
    }
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible())], spacing: 20) {
            ForEach(mediaList) { media in
                MediaItemView(media: media, screenSize: screenSize)
                    .cornerRadius(12)
            }
        }
        .padding([.all], 20)
    }
}
