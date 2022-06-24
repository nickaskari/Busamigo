//
//  DetailMapAnnotationView.swift
//  Busamigo
//
//  Created by Nick Askari on 21/06/2022.
//

import SwiftUI

struct DetailMapAnnotationView: View {
    var body: some View {
        Image(systemName: "mappin.circle.fill")
            .font(.system(size: 25))
            .foregroundColor(.pink)
            .background(Circle()
                .foregroundColor(.white)
                .shadow(radius: 5))
    }
}

struct DetailMapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        DetailMapAnnotationView()
    }
}
