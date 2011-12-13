# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_project_management_system_session',
  :secret      => '7315c32849036f8eecfff3ba58c642b13169694c928423635172ef7988c5cab9888b1c62362cbe78bd0d52dc0308f468d72ca1007df2f9a0914b076a1fdf29bc'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
