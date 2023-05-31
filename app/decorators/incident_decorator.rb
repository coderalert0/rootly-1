# frozen_string_literal: true

class IncidentDecorator < Draper::Decorator
  delegate_all

  def resolution_time_display
    resolution_time = resolved_at - created_at
    ActiveSupport::Duration.build(resolution_time).parts.map do |key, value|
      [value.to_i, key].join(' ')
    end.join(', ')
  end
end
