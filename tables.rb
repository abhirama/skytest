require "skydb"
client = SkyDB::Client.new()

# Retrieve a list of all tables.
tables = client.get_tables()

#Delete existing tables
tables.each {|table| puts(table.name)}
