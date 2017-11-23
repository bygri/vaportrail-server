import MySQLProvider
import Vapor
import VaportrailServer

Node.fuzzy = [Row.self, JSON.self, Node.self]

let config = try Config()
try config.addProvider(MySQLProvider.Provider.self)
try config.addProvider(VaportrailServer.Provider.self)

let drop = try Droplet(config)
try drop.run()
