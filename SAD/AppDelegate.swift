//
//  AppDelegate.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 19/10/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import UIKit
import CoreData
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    // ACABOU DE ABRIR O APP
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FIRApp.configure()
        return true
    }
    
    
    
    //SAI DA APLICACAO, COLOCANDO EM BACKGROUND .. momento em que da um tap no home
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        return true
    }
    
    
    //APP ENTRA EM BACKGROUND, APENAS NA MEMORIA
    func applicationDidEnterBackground(_ application: UIApplication) {
       
    }

    //APP APARECE QNDO JA ESTAVA NA MEMORIA
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    //APP ATIVO PARA O USUARIO
    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    
    //APP FINALIZA A APP
    func applicationWillTerminate(_ application: UIApplication) {
        
        saveContext()
    }
    
    
    
    
    //////#### CORE DATA #####//////
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "SAD")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }


    
}

