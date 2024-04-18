# Pin npm packages by running ./bin/importmap

pin "application", preload: true

pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true

pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"

pin_all_from 'app/javascript/controllers', under: 'controllers'
pin_all_from "app/components", under: "components", preload: true

# components_path = Rails.root.join("app/components")
# components_path.glob("**/*_controller.js").each do |controller|
#   name = controller.relative_path_from(components_path).to_s.remove(/\.js$/)
#   pin "components/#{name}", to: name
# end