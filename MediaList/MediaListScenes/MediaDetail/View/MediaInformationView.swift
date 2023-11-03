//
//  MediaInformationView.swift
//  MediaList
//
//  Created by Hessam Mahdiabadi on 11/3/23.
//

import SwiftUI
import Domain
import MediaListColor
import MediaListUIComponent

struct MediaInformationView: View {
    
    private var title: String
    private var content: String?
    
    init(title: String, content: String?) {
        self.title = title
        self.content = content
    }

    var body: some View {
        
        HStack(spacing: 12) {
            TitleText(content: "\(title): ")
            DetailText(content: content ?? "-")
        }
    }
}
