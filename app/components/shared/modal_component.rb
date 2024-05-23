class Shared::ModalComponent < ViewComponent::Base
  include Turbo::FramesHelper
  include Turbo::StreamsHelper

  attr_reader :title

  def initialize(title: "title")
    @title = title
  end

  def call
    turbo_frame_tag "modal" do
      content_tag :div, class: 'modal-wrapper shadow-2xl rounded-lg', data: { controller:  "modal" } do
        content_tag :div, class: 'modal-content', data: {modal_target: "modal"} do
          concat header_component
          concat content_tag :div, content, class: "py-2 px-4"
        end
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