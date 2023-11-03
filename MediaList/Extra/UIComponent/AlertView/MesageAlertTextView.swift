//
//  MesageAlertTextView.swift
//  MediaList
//
//  Created by Hessam Mahdiabadi on 11/3/23.
//

import SwiftUI
import MediaListFont
import MediaListColor
import MediaListUIComponent

struct MesageAlertTextView: View {
    
    private var content: String
    
    init(content: String) {
        self.content = content
    }

    var body: some View {
        DetailText(content: content)
    }
}
