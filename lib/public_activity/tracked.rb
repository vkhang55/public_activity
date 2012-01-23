module PublicActivity
  # Main module extending classes we want to keep track of.
  module Tracked
    # Adds a has_many :activities assocation for easy access to
    # activites created by the model.
    def tracked(options = {})
      has_many :activities, :class_name => "PublicActivity::Activity", :as => :trackable
    end
  end
end
