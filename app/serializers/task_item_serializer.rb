# frozen_string_literal: true

class TaskItemSerializer
  include FastJsonapi::ObjectSerializer

  attributes :description, :scheduled_date, :category, :checked, :created_at, :updated_at
end
