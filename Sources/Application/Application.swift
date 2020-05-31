import Foundation
import Kitura
import LoggerAPI
import Configuration
import CloudEnvironment
import KituraContracts
import Health
import Dispatch


public let projectPath = ConfigurationManager.BasePath.project.path
public let health = Health()

public class App {
    let router = Router()
    let cloudEnv = CloudEnv()
    let workerQueue = DispatchQueue(label: "worker")

    public init() throws {
        // Configure logging
        initializeLogging()
        
        initializeDBConfiguratiosn()
        // Run the metrics initializer
        initializeMetrics(router: router)
    }

    func postInit() throws {
        // Endpoints
        initializeHealthRoutes(app: self)
        initializeUserRoutes(app: self)
        initializeBookRoutes(app: self)
        
    }

    public func run() throws {
        try postInit()
        Kitura.addHTTPServer(onPort: cloudEnv.port, with: router)
        Kitura.run()
    }
    
    func execute(_ block: (() -> Void)) {
        workerQueue.sync {
            block()
        }
    }
}
