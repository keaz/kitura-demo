import Foundation

struct UserSaveRequest: Codable {
 
    static let dobFormat = "yyyy-MM-dd";
    
    let firstName: String
    let lastName: String
    let dob: String
    
    var dobDate: Date {
        return format(string: self.dob, format: UserSaveRequest.dobFormat)
    }
    
}


