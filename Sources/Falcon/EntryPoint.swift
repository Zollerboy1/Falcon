//
//  EntryPoint.swift
//  Falcon
//
//  Created by Josef Zoller on 16.02.20.
//

public enum EntryPoint {
    public static func create(with applicationType: Application.Type) {
        Log.coreInfo("\(Falcon.welcomeMessage)")
        
        let application = applicationType.init()
        application.run()
    }
}
