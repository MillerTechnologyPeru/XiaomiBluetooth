//
//  SubtitleRow.swift
//  
//
//  Created by Alsey Coleman Miller on 4/12/23.
//

import Foundation
import SwiftUI

internal struct SubtitleRow: View {
    
    let title: Text
    
    let subtitle: Text?
    
    init(title: Text, subtitle: Text? = nil) {
        self.title = title
        self.subtitle = subtitle
    }
    
    static func verbatim(title: String, subtitle: String? = nil) -> some View {
        SubtitleRow(
            title: Text(verbatim: title),
            subtitle: subtitle.flatMap { Text(verbatim: $0) }
        )
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            title
            if let subtitle = subtitle {
                subtitle
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

#if DEBUG
struct SubtitleRow_Previews: PreviewProvider {
    
    static var previews: some View {
        List {
            SubtitleRow.verbatim(
                title: "Product Type",
                subtitle: "LYWSD03MMC"
            )
            SubtitleRow.verbatim(
                title: "Address",
                subtitle: "A4:C1:38:78:3C:8D"
            )
        }
    }
}
#endif
