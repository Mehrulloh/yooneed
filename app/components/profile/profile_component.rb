class Profile::ProfileComponent < ApplicationComponent

  def initialize(name:, avatar:, form: )
    @name = name
    @form = form
  end

  private

  def header_component
    content_tag :div do

    end
  end
end