import Foundation
import LoggerAPI
import KituraContracts
import SwiftKueryORM
import SwiftKueryPostgreSQL

func initializeUserRoutes(app: App)  {
    
    do{
        try User.createTableSync()
    }catch{
        Log.error(error.localizedDescription)
    }
    
    app.router.post("/user", handler: saveUser(saveRequest:completion:))
    app.router.get("/user", handler: getAllUsers(completion:))
    app.router.get("/user", handler: findById(id:completion:))
    app.router.delete("/user", handler: deleteUser)
}

private func saveUser(saveRequest: UserSaveRequest, completion: @escaping (User?, RequestError?) -> Void) {
    Log.info("Saving User")
    let user = convertUser(request: saveRequest)
    user.save { (savedUser, error) in
        guard let newUser = savedUser else{
            Log.error("Failed to Save User")
            completion(savedUser,error)
            return
        }
        Log.info("New User Id \(newUser.id)")
        completion(newUser,nil)
    }
}

func convertUser(request:UserSaveRequest) -> User {
    return User(id: UUID().uuidString , firstName: request.firstName, lastName: request.lastName)
}

func getAllUsers(completion: @escaping ([User]?,RequestError?) -> Void) {
    User.findAll(completion)
}

func findById(id: String, completion: @escaping (User?,RequestError?) -> Void) {
    User.find(id: id, completion)
}

func deleteUser(id: String, completion: @escaping (RequestError?) -> Void) {
    User.delete(id: id){ error in
        completion(error)
    }
}
