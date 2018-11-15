//
//  PlayerViewClass.swift
//  Together
//
//  Created by Alek Matthiessen on 11/6/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import Foundation
import AVKit
import AVFoundation

class PlayerViewClass: UIView {
    
    
    
    override static var layerClass: AnyClass {
        
        return AVPlayerLayer.self;
    }
    
    var playerLayer: AVPlayerLayer  {
        
          return layer as! AVPlayerLayer
    }
    var player: AVPlayer? {
        
        get {
      
            return playerLayer.player;
            
        }
        
        set {
            
            playerLayer.player = newValue;
        }
    }
    
    
    
    
    
    
}
