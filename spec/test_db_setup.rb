require 'mongo'

$db = Mongo::Connection.new("localhost").db("login_example_test")

$db['users'].drop()