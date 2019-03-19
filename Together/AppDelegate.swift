//
//  AppDelegate.swift
//  Together
//
//  Created by Alek Matthiessen on 10/3/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import IQKeyboardManager
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit
import StoreKit
import UserNotifications
import FirebaseInstanceID
import FirebaseMessaging
import AVFoundation
import Purchases
import FirebaseDynamicLinks
import UserNotifications

var uid = String()
var ref: DatabaseReference?
var mychannelname = String()
var mychannelprice = String()
var myintrovideo = String()
var mypaypal = String()
var tryingtopurchase = Bool()
var isInfluencer = Bool()

var linkedin = Bool()

protocol SnippetsPurchasesDelegate: AnyObject {
    
    func purchaseCompleted(product: String)
    
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    
    weak var purchasesdelegate : SnippetsPurchasesDelegate?

    var purchases: RCPurchases?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        IQKeyboardManager.shared().isEnabled = true

        FBSDKAppEvents.activateApp()
        
        
        purchases = RCPurchases(apiKey: "FGJnVYVvOyPbLGjantsVNfffhvDwnyGz")
        
        purchases!.delegate = self
        
        isInfluencer = false

        ref = Database.database().reference()

      

        if Auth.auth().currentUser == nil {
            
            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            
            let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "Overview") as UIViewController
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = initialViewControlleripad
            self.window?.makeKeyAndVisible()//
            
      
            
        } else {
            
            let currentUser = Auth.auth().currentUser
            //
            uid = (currentUser?.uid)!
            
            
            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let tabBarBuyer : UITabBarController = mainStoryboardIpad.instantiateViewController(withIdentifier: "Buyer") as! UITabBarController
            
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = tabBarBuyer
            
            self.window?.makeKeyAndVisible()
            
        }
            // Do smth if user is not logged in



//        } else {
//
        
