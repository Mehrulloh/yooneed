module StatusTrackable
  extend ActiveSupport::Concern

  included do
    include AASM

    aasm :column => 'status' do
      state :unsolicited, initial: true
      state :processing
      state :accepted
      state :denied

      event :processing do
        transitions from: :unsolicited, to: :processing
      end

      event :accepted do
        transitions from: :processing, to: :accepted
      end

      event :denied do
        transitions from: :processing, to: :denied
      end
    end
  end
end
