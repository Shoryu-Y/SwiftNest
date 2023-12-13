//
//  SwiftUIView.swift
//  
//
//  Created by tatsubee on 2023/12/13.
//

import Singleton
import SwiftUI

struct NestView: View {
    var body: some View {
        Image(.iconNest)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
            .onTapGesture {
                Singleton.shared.hoge()
            }
    }
}

#Preview {
    NestView()
}
