import Kitura
import LoggerAPI
import Application
import HeliumLogger

HeliumLogger.use()
do {
    
    let app = try App()
    try app.run()

} catch let error {
    Log.error(error.localizedDescription)
}
