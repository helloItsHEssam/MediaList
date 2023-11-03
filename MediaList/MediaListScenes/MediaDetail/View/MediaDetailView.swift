//
//  MediaDetailView.swift
//  MediaList
//
//  Created by Hessam Mahdiabadi on 11/3/23.
//

import SwiftUI
import Domain

struct MediaDetailView: View {
    
    private var media: Media
    
    init(media: Media) {
        self.media = media
    }

    var body: some View {
        ZStack {
            
            VStack {
                MediaInformationView(title: "Title", content: media.title)
                Divider()
                MediaInformationView(title: "Info", content: media.description)
            }
        }
        .onAppear {
            logMediaLink()
        }
        .modifier(ViewAlignment(alignment: .center))
    }
    
    private func logMediaLink() {
        print(media)
    }
}
