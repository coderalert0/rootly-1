# frozen_string_literal: true

class Incident < ActiveRecord::Base
  enum severity: { sev0: 0, sev1: 1, sev2: 2 }

  validates_presence_of :title
end
