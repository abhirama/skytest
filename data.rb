require "skydb"
require 'securerandom'

client = SkyDB::Client.new()
table = client.get_table("users")

base = Time.new()

actions = ["homepage", "login", "checkout"]
genders = ["m", "f"]
states = ["kar", "ap", "tn", "ker", "raj", "del", "mah"]
amounts = [20, 100, 40, 50, 10]

10.times do
  id = SecureRandom.hex
  gender = genders.sample
  state = states.sample
  365.times do |day|
    day_start = base + (day * 86400) #24 * 60 * 60
    table.add_event(id, :timestamp => day_start, :data => {"gender" => gender, "state" => state})
    3.times do 
      hour =  rand(1..24) * 60
      hour_start = day_start + (hour * 60)
      actions.each_with_index do |action, index|
        timestamp = hour_start + index
        if action == "checkout"
          amount = amounts.sample
          table.add_event(id, :timestamp => timestamp, :data => {"action" => action, "purchase_amount" => amount})
        else
          table.add_event(id, :timestamp => timestamp, :data => {"action" => action})
        end
      end
    end
    #sleep(1)
  end
end

