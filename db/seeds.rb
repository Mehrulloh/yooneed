# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

# Find or create the user with the specified email
user = User.find_or_create_by!(email: ENV["ADMIN_EMAIL"]) do |user|
  user.password = ENV["ADMIN_PASSWORD"]
  user.password_confirmation = ENV["ADMIN_PASSWORD"]
  user.add_role :supervisor
  user.name = "Admin"
  user.surname = "Admin"
end

# Find or create the product
product = Product.find_or_create_by!(name: "Wasser") do |product|
  product.price = 1
  product.user = user
end
