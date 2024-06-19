module CustomRspecHelper
    def select_date_range(start_date:, end_date:)
        page.execute_script("flatpickr('input[data-controller=\"flatpicker\"]', {mode: 'range', defaultDate: [#{start_date.strftime("'%Y-%m-%d'")}, #{end_date.strftime("'%Y-%m-%d'")}]})")
    end
end

RSpec.configure do |config|
    config.include CustomRspecHelper
end