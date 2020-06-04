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

private func saveUser(saveRequest: UserSaveRequest, completion: @escaping (UserResponse?, RequestError?) -> Void) {
    Log.info("Saving User")
    let user = convertUser(request: saveRequest)
    user.save { (savedUser, error) in
        guard let newUser = savedUser else{
            Log.error("Failed to Save User")
            completion(nil,error)
            return
        }
        Log.info("New User Id \(newUser.id)")
        completion(convert(userEntity: user),nil)
    }
}

func convertUser(request:UserSaveRequest) -> User {
    return User(id: UUID().uuidString , firstName: request.firstName, lastName: request.lastName,dob: request.dobDate)
}

func convert(userEntity user :User) -> UserResponse {
    return UserResponse(id: user.id, firstName: user.firstName, lastName: user.lastName, dob: user.dob)
}

func getAllUsers(completion: @escaping ([UserResponse]?,RequestError?) -> Void) {
    User.findAll { (users, error) in
        let response = users?.map({ (user) -> UserResponse in
            convert(userEntity: user)
        })
        completion(response,error)
    }
}

func findById(id: String, completion: @escaping (UserResponse?,RequestError?) -> Void) {
    User.find(id: id) { (user, error) in
        guard let user = user else{
            completion(nil,error)
            return
        }
        completion(convert(userEntity: user),error)
    }
}

func deleteUser(id: String, completion: @escaping (RequestError?) -> Void) {
    User.delete(id: id){ error in
        completion(error)
    }
}
