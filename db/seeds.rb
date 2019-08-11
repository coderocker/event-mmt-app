# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'csv'

# users_file = File.read(Rails.root.join('lib', 'seeds', 'users.csv'))
users_csv = CSV.read(
    Rails.root.join('lib', 'seeds', 'users.csv'), 
    :headers => true, 
    :encoding => 'ISO-8859-1'
)

users = users_csv.map do |u|    
    u.to_h.merge(password: 'dummy123')
end

users.each_slice(1000) do |batch|
    User.create batch
end

events_csv = CSV.read(
    Rails.root.join('lib', 'seeds', 'events.csv'), 
    :encoding => 'ISO-8859-1',
    :headers => true,
    header_converters: :symbol, 
    converters: :all
)


events_csv.each do |event|
    event_data = event.to_h
    rsvps = event_data.delete(:usersrsvp)
    eve = Event.new(event_data)
    eve.build_rsvp(rsvps)
    eve.save
end



