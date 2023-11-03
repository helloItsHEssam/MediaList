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
    
    @StateObject private var viewModel = ViewModelFactory.shared.createMediaViewModel()

    var body: some View {
        ZStack {
 
            switch viewModel.viewState {
            case .error(let alertContent):
                AlertView(content: alertContent) {
                    viewModel.fetchMediaList()
                }

            case .loading: ProgressView()

            case .result:
                GeometryReader { geometry in
                    ScrollView(showsIndicators: true) {
                        let size = CGSize(width: geometry.size.width - 40, height: geometry.size.height)
                        MediaGridView(mediaList: $viewModel.mediaList,
                                      screenSize: size, viewModel: viewModel)
                    }
                }
            }
        }
        .modifier(ViewAlignment(alignment: .center))
        .onAppear {
            viewModel.fetchMediaList()
        }
    }
}
