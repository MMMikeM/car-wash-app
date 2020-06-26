namespace :create_dev_records do
  task :basic_user => :environment do
    User.create(email: "admin@example.com", password: "password")
  end
end
