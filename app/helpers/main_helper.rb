module MainHelper
  def modal(title:, &block)
    render Shared::ModalComponent.new(title: title), &block
  end
end
