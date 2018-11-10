//
//  VideoPlayerView.swift
//  Together
//
//  Created by Alek Matthiessen on 11/9/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import Foundation
//
//class VideoPlayerView: UIView {
//    
//    let activityIndicatorView: UIActivityIndicatorView = {
//        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
//        aiv.translatesAutoresizingMaskIntoConstraints = false
//        aiv.startAnimating()
//        return aiv
//    }()
//    
//    lazy var pausePlayButton: UIButton = {
//        let button = UIButton(type: .System)
//        let image = UIImage(named: "pause")
//        button.setImage(image, forState: .Normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.tintColor = .whiteColor()
//        button.hidden = true
//        
//        button.addTarget(self, action: #selector(handlePause), forControlEvents: .TouchUpInside)
//        
//        return button
//    }()
//    
//    var isPlaying = false
//    
//    func handlePause() {
//        if isPlaying {
//            player?.pause()
//            pausePlayButton.setImage(UIImage(named: "play"), forState: .Normal)
//        } else {
//            player?.play()
//            pausePlayButton.setImage(UIImage(named: "pause"), forState: .Normal)
//        }
//        
//        isPlaying = !isPlaying
//    }
//    
//    let controlsContainerView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor(white: 0, alpha: 1)
//        return view
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        setupPlayerView()
//        
//        controlsContainerView.frame = frame
//        addSubview(controlsContainerView)
//        
//        controlsContainerView.addSubview(activityIndicatorView)
//        activityIndicatorView.centerXAnchor.constraintEqualToAnchor(centerXAnchor).active = true
//        activityIndicatorView.centerYAnchor.constraintEqualToAnchor(centerYAnchor).active = true
//        
//        controlsContainerView.addSubview(pausePlayButton)
//        pausePlayButton.centerXAnchor.constraintEqualToAnchor(centerXAnchor).active = true
//        pausePlayButton.centerYAnchor.constraintEqualToAnchor(centerYAnchor).active = true
//        pausePlayButton.widthAnchor.constraintEqualToConstant(50).active = true
//        pausePlayButton.heightAnchor.constraintEqualToConstant(50).active = true
//        
//        backgroundColor = .blackColor()
//    }
//    
//    var player: AVPlayer?
//    
//    private func setupPlayerView() {
//        //warning: use your own video url here, the bandwidth for google firebase storage will run out as more and more people use this file
//        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
//        if let url = NSURL(string: urlString) {
//            player = AVPlayer(URL: url)
//            
//            let playerLayer = AVPlayerLayer(player: player)
//            self.layer.addSublayer(playerLayer)
//            playerLayer.frame = self.frame
//            
//            player?.play()
//            
//            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .New, context: nil)
//        }
//    }
//    
//    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
//        
//        //this is when the player is ready and rendering frames
//        if keyPath == "currentItem.loadedTimeRanges" {
//            activityIndicatorView.stopAnimating()
//            controlsContainerView.backgroundColor = .clearColor()
//            pausePlayButton.hidden = false
//            isPlaying = true
//        }
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
