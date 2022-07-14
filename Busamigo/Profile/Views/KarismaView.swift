//
//  KarismaView.swift
//  Busamigo
//
//  Created by Nick Askari on 02/06/2022.
//

import SwiftUI

struct KarismaView: View {
    private var value: Double
    private let defaultWidth = UIScreen.screenWidth * 0.9
    private let defaultHeight: CGFloat = 20
    
    init(value: Double) {
        if value < 7 {
            self.value = 7
        } else {
            self.value = value
        }
    }
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("🫤")
                Spacer()
                Text("🤠")
            }
            .padding(.horizontal, 40)
            
            ZStack(alignment: .leading) {
                Capsule(style: .continuous)
                    .foregroundColor(.gray.opacity(0.5))
                    .frame(width: defaultWidth, height: defaultHeight)
                Capsule(style: .continuous)
                    .foregroundColor(karismaColor())
                    .frame(width: defaultWidth * (value / 100), height: defaultHeight)
            }
            .fixedSize()
        }
    }
    
    private func karismaColor() -> Color {
        switch value {
        case 0..<33:
            return .pink
        case 33..<67:
            return .orange
        default:
            return .mint
        }
    }
}






struct KarismaView_Previews: PreviewProvider {
    static var previews: some View {
        KarismaView(value: 20.0)
    }
}
