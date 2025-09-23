//
//  Dependency.swift
//  Audio
//
//  Created by 디해 on 7/13/25.
//

import Dependencies
import Foundation

public enum AudioServiceKey: TestDependencyKey {
    public static let testValue: AudioService = EmptyAudioService()
}

public extension DependencyValues {
    var audioService: AudioService {
        get { self[AudioServiceKey.self] }
        set { self[AudioServiceKey.self] = newValue }
    }
}
