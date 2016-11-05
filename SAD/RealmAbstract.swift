//
//  RealmAbstract.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 04/11/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import Foundation

import RealmSwift

class RealmAbstract: Object {
    
    
    
    
    let config = Realm.Configuration(
        // Get the URL to the bundled file
        fileURL: Bundle.main.url(forResource: "MyBundledData", withExtension: "realm"),
        // Open the file in read-only mode as application bundles are not writeable
        readOnly: true)

    
    
    func setDefaultRealmForUser(username: String) {
        var config = Realm.Configuration()
        
        // Use the default directory, but replace the filename with the username
        config.fileURL = config.fileURL!.deletingLastPathComponent()
            .appendingPathComponent("\(username).realm")
        
        // Set this as the configuration used for the default Realm
        Realm.Configuration.defaultConfiguration = config
    }

    
    
}
