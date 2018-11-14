//
//  InfluencerCreateViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 11/12/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit

class InfluencerCreateViewController: UIViewController, UITextFieldDelegate {

    var email = String()
    var password = String()
    var inputname = String()
    var domainz = String()
    var inputdescription = String()
    var inputprice = String()
    var inputprogramname = String()
    var phonenumber = String()
    
    
    @IBOutlet weak var tapsign: UIButton!
    
    @IBAction func tapSignUp(_ sender: Any) {
        
    
        email = "\(emailtf.text!)"
        password = "\(passwordtf.text!)"
        inputname = "\(nametf.text!)"
        domainz = "\(domaintf.text!)"
        inputdescription = "\(pdtf.text!)"
        inputprice = "\(pricetf.text!)"
        inputprogramname = "\(pn2tf.text!)"
        phonenumber = "\(pntf.text!)"
        errorlabel.alpha = 0
//        if email != "" && password != "" && name != "" && domainz != "" {
        
            if Auth.auth().currentUser == nil {
                // Do smth if user is not logged in

                signup()

                
            } else {
                
//
                ref?.child("Influencers").child(uid).updateChildValues(["Description" : inputdescription, "Price" : inputprice, "Phone Number" : phonenumber, "ProgramName" : inputprogramname, "Subscribers" : "0", "Approved" : "False", "Name" : inputname, "ProPic" : "https://firebasestorage.googleapis.com/v0/b/deploy-141ca.appspot.com/o/1B.jpg?alt=media&token=4b42b974-45dd-4dea-b17b-046a9806b466", "Email" : email, "Password" : password, "Domain" : domainz, "Purchase" : "https://firebasestorage.googleapis.com/v0/b/deploy-141ca.appspot.com/o/y2mate.com%20-%20mvmt_social_ad_vertical_video_bjH6DShpolY_1080p.mp4?alt=media&token=6fd2dd4e-5890-4ba4-98b1-393c962dc053"])

                thankyou.alpha = 1
                passwordtf.alpha = 0
                domaintf.alpha = 0
                emailtf.alpha = 0
                nametf.alpha = 0
                tapsign.alpha = 0
                pdtf.alpha = 0
                pn2tf.alpha = 0
                pdtf.alpha = 0
                pntf.alpha = 0
                pricetf.alpha = 0
            }


        
//        }
        
    }
    
    @IBAction func tapBack(_ sender: Any) {
        
        //        self.dismiss(animated: true, completion: {
        //
        //        })
    }
    
    @IBOutlet weak var domaintf: UITextField!
    
    @IBOutlet weak var pricetf: UITextField!
    @IBOutlet weak var pdtf: UITextField!
    @IBOutlet weak var pntf: UITextField!
    @IBOutlet weak var pn2tf: UITextField!

