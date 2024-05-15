class Shared::ModalComponent < ViewComponent::Base
  attr_reader :title

  def initialize(title: "title")
    @title = title
  end

  def call
    content_tag :div, class: 'modal-wrapper text-center hidden', data: { controller:  "modal" } do
      content_tag :div, class: 'modal-content w-2/4' do
        concat header_component
        concat content_tag :div, content
      end
    end
  end

  private

  def header_component
    content_tag :div, class: 'modal-header bg-slate-300' do
      concat content_tag(:h1, title, class: "text-lg font-white mb-2 font-bold") if title.present?
    end
  end
end