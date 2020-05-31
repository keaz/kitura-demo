struct Book:Codable {
    let id : Int?
    let name: String
    let author: User
    
    init(id: Int?, name: String, author: User) {
        self.id = id
        self.name = name
        self.author = author
    }
}
