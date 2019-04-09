//
//  Overview1ViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 4/9/19.
//  Copyright © 2019 AA Tech. All rights reserved.
//

import UIKit
import FBSDKCoreKit

var ages = [String]()
var focusarea = String()
var activitylevel = String()
var time = String()
var heightft = String()
var heightin = String()
var weight = String()
var goalweight = String()


class Overview1ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var agelabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBAction func tapGetStarted(_ sender: Any) {
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addagestopickerView()
        
        button1.alpha = 0
        FBSDKAppEvents.logEvent("Age")
    }
    
    func addagestopickerView() {
        
        ages.append("18")
        ages.append("19")
        ages.append("20")
        ages.append("21")
        ages.append("22")
        ages.append("23")
        ages.append("24")
        ages.append("25")
        ages.append("26")
        ages.append("27")
        ages.append("28")
        ages.append("29")
        ages.append("30")
        ages.append("31")
        ages.append("32")
        ages.append("33")
        ages.append("34")
        ages.append("35")
        ages.append("36")
        ages.append("37")
        ages.append("38")
        ages.append("39")
        ages.append("40")
        ages.append("41")
        ages.append("42")
        ages.append("43")
        ages.append("44")
        ages.append("45")
        ages.append("46")
        ages.append("47")
        ages.append("48")
        ages.append("49")
        ages.append("50")
        ages.append("51")
        
        pickerView.reloadAllComponents()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if ages.count > 0 {
            
            return ages[row]
            
        } else {
            
            return "0"
            
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if ages.count > 0 {
            
            return ages.count
            
        } else {
            
            return 1
        }
    }
    
    var myage = Int()
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        agelabel.text = ages[row]
        myage = Int(ages[row])!
        button1.alpha = 1
        
    }
}
