//
//  ViewController.swift
//  BildirimIzniAlma
//
//  Created by ArdaSisli on 5.01.2022.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    var notification = false
    var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound], completionHandler: { (granted,error) in
            
            self.notification = granted
            if granted {
                print("approval")
            }else{
                print("error")
            }
        } )
    }
    
    @IBAction func Click(_ sender: Any) {
        count += 1
        if notification {
            
            let YesA = UNNotificationAction(identifier: "yes", title: "Yes", options: .foreground)
            let DeleteA = UNNotificationAction(identifier: "delete", title: "Delete", options: .destructive)
            
            let catagory = UNNotificationCategory(identifier: "cat", actions: [YesA,DeleteA], intentIdentifiers: [], options: [])
            UNUserNotificationCenter.current().setNotificationCategories([catagory])
            
            let icerik = UNMutableNotificationContent()
            icerik.title = "alarm"
            icerik.subtitle = "Wake up"
            icerik.body = "wake up you will be late"
            icerik.categoryIdentifier = "cat"
            
            if let temp = count as? NSNumber {
                icerik.badge = temp
            }
            icerik.sound = UNNotificationSound.default
            
            var date = DateComponents()
            date.minute = 34
            date.hour = 3
            //let tetikleme = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
            let tetikleme = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
            let bildirimistegi = UNNotificationRequest(identifier: "Uyandirma Merkezi", content: icerik, trigger: tetikleme)
            UNUserNotificationCenter.current().add(bildirimistegi, withCompletionHandler: nil)
        }
    }
}

extension ViewController:UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.banner,.sound,.sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == "yes" {
            print("clicked yes")
        }
        if response.actionIdentifier == "delete" {
            print("clicked delete")
        }
        completionHandler()
    }
}