    @IBOutlet weak var nametf: UITextField!
    @IBOutlet weak var passwordtf: UITextField!
    @IBOutlet weak var emailtf: UITextField!

    
    @IBOutlet weak var thankyou: UILabel!
//    func signup() {
//
//        var email = "\(emailtf.text!)"
//        var password = "\(passwordtf.text!)"
//        var name = "\(nametf.text!)"
//        var domain = "\(domaintf.text!)"
//
//        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
//
//            if let error = error {
//
//                self.errorlabel.alpha = 1
//                self.errorlabel.text = error.localizedDescription
//
//                return
//
//            } else {
//                
//                uid = (Auth.auth().currentUser?.uid)!
//                
//                //                ref!.child("Users").child(uid).child("Purchased").child(selectedid).updateChildValues(["Title": "x"])
//
//                let date = Date()
//                let calendar = Calendar.current
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "MM-dd-yy"
//                var todaysdate =  dateFormatter.string(from: date)
//                let thirtyDaysAfterToday = Calendar.current.date(byAdding: .day, value: +30, to: date)!
//                let thirty = dateFormatter.string(from: thirtyDaysAfterToday)
//
//                //                self.addstaticbooks()
//                ref?.child("Users").child(uid).updateChildValues(["Email" : email, "Influencer" : "True", "Password": password, "Name" : name, "Domain" : domain, "Approved" : "False"])
//                
//                
//
//                
//                DispatchQueue.main.async {
//
//                    //                    purchased = true
//
//                    self.performSegue(withIdentifier: "InfluencerToThankYou", sender: self)
//                }
//            }
//
//        }
//
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func signup() {
        
        
        var email = "\(emailtf.text!)"
        var password = "\(passwordtf.text!)"
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if let error = error {
                
                self.errorlabel.alpha = 1
                self.errorlabel.text = error.localizedDescription
                
//                self.thankyou.alpha = 1
//                self.passwordtf.alpha = 1
//                self.domaintf.alpha = 1
//                self.emailtf.alpha = 1
//                self.nametf.alpha = 1
//                self.tapsign.alpha = 1
//                self.pdtf.alpha = 1
//                self.pn2tf.alpha = 1
//                self.pdtf.alpha = 1
//                self.pntf.alpha = 1
//                self.pricetf.alpha = 1
                
                return
                
            } else {
                
                uid = (Auth.auth().currentUser?.uid)!
                
                //                ref!.child("Users").child(uid).child("Purchased").child(selectedid).updateChildValues(["Title": "x"])
                
                let date = Date()
                let calendar = Calendar.current
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM-dd-yy"
                var todaysdate =  dateFormatter.string(from: date)
                let thirtyDaysAfterToday = Calendar.current.date(byAdding: .day, value: +30, to: date)!
                let thirty = dateFormatter.string(from: thirtyDaysAfterToday)
                
                //                self.addstaticbooks()
                ref?.child("Influencers").child(uid).updateChildValues(["Description" : self.inputdescription, "Price" : self.inputprice, "Phone Number" : self.phonenumber, "ProgramName" : self.inputprogramname, "Subscribers" : "0", "Approved" : "False", "Name" : self.inputname, "ProPic" : "https://firebasestorage.googleapis.com/v0/b/deploy-141ca.appspot.com/o/1B.jpg?alt=media&token=4b42b974-45dd-4dea-b17b-046a9806b466", "Email" : self.email, "Password" : self.password, "Domain" : self.domainz, "Purchase" : "https://firebasestorage.googleapis.com/v0/b/deploy-141ca.appspot.com/o/y2mate.com%20-%20mvmt_social_ad_vertical_video_bjH6DShpolY_1080p.mp4?alt=media&token=6fd2dd4e-5890-4ba4-98b1-393c962dc053"])
                
                self.thankyou.alpha = 1
                self.passwordtf.alpha = 0
                self.domaintf.alpha = 0
                self.emailtf.alpha = 0
                self.nametf.alpha = 0
                self.tapsign.alpha = 0
                self.pdtf.alpha = 0
                self.pn2tf.alpha = 0
                self.pdtf.alpha = 0
               self.pntf.alpha = 0
                self.pricetf.alpha = 0
            
            }
            
        }
        
    }
    
    @IBOutlet weak var tapcreate: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        thankyou.alpha = 0
        ref = Database.database().reference()
        
        emailtf.delegate = self
        passwordtf.delegate = self
        nametf.delegate = self
        domaintf.delegate = self
        emailtf.becomeFirstResponder()
        
        tapcreate.layer.cornerRadius = 22.0
        tapcreate.layer.masksToBounds = true
        
        errorlabel.alpha = 0
        FBSDKAppEvents.logEvent("LoginScreen")
        
        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in

            
            
        } else {
            
            emailtf.alpha = 0
            passwordtf.alpha = 0
            
            
            
        }
        
        self.addLineToView(view: passwordtf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        
                self.addLineToView(view: pntf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        
                self.addLineToView(view: pdtf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        
                self.addLineToView(view: pn2tf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        
                self.addLineToView(view: pdtf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        
                self.addLineToView(view: nametf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        
                self.addLineToView(view: emailtf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        
                self.addLineToView(view: domaintf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        
                        self.addLineToView(view: pricetf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)

        
    }
    
    @IBOutlet weak var errorlabel: UILabel!
    func addstaticbooks() {
        
        ref?.child("Users").child(uid).child("Library").child("InProgress").child("12 Rules for Life").updateChildValues(["Author" : "Jordan B. Peterson", "BookID" : "26", "Description" : "What does everyone in the modern world need to know? Renowned psychologist Jordan B. Peterson's answer to this most difficult of questions uniquely combines the hard-won truths of ancient tradition with the stunning revelations of cutting-edge scientific research.", "Genre" : "Psychology", "Image" : "PS26", "Name" : "12 Rules for Life", "Completed" : "No", "Views" : "123K views"])
        
        
        
        ref?.child("Users").child(uid).child("Library").child("InProgress").child("Sapiens").updateChildValues(["Author" : "Yuval Noah Harari", "BookID" : "25", "Description" : "From a renowned historian comes a groundbreaking narrative of humanity’s creation and evolution—a #1 international bestseller—that explores the ways in which biology and history have defined us and enhanced our understanding of what it means to be “human.”", "Genre" : "Psychology", "Image" : "PS25", "Name" : "Sapiens", "Completed" : "No", "Views" : "3M views"])
        
        ref?.child("Users").child(uid).child("Library").child("InProgress").child("The Power of Habit").updateChildValues(["Author" : "Charles Duhigg", "BookID" : "24", "Description" : "In The Power of Habit, award-winning business reporter Charles Duhigg takes us to the thrilling edge of scientific discoveries that explain why habits exist and how they can be changed.", "Genre" : "Psychology", "Image" : "PS24", "Name" : "The Power of Habit", "Completed" : "No", "Views" : "23K views"])
        
        
        ref?.child("Users").child(uid).child("Library").child("InProgress").child("Skin in the Game").updateChildValues(["Author" : "Nassim Nicholas Taleb", "BookID" : "23", "Description" : "A bold new work from the author of The Black Swan that challenges many of our long-held beliefs about risk and reward, politics and religion, finance and personal responsibility.", "Genre" : "Psychology", "Image" : "PS23", "Name" : "Skin in the Game", "Completed" : "No", "Views" : "23K views"])
        
        
        ref?.child("Users").child(uid).child("Library").child("InProgress").child("Thinking in Bets").updateChildValues(["Author" : "Annie Duke", "BookID" : "22", "Description" : "Poker champion turned business consultant Annie Duke teaches you how to get comfortable with uncertainty and make better decisions as a result.", "Genre" : "Psychology", "Image" : "PS22", "Name" : "Thinking in Bets", "Completed" : "No", "Views" : "4.1M views"])
        
        
        ref?.child("Users").child(uid).child("Library").child("InProgress").child("Mastery").updateChildValues(["Author" : "Robert Greene", "BookID" : "21", "Description" : "The bestseller author of The 48 Laws of Power, The Art of Seduction, and The 33 Strategies of War, Robert Greene has spent a liftime studying the laws of power. Now, he shares the secret path to greatness. With this seminal text as a guide, readers will learn how to unlock the passion within and become masters.", "Genre" : "Psychology", "Image" : "PS21", "Name" : "Mastery", "Completed" : "No", "Views" : "23K views"])
        
        
        ref?.child("Users").child(uid).child("Library").child("InProgress").child("The Brain's Way of Healing").updateChildValues(["Author" : "Norman Doidge", "BookID" : "20", "Description" : "In his groundbreaking work The Brain That Changes Itself, Norman Doidge introduced readers to neuroplasticity—the brain’s ability to change its own structure and function in response to activity and mental experience. Now his revolutionary new book shows how the amazing process of neuroplastic healing really works.", "Genre" : "Psychology", "Image" : "PS20", "Name" : "The Brain's Way of Healing", "Completed" : "No", "Views" : "123K views"])
        
        
        ref?.child("Users").child(uid).child("Library").child("InProgress").child("Fooled by Randomness").updateChildValues(["Author" : "Nassim Nicholas Taleb", "BookID" : "19", "Description" : "Fooled by Randomness is a standalone book in Nassim Nicholas Taleb’s landmark Incerto series, an investigation of opacity, luck, uncertainty, probability, human error, risk, and decision-making in a world we don’t understand. The other books in the series are The Black Swan, Antifragile, Skin in the Game, and The Bed of Procrustes.", "Genre" : "Psychology", "Image" : "PS19", "Name" : "Fooled by Randomness", "Completed" : "No", "Views" : "984K views"])
        
        
        ref?.child("Users").child(uid).child("Library").child("InProgress").child("The Power of Myth").updateChildValues(["Author" : "Joseph Campbell", "BookID" : "18", "Description" : "The Power of Myth launched an extraordinary resurgence of interest in Joseph Campbell and his work. A preeminent scholar, writer, and teacher, he has had a profound influence on millions of people--including Star Wars creator George Lucas.", "Genre" : "Psychology", "Image" : "PS18", "Name" : "The Power of Myth", "Completed" : "No", "Views" : "1.4M views"])
        
        
        ref?.child("Users").child(uid).child("Library").child("InProgress").child("The Road Less Traveled").updateChildValues(["Author" : "M. Scott Peck", "BookID" : "17", "Description" : "Perhaps no book in this generation has had a more profound impact on our intellectual and spiritual lives than The Road Less Traveled. ", "Genre" : "Psychology", "Image" : "PS17", "Name" : "The Road Less Traveled", "Completed" : "No", "Views" : "832K views"])
        
        ref?.child("Users").child(uid).child("Library").child("InProgress").child("The Purpose Driven Life").updateChildValues(["Author" : "Rick Warren", "BookID" : "16", "Description" : "Licensed in over eighty-five languages, The Purpose Driven Life is far more than just a book; it is a guide to a spiritual journey. ", "Genre" : "Psychology", "Image" : "PS16", "Name" : "The Purpose Driven Life", "Completed" : "No", "Views" : "4.1M views"])
        
        
        ref?.child("Users").child(uid).child("Library").child("InProgress").child("Keep It Shut").updateChildValues(["Author" : "Karen Ehman ", "BookID" : "15", "Description" : "Keep It Shut by Karen Ehman explores how to better control your tongue, knowing what to say and how to say it, and realizing when it is best to say nothing at all.", "Genre" : "Psychology", "Image" : "PS15", "Name" : "Keep It Shut", "Completed" : "No", "Views" : "3.8M views"])
        
        ref?.child("Users").child(uid).child("Library").child("InProgress").child("Antifragile: Things That Gain from Disorder").updateChildValues(["Author" : "Nassim Nicholas Taleb", "BookID" : "14", "Description" : "Just as human bones get stronger when subjected to stress and tension, and rumors or riots intensify when someone tries to repress them, many things in life benefit from stress, disorder, volatility, and turmoil.", "Genre" : "Psychology", "Image" : "PS14", "Name" : "Antifragile: Things That Gain from Disorder", "Completed" : "No", "Views" : "984K views"])
        
        
        ref?.child("Users").child(uid).child("Library").child("InProgress").child("Stumbling on Happiness").updateChildValues(["Author" : "Dan Gilbert", "BookID" : "13", "Description" : "Bringing to life scientific research in psychology, cognitive neuroscience, philosophy, and behavioral economics, this bestselling book reveals what scientists have discovered about the uniquely human ability to imagine the future. ", "Genre" : "Psychology", "Image" : "PS13", "Name" : "Stumbling on Happiness", "Completed" : "No", "Views" : "1.4M views"])
        
        
        ref?.child("Users").child(uid).child("Library").child("InProgress").child("Emotional Intelligence").updateChildValues(["Author" : "Daniel Goleman", "BookID" : "12", "Description" : "Emotional Intelligence is a skill and can be learned through constant practice and training, just like riding a bike or swimming!  This book is stuffed with lots of effective exercises, helpful info and practical ideas.", "Genre" : "Psychology", "Image" : "PS12", "Name" : "Emotional Intelligence", "Completed" : "No", "Views" : "1.2M views"])
        
        
        
        ref?.child("Users").child(uid).child("Library").child("InProgress").child("Authentic Happiness").updateChildValues(["Author" : "Martin Seligman", "BookID" : "11", "Description" : "According to esteemed psychologist and bestselling author Martin Seligman, happiness is not the result of good genes or luck. Real, lasting happiness comes from focusing on one’s personal strengths rather than weaknesses.", "Genre" : "Psychology", "Image" : "PS11", "Name" : "Authentic Happiness", "Completed" : "No", "Views" : "984K views"])
        
        ref?.child("Users").child(uid).child("Library").child("InProgress").child("Mindfullness").updateChildValues(["Author" : "Mark Williams and Danny Penman", "BookID" : "10", "Description" : "Mindfulness reveals a set of simple yet powerful practices that you can incorporate into daily life to help break the cycle of anxiety, stress, unhappiness, and exhaustion. ", "Genre" : "Psychology", "Image" : "PS10", "Name" : "Mindfullness", "Completed" : "No", "Views" : "984K views"])
        
        ref?.child("Users").child(uid).child("Library").child("InProgress").child("David and Goliath").updateChildValues(["Author" : "Malcolm Gladwell", "BookID" : "9", "Description" : "Three thousand years ago on a battlefield in ancient Palestine, a shepherd boy felled a mighty warrior with nothing more than a pebble and a sling-and ever since, the names of David and Goliath have stood for battles between underdogs and giants.", "Genre" : "Psychology", "Image" : "PS9", "Name" : "David and Goliath", "Completed" : "No", "Views" : "3.8M views"])
        
        ref?.child("Users").child(uid).child("Library").child("InProgress").child("Flow: The Psychology Of Happiness").updateChildValues(["Author" : "Mihaly Csikszentmihalyi", "BookID" : "8", "Description" : "Psychologist Mihaly Csikszentmihalyi's famous investigations of optimal experience have revealed that what makes an experience genuinely satisfying is a state of consciousness called flow. ", "Genre" : "Psychology", "Image" : "PS8", "Name" : "Flow: The Psychology Of Happiness", "Completed" : "No", "Views" : "2M views"])
        
        
        ref?.child("Users").child(uid).child("Library").child("InProgress").child("Outliers: The Story Of Success").updateChildValues(["Author" : "Malcolm Gladwell", "BookID" : "7", "Description" : "In this stunning new book, Malcolm Gladwell takes us on an intellectual journey through the world of outliers--the best and the brightest, the most famous and the most successful. He asks the question: what makes high-achievers different?", "Genre" : "Psychology", "Image" : "PS7", "Name" : "Outliers: The Story Of Success", "Completed" : "No", "Views" : "832K views"])
        
        ref?.child("Users").child(uid).child("Library").child("InProgress").child("Title").updateChildValues(["Author" : "Karen Ehman ", "BookID" : "15", "Description" : "Keep It Shut by Karen Ehman explores how to better control your tongue, knowing what to say and how to say it, and realizing when it is best to say nothing at all.", "Genre" : "Psychology", "Image" : "PS15", "Name" : "Keep It Shut", "Completed" : "No"])
        
        
        //
        
        
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    enum LINE_POSITION {
        case LINE_POSITION_TOP
        case LINE_POSITION_BOTTOM
    }
    
    func addLineToView(view : UIView, position : LINE_POSITION, color: UIColor, width: Double) {
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
        view.addSubview(lineView)
        
        let metrics = ["width" : NSNumber(value: width)]
        let views = ["lineView" : lineView]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutFormatOptions(rawValue: 0), metrics:metrics, views:views))
        
        switch position {
        case .LINE_POSITION_TOP:
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutFormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        case .LINE_POSITION_BOTTOM:
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutFormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        default:
            break
        }
    }
}


