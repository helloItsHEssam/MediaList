//
//  MediaListView.swift
//  MediaList
//
//  Created by Hessam Mahdiabadi on 11/3/23.
//

import SwiftUI
import Domain
import MediaListColor
import MediaListUIComponent

struct MediaListView: View {
    private var list = [Media(title: "hessam", type: .image, previewLink: "111", mediaLink: nil),
                        Media(title: "dsasd", type: .image, previewLink: "222", mediaLink: nil)]
    
    @StateObject private var viewModel = ViewModelFactory.shared.createMediaViewModel()

    var body: some View {
        ZStack {
 
            switch viewModel.viewState {
            case .error(let alertContent):
                AlertView(content: alertContent) {
                    // TODO: -
                }

            case .loading: ProgressView()

            case .result:
                GeometryReader { geometry in
                    ScrollView(showsIndicators: true) {
                        let size = CGSize(width: geometry.size.width - 40, height: geometry.size.height)
                        MediaGridView(mediaList: list, screenSize: size)
                    }
                }
            }
        }
        .modifier(ViewAlignment(alignment: .center))
    }
}
