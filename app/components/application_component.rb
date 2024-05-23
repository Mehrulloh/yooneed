class ApplicationComponent < ViewComponent::Base
  delegate :modal, to: :helpers
end
