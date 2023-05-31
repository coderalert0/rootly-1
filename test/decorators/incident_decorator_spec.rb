# frozen_string_literal: true

require 'rails_helper'

describe IncidentDecorator do
  let(:time_now) { Time.now }
  let(:subject) { Incident.new(created_at: time_now - 1.day, resolved_at: time_now).decorate }

  describe '#resolution_time_display' do
    it 'returns a human readable duration' do
      expect(subject.resolution_time_display).to eq '1 days'
    end
  end
end
