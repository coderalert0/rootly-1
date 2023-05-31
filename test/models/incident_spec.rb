# frozen_string_literal: true

require 'rails_helper'

describe Incident do
  context 'without a title' do
    let(:subject) { Incident.new }

    it 'does not save the incident' do
      expect(subject.save).to eq false
    end
  end

  context 'with a title' do
    let(:subject) { Incident.new(title: 'Acme') }

    it 'saves the incident' do
      expect(subject.save).to eq true
    end
  end
end
