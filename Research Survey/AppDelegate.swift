//
//  AppDelegate.swift
//  Research Survey
//
//  Created by Junaid Zaidi on 28/10/2021.
//

import UIKit
import Firebase
import CoreData
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let center = UNUserNotificationCenter.current()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        
        return true
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        Helper.startDate = Date()
        self.cancelLocalNotification()
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        if((UserDefaults.standard.string(forKey: "LoggedInUsername")) != nil) {
            Helper.addTimeLog()
            center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
//                        guard error == nil else {
//                            print("Error creating notification")
//                            //return
//                        }
                let scheduledDate = Calendar.current.date(byAdding: .minute, value: 2, to: Date()) ?? Date()
                self.createLocalNotification(title: "Survey Pending", body: "There are some question unanswered in the survey", date: scheduledDate)
                
            }
        }
    }
    
    func cancelLocalNotification() {
        let notificationId = UserDefaults.standard.string(forKey: "AppNotUsedNotification")
        
        if let removeNotification = notificationId {
            center.removePendingNotificationRequests(withIdentifiers: [removeNotification])
        }
    }
    
    func createLocalNotification(title: String, body: String, date: Date){
        
        // Create Notification Content
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        
        // Create Notification Trigger
        //let date = Calendar.current.date(byAdding: .second, value: days, to: Date())
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        // Create The Request
        let uuidString = UUID().uuidString
        UserDefaults.standard.set(uuidString, forKey: "AppNotUsedNotification")
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        //Register The Request With Notification Center
        center.add(request) { (error) in
            guard error == nil else {
                print("Error registering notification")
                return
            }
        }
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

