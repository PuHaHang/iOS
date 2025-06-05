//
//  MainView.swift
//  PuHaHang
//
//  Created by 디해 on 5/19/25.
//

import SwiftUI

struct MainView: View {
    let intro: Intro
    
    var body: some View {
        VStack {
            Text("추천 버전: \(intro.recommendVersion)")
            Text("최소 버전: \(intro.minVersion)")
        }
    }
}
