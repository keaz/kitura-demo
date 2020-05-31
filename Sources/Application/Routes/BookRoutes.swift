import LoggerAPI
import KituraContracts
import SwiftKueryORM
import SwiftKueryPostgreSQL

extension Book:Model {}

func initializeBookRoutes(app: App){
    
    do{
        try Book.createTableSync()
    }catch{
        print("Failed to create table: \(error)")
    }
    
    
}

extension App {
    
    
}
