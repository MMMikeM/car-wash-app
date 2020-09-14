require 'pry'
require 'csv'

namespace :import_users do
  desc "Create dev records"
  task :run => :environment do
    names_mapping = {
      "promo" => "Promo Wash & Go",
      "free" => "Free Wash",
      "Free" => "Free Wash",
      "leather valet" => "Leather Valet",
      "Leather Valet" => "Leather Valet",
      "wash n go" => "Wash & Go",
      "engine wash" => "Engine Wash",
      "engine was" => "Engine Wash",
      "engene wash" => "Engine Wash",
      "engine" => "Engine Wash",
      "engIne" => "Engine Wash",
      "Engine Wash" => "Engine Wash",
      "engIne wash" => "Engine Wash",
      "full wash" => "Full House Wash",
      "wash & go" => "Wash & Go",
      "wash and go" => "Wash & Go",
      "wash &  go" => "Wash & Go",
      "Wash & Go" => "Wash & Go",
      "wash & dry" => "Wash & Dry",
      "wash n dry" => "Wash & Dry",
      "Wash & Dry" => "Wash & Dry",
      "wash dry" => "Wash & Dry",
      "wash&dry" => "Wash & Dry",
      "wash and dry" => "Wash & Dry",
      "full hoise" => "Full House Wash",
      "full house" => "Full House Wash",
      "Full house" => "Full House Wash",
      "Full House" => "Full House Wash",
      "fuĺl wash" => "Full House Wash",
      "fuĺl house" => "Full House Wash",
      "full houe" => "Full House Wash",
      "full was" => "Full House Wash",
      "diamond" => "Diamond Package ",
      "diamond package" => "Diamond Package",
      "Diamond Package" => "Diamond Package",
      "Stage 1" => "Carbon Treatment Stage 1",
      "stage 1" => "Carbon Treatment Stage 1",
      "stage1" => "Carbon Treatment Stage 1",
      "Stage 2" => "Carbon Treatment Stage 2",
      "stage 2" => "Diamond Package ",
      "fogging" => "Disinfectant Fogging",
      "Fogging" => "Disinfectant Fogging",
    }

    details = CSV.read("db.csv")
    customer_role = Role.find_by(name: "customer")
    User.skip_callback(:send_customer_sms)
    washes_created = 0
    Wash.delete_all
    details[1..-1].each do |row|
      email = row[4]
      user = User.find_by(email: email)
      if user
        user.roles = [customer_role]
        user.save
        user.vehicles.create(registration_number: row[5])
      else
        identifier = SecureRandom.uuid
        if row[4].nil? || row[4] == "none"
          email = "#{identifier}@carboncarwash.co.za"
        end
        user = User.create(
          name: "#{row[1]} #{row[2]}",
          contact_number: row[3],
          email: email,
          password: "carboncarwash",
          password_confirmation: "carboncarwash")

        if user.id
          user.roles = [customer_role]
          user.save
          vehicle = user.vehicles.find_by(registration_number: row[5])
          user.vehicles.create(registration_number: row[5]) unless vehicle
        else
          binding.pry
          puts "#{row[1]} #{row[2]} - #{row[4]} - #{row[3]} | #{user.errors.full_messages.join(',')}"
        end
      end

      mapped_name = names_mapping.with_indifferent_access[row[6].strip]
      wash_type = WashType.find_by(name: mapped_name)

      if wash_type
        wash = Wash.create(user_id: user.id, wash_type_id: wash_type.id)
        if wash.id
          washes_created += 1
        end
      else
        puts "######## Wash Type not found: #{row[6]}"
      end
    end

    puts "washes created: #{washes_created}"
  end
end
