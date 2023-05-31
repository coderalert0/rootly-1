# frozen_string_literal: true

module IncidentsHelper
  def sort_link(column:)
    if column == params[:column]
      link_to(I18n.t(column), incidents_path(column: column, direction: next_direction))
    else
      link_to(I18n.t(column), incidents_path(column: column, direction: 'asc'))
    end
  end

  def next_direction
    params[:direction] == 'asc' ? 'desc' : 'asc'
  end
end
