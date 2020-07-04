Role.find_or_create_by(name: 'Admin') # Full access to system
Role.find_or_create_by(name: 'Manager') # Can manage the system
Role.find_or_create_by(name: 'Salesperson') # Access to salesperson interfaces
Role.find_or_create_by(name: 'Customer') # May see own information
