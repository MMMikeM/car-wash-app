namespace :create_dev_records do
  task :basic_user => :environment do
    branch = Branch.create(name: "main", free_wash_points: 90)
    User.create(email: "admin@example.com", password: "password", branch_id: branch.id)
    WashType.create(
      name: "basic",
      cost: 50,
      price: 100,
      points: 10,
      branch_id: branch.id
    )
  end
end
