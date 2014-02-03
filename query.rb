require "skydb"
client = SkyDB::Client.new()

table = client.get_table("users")

# Perform a simple count of all events in the table.
#results = table.query([:type => 'selection', :fields => [{:name => 'myCount', :expression => 'count()'}]])

results = table.query(
  :steps => [
    {:type => 'condition', :expression => 'action == "homepage"', :steps => [
      {:type => 'condition', :expression => 'action == "login"', :within => [1,1], :steps => [
        {:type => 'condition', :expression => 'action == "checkout"', :within => [1,1], :steps => [
          {:type => 'selection', :dimensions => ['gender', 'state'], :fields => [
            {:name => 'count', :expression => 'count()'},
            {:name => 'total_amount', :expression => 'sum(purchase_amount)'}
          ]},
        ]}
      ]}
    ]}
  ]
)

puts results.inspect
