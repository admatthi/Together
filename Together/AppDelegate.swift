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

var tryingtopurchase = Bool()
var isInfluencer = Bool()

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
        purchases = RCPurchases(apiKey: "XJcTuaSXGKIWBwsRjWsKIUumwbSzBArQ")
        
        purchases!.delegate = self
        
        isInfluencer = false

        ref = Database.database().reference()


//        var tabBar: UITabBarController =

        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarBuyer : UITabBarController = mainStoryboardIpad.instantiateViewController(withIdentifier: "Buyer") as! UITabBarController
       
        let tabBarInfluencer : UITabBarController = mainStoryboardIpad.instantiateViewController(withIdentifier: "Influencer") as! UITabBarController
//        
        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in


        let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "Overview") as UIViewController
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = initialViewControlleripad
        self.window?.makeKeyAndVisible()//
        
        
        } else {

            let currentUser = Auth.auth().currentUser
    
            uid = (currentUser?.uid)!
            queryforinfo()
          

        }
    
        return true
    }
    
    func letsgo() {
        
    
        
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "Login") as UIViewController
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = initialViewControlleripad
        self.window?.makeKeyAndVisible()
    }
    
    func queryforinfo() {
        
        var functioncounter = 0
        
        ref?.child("Influencers").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
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
    

    func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?
        ) -> Void) -> Bool {
        
        // 1
        
        
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
            let url = userActivity.webpageURL,
            let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                return false
        }
        
        // 2
//        if let computer = ItemHandler.sharedInstance.items
//            .filter({ $0.path == components.path}).first {
//            presentDetailViewController(computer)
//            return true
//        }
        
        // 3
        if let webpageUrl = URL(string: "http://joinmyfam.herokuapp.com") {
            application.open(webpageUrl)
            return false
        }
        
        return false
    }


    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        let urlPath : String = url.path as String!
        let urlHost : String = url.host as String!
        
        if urlPath == "/wow" {
            
            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "Buy") as UIViewController
            
            selectedid = "11"
            selectedimage = UIImage(named: "11pic")!
            selectedname = "Kayla"
            selectedpitch = "Sup"
            selectedprice = "10"
            //        selectedprogramnames = programnames[projectids[indexPath.row]]!
            selectedsubs = "100"
            selectedprogramname = "Sweat"
            
            
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = initialViewControlleripad
            self.window?.makeKeyAndVisible()
            
            return true
        } else {
            
            return true
        }
    }


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
