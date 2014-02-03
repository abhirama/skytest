require "skydb"

client = SkyDB::Client.new()
table = client.create_table(:name => 'users')
table = client.get_table("users")
table.create_property(:name => "action", :transient => true, :data_type => "factor")
table.create_property(:name => "purchase_amount", :transient => true, :data_type => "float")
table.create_property(:name => "gender", :data_type => "factor")
table.create_property(:name => "state", :data_type => "factor")
