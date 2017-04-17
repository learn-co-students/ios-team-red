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


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate  {

    var window: UIWindow?
    let healthKitManager = HealthKitManager.sharedInstance


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
      FIRApp.configure()
        


      // initalize the window
      self.window = UIWindow(frame: UIScreen.main.bounds)
      //check for nill
      guard let window = self.window else { fatalError("no window") }

      //set the root view controller
      window.rootViewController = AppController()

      //make the window visible
      window.makeKeyAndVisible()

//      FIRAuth.auth()?.addStateDidChangeListener() { (auth, user) in
//        if let user = user {
//          self.currentUser = user
//          NotificationCenter.default.post(name: .closeLoginVC, object: nil)
//        } else {
//          NotificationCenter.default.post(name: .closeDashboardVC, object: nil)
//        }
//      }


        return true
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

      if let userUid = FIRAuth.auth()?.currentUser?.uid {
        FirebaseManager.fetchUser(withFirebaseUID: userUid) { (user) in
          for challenge in user.challengeIDs {
            FirebaseManager.fetchChallenge(withChallengeID: challenge, completion: { (challenge) in
              let startDate = challenge.startDate!
              let endDate = challenge.endDate!
              let challengeID = challenge.id!
              let goal = challenge.goal!.type!

              switch goal {
              case .distance:
                self.healthKitManager.getDistance(fromDate: startDate, toDate: endDate, completion: { (count, error) in
                  if let count = count {
                    FirebaseManager.updateChallengeData(challengeID: challengeID, userID: userUid, withData: count)
                  }
                })
              case .stepCount:
                self.healthKitManager.getSteps(fromDate: startDate, toDate: endDate, completion: { (count, error) in
                  if let count = count {
                    FirebaseManager.updateChallengeData(challengeID: challengeID, userID: userUid, withData: count)
                  }
                })
              case .caloriesBurned:
                self.healthKitManager.getCalories(fromDate: startDate, toDate: endDate, completion: { (count, error) in
                  if let count = count {
                    FirebaseManager.updateChallengeData(challengeID: challengeID, userID: userUid, withData: count)
                  }
                })
              case .exerciseTime:
                self.healthKitManager.getExerciseTime(fromDate: startDate, toDate: endDate, completion: { (count, error) in
                  if let count = count {
                    FirebaseManager.updateChallengeData(challengeID: challengeID, userID: userUid, withData: count)
                  }
                })
              }
            })
          }
        }
      }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }


}


