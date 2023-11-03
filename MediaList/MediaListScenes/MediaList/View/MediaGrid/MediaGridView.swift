//
//  MediaGridView.swift
//  MediaList
//
//  Created by Hessam Mahdiabadi on 11/3/23.
//

import SwiftUI
import Domain

struct MediaGridView: View {
    
    @Binding private var mediaList: [Media]
    private var screenSize: CGSize
    @ObservedObject private var viewModel: MediaViewModel
    
    init(mediaList: Binding<[Media]>, screenSize: CGSize, viewModel: MediaViewModel) {
        self._mediaList = mediaList
        self.screenSize = screenSize
        self.viewModel = viewModel
    }
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible())], spacing: 20) {
            ForEach(mediaList) { media in
                MediaItemView(media: media, screenSize: screenSize, viewModel: viewModel)
                    .cornerRadius(12)
                    .onTapGesture {
                        viewModel.selected(media: media)
                    }
            }
        }
        .padding([.all], 20)
    }
}
