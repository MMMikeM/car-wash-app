namespace :create_dev_records do
  desc "Create dev records"
  task :all => :environment do
    user = User.find_by(email: 'manager@example.com') || User.create(
      email: "admin@example.com",
      password: "password",
      password_confirmation: "password",
      name: "Tom Jones",
      contact_number: "+27110009999",
      total_points: 0
    )
    user.roles << Role.find_by(name: 'manager')
    user.roles << Role.find_by(name: 'salesperson')
    user.save

    user = User.find_by(email: 'dude@example.com') || User.create(
      email: "dude@example.com",
      password: "password",
      password_confirmation: "password",
      name: "Tom Jones",
      contact_number: "+27110009999",
      total_points: 0
    )
    user.roles << Role.find_by(name: 'salesperson')
    user.save

    vehicle = Vehicle.find_or_create_by(user: user, registration_number: "AA11BBGP")

    wash_types = [
      {
        "name": "Engine Wash",
        "cost": 1000,
        "price": 7500,
        "points": 0,
        "description": "",
        "order": 2
      },
      {
        "name": "Full House Wash",
        "cost": 1000,
        "price": 12000,
        "points": 10,
        "description": "Wash, Dry, Vaccuum, Tyre Polish, Disinfectant Fogging*",
        "order": 4
      },
      {
        "name": "Full House Wash (Minivan)",
        "cost": 1000,
        "price": 16000,
        "points": 10,
        "description": "Wash, Dry, Vaccuum, Tyre Polish, Disinfectant Fogging*",
        "order": 4
      },
      {
        "name": "Carbon Treatment Stage 1",
        "cost": 1000,
        "price": 30000,
        "points": 15,
        "description": "Full House + Stage Machine Polish + Protective Glaze",
        "order": 5
      },
      {
        "name": "Carbon Treatment Stage 2",
        "cost": 10,
        "price": 50000,
        "points": 2000,
        "description": "Full House + 2 Stage Machine Polish + Protective Glaze",
        "order": 6
      },
      {
        "name": "Leather Valet",
        "cost": 1000,
        "price": 30000,
        "points": 15,
        "description": "Full House + Leather Cleanse + Leather Treatment",
        "order": 7
      },
      {
        "name": "Diamond Package ",
        "cost": 1000,
        "price": 70000,
        "points": 30,
        "description": "Full House + 2 Stage Machine Polish + Protective Glaze + Leather Valet",
        "order": 8
      },
      {
        "name": "Disinfectant Fogging",
        "cost": 1000,
        "price": 2500,
        "points": 0,
        "description": "",
        "order": 9
      },
      {
        "name": "Wash & Go",
        "cost": 1000,
        "price": 6000,
        "points": 0,
        "description": "",
        "order": 0
      },
      {
        "name": "Wash & Dry",
        "cost": 1000,
        "price": 7500,
        "points": 0,
        "description": "",
        "order": 1
      },
      {
        "name": "Free Wash",
        "cost": 1000,
        "price": 0,
        "points": -100,
        "description": "",
        "order": 10,
        "free": true
      }
    ]

    wash_types.each do |wash_type_json|
      WashType.create!(wash_type_json)
    end
  end
end
