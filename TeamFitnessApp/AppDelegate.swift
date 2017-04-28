//
//  AppDelegate.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/3/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FacebookCore
import FBSDKLoginKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate  {

    var window: UIWindow?
    let healthKitManager = HealthKitManager.sharedInstance


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FIRApp.configure()

        getData()

        // initalize the window
        self.window = UIWindow(frame: UIScreen.main.bounds)
        //check for nill
        guard let window = self.window else { fatalError("no window") }

        //set the root view controller
        window.rootViewController = AppController()

        //make the window visible
        window.makeKeyAndVisible()


        return true

    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        getData()

    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        AppEventsLogger.activate(application)
    }

    func applicationWillTerminate(_ application: UIApplication) {

    }

    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
        -> Bool {
            print("FACEBOOK URL********** : \(url.absoluteString) END URL **********")
            if FBSDKApplicationDelegate.sharedInstance().application(application, open: url, options: options) {
                return true
            } else if GIDSignIn.sharedInstance().handle(url,
                                                        sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                        annotation: [:]) {
                return true
            } else {
                return false
            }
    }

    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }

    func getData() {
        if let userUid = FIRAuth.auth()?.currentUser?.uid {
            FirebaseManager.fetchUserOnce(withFirebaseUID: userUid) { (user) in
                for challenge in user.challengeIDs {
                    FirebaseManager.fetchChallengeOnce(withChallengeID: challenge, completion: { (challenge) in
                        let startDate = challenge.startDate!
                        let endDate = challenge.endDate!
                        let challengeID = challenge.id!
                        let goal = challenge.goal!.type!

                        switch goal {
                        case .miles:
                            self.healthKitManager.getDistance(fromDate: startDate, toDate: endDate, completion: { (count, error) in
                                if let count = count {
                                    FirebaseManager.updateChallengeData(challengeID: challengeID, userID: userUid, withData: count) {}
                                }
                            })
                        case .stepCount:
                            self.healthKitManager.getSteps(fromDate: startDate, toDate: endDate, completion: { (count, error) in
                                if let count = count {
                                    FirebaseManager.updateChallengeData(challengeID: challengeID, userID: userUid, withData: count){}
                                }
                            })
                        case .caloriesBurned:
                            self.healthKitManager.getCalories(fromDate: startDate, toDate: endDate, completion: { (count, error) in
                                if let count = count {
                                    FirebaseManager.updateChallengeData(challengeID: challengeID, userID: userUid, withData: count){}
                                }
                            })
                        case .exerciseMinutes:
                            self.healthKitManager.getExerciseTime(fromDate: startDate, toDate: endDate, completion: { (count, error) in
                                if let count = count {
                                    FirebaseManager.updateChallengeData(challengeID: challengeID, userID: userUid, withData: count){}
                                }
                            })
                        }
                    })
                }
            }
        }
    }
}


