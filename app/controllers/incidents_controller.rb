# frozen_string_literal: true

class IncidentsController < ApplicationController
  # a not advisable workaround to a CSRF error possibly caused by the call from Slack
  skip_before_action :verify_authenticity_token

  def index
    @incidents = Incident.order("#{params[:column]} #{params[:direction]}")
    render 'incidents/_incidents', locals: { incidents: @incidents }
  end

  def call
    command = params[:text].split[0]

    if command == 'resolve'
      incident_id = params[:text].split[1]
      incident = Incident.find(incident_id)
      incident.update(resolved_at: Time.now)
      render plain: I18n.t(:incident_resolved_message, time: incident.decorate.resolution_time_display)
    elsif command == 'declare'
      Incident.create(arguments_hash(params))
      render plain: I18n.t(:incident_created_message)
    end
  end

  private

  # converts the slack command arguments into a hash
  def arguments_hash(params)
    arguments = params[:text].split(' --')[1..-1].map { |e| [e.split[0], e.split[1..-1].join(' ')] }.flatten
    Hash[*arguments].merge! 'author' => params[:user_name]
  end
end
