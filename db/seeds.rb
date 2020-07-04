Role.find_or_create_by(name: 'Sysadmin') # Full access to system
Role.find_or_create_by(name: 'Manager') # Can manage the system
Role.find_or_create_by(name: 'Salesperson') # Access to salesperson interfaces
Role.find_or_create_by(name: 'Client') # May see own information