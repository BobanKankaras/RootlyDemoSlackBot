class Incident < ApplicationRecord
    attribute :title, :string, limit: 255
    attribute :description, :string, limit: 1000
    attribute :severity, :string, limit: 5
    attribute :resolved, :integer, default: 0
    attribute :resolved_at, :datetime
end
