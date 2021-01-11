require 'rails_helper'

RSpec.describe TaskItem, type: :model do
  # Validation tests
  it { should validate_presence_of(:description) }
end
