//
//  Datacontroller.swift
//  Bookworm
//
//  Created by Macmaurice Osuji on 4/19/23.
//
import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")
    
    init() {
        container.loadPersistentStores {description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    //func addNewBook (contex: context)
}
