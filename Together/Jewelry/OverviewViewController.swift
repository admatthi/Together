//
//  OverviewViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 11/13/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit

class OverviewViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate    {
    @IBOutlet weak var tapexplore: UIButton!
    
    @IBOutlet weak var taps: UIButton!
    @IBOutlet weak var tapr: UIButton!
    @IBOutlet weak var TAPJOIN: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!


    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        

        tapr.addTextSpacing(2.0)
        taps.addTextSpacing(2.0)
        TAPJOIN.addTextSpacing(2.0)
        tapexplore.addTextSpacing(2.0)
        tapexplore.underline()

//        TAPJOIN.frame = CGRect(x: 0, y: TAPJOIN.frame.minY, width: self.view.frame.width/2, height: 76)
//        self.view.addSubview(TAPJOIN)

        images.append(UIImage(named: "CC1 Copy 2")!)
        images.append(UIImage(named: "CC2 Copy 2")!)


        images.append(UIImage(named: "CC3 Copy 2")!)
        images.append(UIImage(named: "CC4 Copy 2")!)

        mainimage.image = images[counter]
        
        setupimage.image = UIImage(named: "Setup\(counter)")
        let swipeRightRec = UISwipeGestureRecognizer()
        let swipeLeftRec = UISwipeGestureRecognizer()
        let swipeUpRec = UISwipeGestureRecognizer()
        let swipeDownRec = UISwipeGestureRecognizer()
        
        swipeRightRec.addTarget(self, action: #selector(self.swipeR) )
        swipeRightRec.direction = .right
        self.view!.addGestureRecognizer(swipeRightRec)
        
        
        swipeLeftRec.addTarget(self, action: #selector(self.swipeL) )
        swipeLeftRec.direction = .left
        self.view!.addGestureRecognizer(swipeLeftRec)

    }
    
    @objc func swipeR() {
        
        self.tapPrevious(nil)
        
    }
    
    @objc func swipeL() {
        
        
        self.tapNext(nil)
        
        
    }
    var counter = 0
    @IBOutlet weak var mainimage: UIImageView!
    @IBOutlet weak var setupimage: UIImageView!
    @IBAction func tapNext(_ sender: AnyObject?) {
        
    
        if counter < images.count-1 {
            
            counter += 1

             setupimage.image = UIImage(named: "Setup\(counter)")
            print(counter)
            mainimage.image = images[counter]
            
            mainimage.slideInFromRight()
            
        }
        
        if counter == 0 {
            
//            tapexplore.slideInFromLeft()

//            tapexplore.alpha = 1
            
        } else {
            
//            tapexplore.alpha = 1
        }
        
    }
    
    @IBAction func tapPrevious(_ sender: AnyObject?) {
        
        
        if counter > 0  {
        
            counter -= 1

            setupimage.image = UIImage(named: "Setup\(counter)")
            print(counter)
        mainimage.image = images[counter]
        mainimage.slideInFromLeft()
            
        }
        
        if counter == 0 {
            
//            tapexplore.slideInFromLeft()

//            tapexplore.alpha = 1

        } else {
            
//            tapexplore.alpha = 1
        }
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                self.tapNext(nil)
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
            case UISwipeGestureRecognizerDirection.left:
                self.tapPrevious(nil)
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       return images.count
    }
    
    var images = [UIImage]()
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Overview", for: indexPath) as! OverviewCollectionViewCell
        
        cell.mainimage.image = images[indexPath.row]
        
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UIView {
    // Name this function in a way that makes sense to you...
    // slideFromLeft, slideRight, slideLeftToRight, etc. are great alternative names
    func slideInFromLeft(duration: TimeInterval = 0.5, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromLeftTransition.delegate = delegate as! CAAnimationDelegate
        }
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = kCATransitionPush
        slideInFromLeftTransition.subtype = kCATransitionFromLeft
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        slideInFromLeftTransition.fillMode = kCAFillModeRemoved
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
    
    func slideInFromRight(duration: TimeInterval = 0.5, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromRightTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromRightTransition.delegate = delegate as! CAAnimationDelegate
        }
        
        // Customize the animation's properties
        slideInFromRightTransition.type = kCATransitionPush
        slideInFromRightTransition.subtype = kCATransitionFromRight
        slideInFromRightTransition.duration = duration
        slideInFromRightTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        slideInFromRightTransition.fillMode = kCAFillModeRemoved
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromRightTransition, forKey: "slideInFromRightTransition")
    }
}
extension UIButton{
    
    func addTextSpacing(_ letterSpacing: CGFloat){
        let attributedString = NSMutableAttributedString(string: (self.titleLabel?.text!)!)
        attributedString.addAttribute(NSAttributedStringKey.kern, value: letterSpacing, range: NSRange(location: 0, length: (self.titleLabel?.text!.count)!))
        self.setAttributedTitle(attributedString, for: .normal)
    }
    
}

extension UIButton {
    func underline() {
        guard let text = self.titleLabel?.text else { return }
        
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: NSRange(location: 0, length: text.count))
        
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
