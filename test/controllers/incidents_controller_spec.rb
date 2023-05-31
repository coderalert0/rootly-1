# frozen_string_literal: true

require 'rails_helper'

describe IncidentsController, type: :controller do
  describe '#index' do
    let!(:incident) { Incident.create(title: 'Acme') }

    it 'assigns all incidents as @incidents' do
      get :index
      assigns(:incidents).should eq([incident])
    end

    it 'renders the correct template' do
      get :index
      expect(response).to render_template(partial: 'incidents/_incidents')
    end
  end

  describe '#call' do
    context 'for the declare command' do
      let(:text) { 'declare --title May Day May Day! --description All hell is breaking loose --severity sev2' }

      before :each do
        post :call, params: { text: text }
      end

      it 'creates a new incident' do
        expect(Incident.count).to eq 1
      end

      it 'renders the correct response text' do
        expect(response.body).to eq 'The incident was created'
      end
    end

    context 'for the resolve command' do
      let!(:incident) { Incident.create(title: 'Acme') }

      before :each do
        post :call, params: { text: 'resolve 1' }
      end

      it 'populates resolved_at' do
        expect(incident.reload.resolved_at).to_not be_nil
      end

      it 'renders the correct response text' do
        expect(response.body).to eq 'The resolution time was: 0 seconds'
      end
    end
  end

  describe '#arguments_hash' do
    let(:text) { 'declare --title May Day May Day! --description All hell is breaking loose --severity sev2' }
    let(:params) { { text: text, user_name: 'gary.dhaliwal' } }

    it 'returns the correct attributes hash' do
      expect(controller.send(:arguments_hash, params)).to eq "author" => 'gary.dhaliwal',
                                                             "description" => "All hell is breaking loose",
                                                             "severity" => "sev2",
                                                             "title" => "May Day May Day!"
    end
  end
end
