import Foundation
import SwiftKueryORM

struct User: Model {
    var id: String
    let firstName: String
    let lastName : String
    let dob: Date
    
    init(id:String, firstName: String, lastName: String, dob:Date) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.dob = dob
    }
    
}
