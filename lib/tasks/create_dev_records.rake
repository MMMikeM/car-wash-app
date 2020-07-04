namespace :create_dev_records do
  desc "Create dev records"
  task :all => :environment do
    user = User.find_by(email: 'admin@example.com') || User.create(
      email: "admin@example.com",
      password: "password",
      password_confirmation: "password",
      name: "Tom Jones",
      contact_number: "+27110009999",
      total_points: 0
    )

    vehicle = Vehicle.find_or_create_by(user: user, registration_number: "AA11BBGP")
  end
end
