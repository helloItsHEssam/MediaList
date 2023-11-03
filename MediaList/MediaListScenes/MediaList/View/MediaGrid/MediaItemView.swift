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
    @ObservedObject private var viewModel: MediaViewModel
    @State private var image: Image?
    
    init(media: Media, screenSize: CGSize, viewModel: MediaViewModel) {
        self.media = media
        self.screenSize = screenSize
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            let height = media.previewMediaSize?.calculateViewHeight(basedOnScreenWidth: screenSize.width)
            PreviewImage(image: image)
                .frame(width: screenSize.width, height: height)
                .clipped()
        }
        .onAppear {
            fetchImageIfNeeded()
        }
        .overlay(alignment: .bottom) {
            HStack {
                if media.type == .video {
                    Color.clear
                        .frame(width: 30, height: 30)
                    
                    Spacer()
                }
                
                ListText(content: media.title ?? "")
                
                if media.type == .video {
                    
                    Spacer()
                    Image("play")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }
            }
            .padding([.all], 8)
            .frame(maxWidth: .infinity)
            .background(MediaListTheme.supplementaryBackground)
        }
    }
    
    private func fetchImageIfNeeded() {
        guard image == nil else { return }
        
        viewModel.fetchMediaImage(WithImageUrl: media.previewLink) { previewImage in
            image = previewImage
        }
    }
}
