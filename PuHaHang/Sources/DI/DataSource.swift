//
//  DataSource.swift
//  PuHaHang
//
//  Created by 디해 on 7/2/25.
//

import Data
import Dependencies
import Foundation

extension VersionDataSourceKey: @retroactive DependencyKey {
    public static let liveValue: any VersionDataSource = VersionDataSourceImpl()
}

extension RecipeDataSourceKey: @retroactive DependencyKey {
    public static let liveValue: any RecipeDataSource = RecipeDataSourceImpl()
}

extension RecipePreviewDataSourceKey: @retroactive DependencyKey {
    public static let liveValue: any RecipePreviewDataSource = RecipePreviewDataSourceImpl()
}

extension AudioInputDataSourceKey: @retroactive DependencyKey {
    public static let liveValue: any AudioInputDataSource = AudioInputDataSourceImpl()
}

extension SpeechRecognizerDataSourceKey: @retroactive DependencyKey {
    public static let liveValue: any SpeechRecognizerDataSource = {
        @Dependency(\.audioInputDataSource) var audioInputDataSource
        return SpeechRecognizerDataSourceImpl(audioInputDataSource: audioInputDataSource)
    }()
}
