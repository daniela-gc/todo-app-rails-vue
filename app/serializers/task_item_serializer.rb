# frozen_string_literal: true

class TaskItemSerializer
  include FastJsonapi::ObjectSerializer

  attributes :description, :scheduled_date, :category, :created_at
end
