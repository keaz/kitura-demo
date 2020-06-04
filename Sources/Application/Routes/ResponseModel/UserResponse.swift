import Foundation

struct UserResponse:Codable {
    
    static let dobFormat = "yyyy-MM-dd";
    
    let id:String
    let firstName:String
    let lastName:String
    let dob:String
    
    init(id:String, firstName:String, lastName:String, dob:Date) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.dob = format(date: dob, format: UserResponse.dobFormat)
    }
    
}
