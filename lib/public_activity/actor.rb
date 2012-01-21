module PublicActivity
  # Module extending classes that serve as actors
  module Actor
    extend ActiveSupport::Concern
    # Module extending classes that serve as actors
    module ClassMethods
      # Adds has_many :activities association to model
      # so you can list activities performed by the actor.
      # It is completely optional, but simplifies your work.
      # 
      # == Usage:
      # In model:
      #
      #   class User < ActiveRecord::Base
      #     acts_as_actor
      #   end 
      #
      # In controller:
      #   User.first.activities
      #
      def acts_as_actor
        has_many :activities, :class_name => "PublicActivity::Activity", :as => :actor
      end    
    end
  end
end
