import SwiftKueryORM

struct User: Model {
    var id: String
    let firstName: String
    let lastName : String
    
    init(id:String, firstName: String, lastName: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
    }
    
}
