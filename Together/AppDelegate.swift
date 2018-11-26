//
//  AppDelegate.swift
//  Together
//
//  Created by Alek Matthiessen on 10/3/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit
import StoreKit
import UserNotifications
import FirebaseInstanceID
import FirebaseMessaging
import UXCam
import AVFoundation
import Purchases
import IQKeyboardManager

var uid = String()
var ref: DatabaseReference?
var mychannelname = String()
var mychannelprice = String()
var myintrovideo = String()
var mypaypal = String()
var tryingtopurchase = Bool()
var isInfluencer = Bool()
var myselectedimage = UIImage()

var linkedin = Bool()

protocol SnippetsPurchasesDelegate: AnyObject {
    
    func purchaseCompleted(product: String)
    
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    weak var purchasesdelegate : SnippetsPurchasesDelegate?

    var purchases: RCPurchases?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        IQKeyboardManager.shared().isEnabled = true

        FBSDKAppEvents.activateApp()
        
        UXCam.start(withKey: "8921dd89a4b98a3")
        purchases = RCPurchases(apiKey: "FGJnVYVvOyPbLGjantsVNfffhvDwnyGz")
        
        purchases!.delegate = self
        
        isInfluencer = false

        ref = Database.database().reference()



//

        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in

        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)


        let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "Overview") as UIViewController
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = initialViewControlleripad
        self.window?.makeKeyAndVisible()//


        } else {

            let currentUser = Auth.auth().currentUser

            uid = (currentUser?.uid)!

            queryforinfo()

            queryforids { () -> () in


            }


        }
//
        return true
    }
    
    func letsgo() {
        
        if Auth.auth().currentUser == nil {
            
            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "BuyerLogin") as UIViewController
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = initialViewControlleripad
            self.window?.makeKeyAndVisible()
            
        } else {
            
            ref?.child("Users").child(uid).child("Requested").child(selectedid).updateChildValues(["Title" : "x"])
            
            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "MyFam") as UIViewController
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = initialViewControlleripad
            self.window?.makeKeyAndVisible()
        }

    }
    
    func queryforinfo() {
        
        var functioncounter = 0
        
        ref?.child("Influencers").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if var profileUrl = value?["ProPic"] as? String {
                // Create a storage reference from the URL
                
                let url = URL(string: profileUrl)
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                myselectedimage = UIImage(data: data!)!
                
                
                thumbnailurls["0"] = profileUrl
                thumbnails["0"] = UIImage(data: data!)
                
            }
            
            if var profileUrl2 = value?["Purchase"] as? String {
                // Create a storage reference from the URL
                
                
                if profileUrl2 == "-" {
                    
                    noothervids = true
                    
                } else {
                    
                    videolinks["0"] = profileUrl2
                        
                    myintrovideo = profileUrl2
                    
                    noothervids = false
                }
            }
            
            
            
            if var author2 = value?["Subscribers"] as? String {
                
                selectedsubs = author2
            }
            

            if var author2 = value?["Price"] as? String {
                
                mychannelprice = author2
            }
            
            if var author2 = value?["PayPal"] as? String {
                
                mypaypal = author2
            }
            
            if var author2 = value?["Channel Name"] as? String {
                
                mychannelname = author2
            }
            
            if var author2 = value?["Approved"] as? String {
                
                if author2 == "False" {
                    
                    let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let tabBarBuyer : UITabBarController = mainStoryboardIpad.instantiateViewController(withIdentifier: "Buyer") as! UITabBarController
                    
                    self.window = UIWindow(frame: UIScreen.main.bounds)
                    self.window?.rootViewController = tabBarBuyer
                    
                    self.window?.makeKeyAndVisible()
                    
                } else {
                    
                    isInfluencer = true
                    
                    let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
           
                    
                    let tabBarInfluencer : UITabBarController = mainStoryboardIpad.instantiateViewController(withIdentifier: "Influencer") as! UITabBarController
                    self.window = UIWindow(frame: UIScreen.main.bounds)
                    self.window?.rootViewController = tabBarInfluencer
                    self.window?.makeKeyAndVisible()
                }
                
                
            } else {
                
                let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let tabBarBuyer : UITabBarController = mainStoryboardIpad.instantiateViewController(withIdentifier: "Buyer") as! UITabBarController
                
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.window?.rootViewController = tabBarBuyer
                
                self.window?.makeKeyAndVisible()
            }
      
            
        })
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func queryforids(completed: @escaping (() -> ()) ) {
        
        var functioncounter = 0
    
        ref?.child("Users").child(uid).child("Purchased").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    let ids = each.key
                    
                    myprojectids.append(ids)
         
                    functioncounter += 1
                    
                    if functioncounter == snapDict.count {
                        
                        completed()
                        
                    }
                    
                    
                }
                
            }
            
        })
    }
    

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        if let incomingURL = userActivity.webpageURL {
            
            let linkhandled =  DynamicLinks.dynamicLinks().handleUniversalLink(userActivity.webpageURL!) { (dynamiclink, error) in
                
                if let dynamiclink = dynamiclink, let _ = dynamiclink.url {
                    
                    self.handleIncomingDynamicLink(dynamicLink: dynamiclink)
                }
                

            }
            return linkhandled

        }
        
        return false
    }
    
    func handleIncomingDynamicLink(dynamicLink: DynamicLink) {
        
        print("Shit \(dynamicLink.url)")
        
        let fileName = dynamicLink.url?.absoluteString
        let fileArray = fileName?.components(separatedBy: "/")
        let finalFileName = fileArray?.last
        

        
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "Profiles") as UIViewController
        
        print(finalFileName)
        print(selectedid)
        linkedin = true
        selectedid = finalFileName!.replacingOccurrences(of: "/", with: "", options: NSString.CompareOptions.literal, range: nil)
        
        print(finalFileName)
        print(selectedid)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = initialViewControlleripad
        self.window?.makeKeyAndVisible()
        
    }
    

        
