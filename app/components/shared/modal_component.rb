class Shared::ModalComponent < ViewComponent::Base
  attr_reader :title

  def initialize(title: "title")
    @title = title
  end

  def call
    content_tag :div, class: 'modal-wrapper shadow-2xl rounded-lg', data: { controller:  "modal" } do
      content_tag :div, class: 'modal-content' do
        concat header_component
        concat content_tag :div, content, class: "py-2 px-4"
      end
    end
  end

  private

  def header_component
    content_tag :div, class: 'modal-header rounded-t-lg flex justify-between px-4' do
      concat content_tag(:h1, title, class: "text-lg font-white font-bold")
      concat content_tag(:span, 'x', class: "text-lg font-white font-bold cursor-pointer", data: {action: "click->modal#close"})
    end
  end
end