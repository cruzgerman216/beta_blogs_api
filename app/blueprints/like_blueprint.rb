# frozen_string_literal: true

class LikeBlueprint < Blueprinter::Base
  fields :id, :user_id, :likeable_id, :likeable_type
end
