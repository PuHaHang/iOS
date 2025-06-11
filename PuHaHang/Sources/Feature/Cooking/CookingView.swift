//
//  CookingView.swift
//  PuHaHang
//
//  Created by 디해 on 6/11/25.
//

import ComposableArchitecture
import SwiftUI

struct CookingView: View {
    @Bindable var store: StoreOf<CookingReducer>
    
    var body: some View {
        Text("Cooking")
    }
}
