//
//  ContentView.swift
//  SwiftNest
//
//  Created by tatsubee on 2023/07/31.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("\(diceRoll(2))")
        }
        .padding()
    }

    private func diceRoll(_ seed: Int) -> String {
        let dice = Int.random(in: 1...100)
        let simpleResult = if dice <= 50 { "成功" } else { "失敗" }
        let completeResult = switch dice {
        case 1: "クリティカル！"
        case 2...10: "Extreme成功"
        case 11...25: "Hard成功"
        case 26...50: "成功"
        case 50...95: "失敗"
        case 96...: "ファンブル"
        default: "失敗"
        }

        print("if-switch-expressions is", completeResult)
        return completeResult
    }

    private func hgoe() throws {
        _ = if .random() { 1.0 } else { throw NSError(domain: "", code: -1) }
    }
}

#Preview {
    ContentView()
}
