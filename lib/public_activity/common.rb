module PublicActivity
  # Common methods shared across the gem.
  module Common
    extend ActiveSupport::Concern
    # Instance methods used by other methods in PublicActivity module.
    module InstanceMethods
      # Directly creates activity record in the database, based on supplied arguments.
      # Only first argument - key - is required.
      #
      # == Usage:
      #
      #   current_user.create_activity("activity.user.avatar_changed") if @user.avatar_file_name_changed?
      #
      # == Parameters:
      # [key]
      #   Custom key that will be used as a i18n translation key - *required*
      # [actor]
      #   Polymorphic relation specifying the actor of this activity (for example, a User who performed this task) - *optional*
      # [params]
      #  Hash with parameters passed directly into i18n.translate method - *optional*
      #
      def create_activity(key, actor = nil, params = {})
        
        if actor.nil? && ((defined? User) != nil) && User.respond_to?(:current_user)
          actor = User.current_user
        end
            
        activity = self.activities.create(:key => key, :actor => actor, :parameters => params)
        if !Pusher.app_id.nil? && !Pusher.key.nil? && !Pusher.secret.nil?
          Pusher['acitivty-channel'].trigger('acitivty-create', {:key => key, :actor => actor, :parameters => params, :text => activity.text, :object => self})
        end
      end

      private
        # Prepares settings used during creation of Activity record.
        # params passed directly to tracked model have priority over
        # settings specified in tracked() method
        def prepare_settings
          # user responsible for the activity
          if self.activity_actor
            actor = self.activity_actor
          else
            actor = self.class.activity_actor_global
          end
          
          case actor
            when Symbol
              actor = self.try(actor)
            when Proc
              actor = actor.call(self)
          end
          #customizable parameters
          parameters = self.class.activity_params_global
          parameters.merge! self.activity_params if self.activity_params      
          return {:key => self.activity_key,:actor => actor, :parameters => parameters}
        end      
    end
  end
end
