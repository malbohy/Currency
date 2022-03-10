//
//  AVPlayerExtenstions.swift
//  Nagwa Readers
//
//  Created by mohamed albohy on 23/08/2021.
//

import Foundation
import AVFoundation

public extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