//        if let dynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url) {
//            // Handle the deep link. For example, show the deep-linked content or
//            // apply a promotional offer to the user's account.
//            // ...
//
//            print ("\(url)")
//            print ("\(url.host!)")
//            print ("\(url.path)")
//
//
//            let urlPath : String = url.path as String!
//
//            let urlHost : String = url.host as String!
//
//            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "Profiles") as UIViewController
//
//                print(urlPath)
//                print(selectedid)
//
//                selectedid = urlPath.replacingOccurrences(of: "/", with: "", options: NSString.CompareOptions.literal, range: nil)
//
//                print(urlPath)
//                print(selectedid)
//
//                self.window = UIWindow(frame: UIScreen.main.bounds)
//                self.window?.rootViewController = initialViewControlleripad
//                self.window?.makeKeyAndVisible()
//
//                return true
//
//            }
//
//                return true
//        }
//

    }
    
 



extension AppDelegate: RCPurchasesDelegate {
    func purchases(_ purchases: RCPurchases, completedTransaction transaction: SKPaymentTransaction, withUpdatedInfo purchaserInfo: RCPurchaserInfo) {
        
        self.purchasesdelegate?.purchaseCompleted(product: transaction.payment.productIdentifier)
        
        print("purchased")
        tryingtopurchase  = true
        
        letsgo()
        
    }
    
    func purchases(_ purchases: RCPurchases, receivedUpdatedPurchaserInfo purchaserInfo: RCPurchaserInfo) {
        //        handlePurchaserInfo(purchaserInfo)
        
        print("shit")
        
    }
    
    func purchases(_ purchases: RCPurchases, failedToUpdatePurchaserInfoWithError error: Error) {
        print(error)
        
        tryingtopurchase = false
    }
    
    func purchases(_ purchases: RCPurchases, failedTransaction transaction: SKPaymentTransaction, withReason failureReason: Error) {
        print(failureReason)
        
        tryingtopurchase = false
    }
    
    func purchases(_ purchases: RCPurchases, restoredTransactionsWith purchaserInfo: RCPurchaserInfo) {
        //        handlePurchaserInfo(purchaserInfo)
        
        print("restored")
        tryingtopurchase  = true
        letsgo()
        
        
    }
    
    func purchases(_ purchases: RCPurchases, failedToRestoreTransactionsWithError error: Error) {
        print(error)
    }
}