//
//            queryforinfo()
//
//            queryforids { () -> () in
//
//
//            }
//
//
//        }
////
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

    
    func queryforids(completed: @escaping (() -> ()) ) {
        
        var functioncounter = 0
        
        projectids.removeAll()
        descriptions.removeAll()
        names.removeAll()
        programnames.removeAll()
        prices.removeAll()
        toppics.removeAll()
        images.removeAll()
        brandnames.removeAll()
        imageurls.removeAll()
        k1.removeAll()
        v1.removeAll()
        k2.removeAll()
        v2.removeAll()
        k3.removeAll()
        v3.removeAll()
        k4.removeAll()
        v4.removeAll()
        k5.removeAll()
        v5.removeAll()
        k6.removeAll()
        v6.removeAll()
        k7.removeAll()
        v7.removeAll()

            ref?.child("Products").queryOrdered(byChild: "Tag1").queryEqual(toValue: "Buy Now").observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if let snapDict = snapshot.value as? [String:AnyObject] {
                    
                    for each in snapDict {
                        
                        let ids = each.key
                        
                        projectids.append(ids)
                        
                        functioncounter += 1
                        
                        if snapDict.count > 15 {
                            
                            if functioncounter == 15 {
                                
                                completed()
                                
                            }
                            
                        } else {
                            
                            if functioncounter == snapDict.count {
                                
                                completed()
                                
                            }
                            
                        }
                        
                        
                        
                        
                        
                    }
                    
                }
                
            })
        
    }
    
    func queryforinfo() {
        
        var functioncounter = 0
        
        for each in projectids {
            
            
            ref?.child("Products").child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if var author2 = value?["Used Price"] as? Int {
                    
                    
                    var intviews = Double(author2)
                    var author3 = "$\(String(Int(intviews)))"
                    usedprices[each] = author3
                    
                }
                
                if var author2 = value?["New Price"] as? Int {
                    
                    
                    var intviews = Double(author2)
                    var author3 = "$\(String(Int(intviews)))"
                    newprices[each] = author3
                    
                }
                
                if var author2 = value?["Description"] as? String {
                    
                    descriptions[each] = author2
                    
                }
                
                if var author2 = value?["Name"] as? String {
                    
                    names[each] = author2
                    
                }
                
                
                
                if var profileUrl = value?["Image"] as? String {
                    // Create a storage reference from the URL
                    imageurls[each] = profileUrl
                    
                    let url = URL(string: profileUrl)
                    
                    if url != nil {
                        
                        if let data = try? Data(contentsOf: url!)
                            
                        {
                            if data != nil {
                                
                                if let selectedimage2 = UIImage(data: data) {
                                    
                                    images[each] = selectedimage2
                                    functioncounter += 1
                                    
                                }
                                
                            } else {
                                
                                images[each] = UIImage(named: "Watch-3")!
                                functioncounter += 1
                                
                            }
                            
                            
                        } else {
                            
                            images[each] = UIImage(named: "Watch-3")
                            
                            functioncounter += 1
                            
                        }
                        
                    }
                    
                }
                
                if var author2 = value?["Key 1"] as? String {
                    
                    k1[each] = author2
                    
                }
                
                if var author2 = value?["Value 1"] as? String {
                    
                    v1[each] = "\(author2)"
                } else {
                    
                    if var author2 = value?["Value 1"] as? Int {
                        
                        v1[each] = "\(author2)"
                        
                    } else {
                        
                        if var author2 = value?["Value 1"] as? Double {
                            
                            v1[each] = "\(author2)"
                        }
                    }
                    
                }
                
                
                if var author2 = value?["Key 2"] as? String {
                    
                    k2[each] = author2
                    
                }
                
                if var author2 = value?["Value 2"] as? String {
                    
                    v2[each] = "\(author2)"
                    
                } else {
                    
                    if var author2 = value?["Value 2"] as? Int {
                        
                        v2[each] = "\(author2)"
                    } else {
                        
                        if var author2 = value?["Value 2"] as? Double {
                            
                            v2[each] = "\(author2)"
                        }
                    }
                    
                }
                
                if var author2 = value?["Key 3"] as? String {
                    
                    k3[each] = author2
                    
                }
                
                if var author2 = value?["Value 3"] as? String {
                    
                    v3[each] = "\(author2)"
                    
                } else {
                    
                    if var author2 = value?["Value 3"] as? Int {
                        
                        v3[each] = "\(author2)"
                        
                    } else {
                        
                        if var author2 = value?["Value 3"] as? Double {
                            
                            v3[each] = "\(author2)"
                        }
                    }
                    
                }
                
                if var author2 = value?["Key 8"] as? String {
                    
                    k4[each] = author2
                    
                }
                
                if var author2 = value?["Value 8"] as? String {
                    
                    v4[each] = "\(author2)"
                    
                } else {
                    
                    if var author2 = value?["Value 8"] as? Int {
                        
                        v4[each] = "\(author2)"
                        
                    } else {
                        
                        if var author2 = value?["Value 8"] as? Double {
                            
                            v4[each] = "\(author2)"
                        }
                    }
                    
                }
                
                if var author2 = value?["Key 5"] as? String {
                    
                    k5[each] = author2
                    
                }
                
                if var author2 = value?["Value 5"] as? String {
                    
                    v5[each] = "\(author2)"
                    
                } else {
                    
                    if var author2 = value?["Value 5"] as? Int {
                        
                        v5[each] = "\(author2)"
                        
                    } else {
                        
                        if var author2 = value?["Value 5"] as? Double {
                            
                            v5[each] = "\(author2)"
                        }
                    }
                    
                }
                
                if var author2 = value?["Key 6"] as? String {
                    
                    k6[each] = author2
                    
                }
                
                if var author2 = value?["Value 6"] as? String {
                    
                    v6[each] = "\(author2)"
                    
                } else {
                    
                    if var author2 = value?["Value 6"] as? Int {
                        
                        v6[each] = "\(author2)"
                        
                    } else {
                        
                        if var author2 = value?["Value 6"] as? Double {
                            
                            v6[each] = "\(author2)"
                        }
                    }
                    
                }
                
                if var author2 = value?["Key 7"] as? String {
                    
                    k7[each] = author2
                    
                }
                
                if var author2 = value?["Value 7"] as? String {
                    
                    v7[each] = "\(author2)"
                    
                } else {
                    
                    if var author2 = value?["Value 7"] as? Int {
                        
                        v7[each] = "\(author2)"
                        
                    } else {
                        
                        if var author2 = value?["Value 7"] as? Double {
                            
                            v7[each] = "\(author2)"
                        }
                    }
                    
                }
                
                //                toppics[each] = UIImage(named: "\(each)pic")
                
                
                print(functioncounter)
                
                
                //                if functioncounter == projectids.count {
                
                if functioncounter == projectids.count || functioncounter == 15 {
                    
           
                }
                
                
            })
            
        }
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

class SegueFromLeft: UIStoryboardSegue
{
    override func perform()
    {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: -src.view.frame.size.width, y: 0)
        
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {
                        dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
        },
                       completion: { finished in
                        src.present(dst, animated: false, completion: nil)
        }
        )
    }
    
    
}

class SegueFromRight: UIStoryboardSegue
{
    override func perform()
    {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
        
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {
                        dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
        },
                       completion: { finished in
                        src.present(dst, animated: false, completion: nil)
        }
        )
    }
}
