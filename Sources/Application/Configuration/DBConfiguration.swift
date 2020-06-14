import LoggerAPI
import KituraContracts
import SwiftKueryORM
import SwiftKueryPostgreSQL

func initializeDBConfiguratiosn()  {
    
    let pool = PostgreSQLConnection.createPool(host: "host.docker.internal", port: 5432, options: [.databaseName("swift"),.userName("postgres"),.password("postgres")], poolOptions: ConnectionPoolOptions(initialCapacity: 10, maxCapacity: 50))
    Database.default = Database(pool)
    
}
