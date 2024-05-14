# Find or create the user with the specified email
user = User.find_or_create_by!(email: ENV["ADMIN_EMAIL"]) do |user|
  user.password = ENV["ADMIN_PASSWORD"]
  user.password_confirmation = ENV["ADMIN_PASSWORD"]
  user.name = "Admin"
  user.surname = "Admin"
  user.role_supervisor!
end

# Find or create the product
product = Product.find_or_create_by!(name: "Wasser") do |product|
  product.active = true
  product.amount = 1
end
