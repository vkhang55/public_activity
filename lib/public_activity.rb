require 'active_record'
# +public_activity+ helps with keeping track of activities
# and lets you display them.
module PublicActivity

  class << self
    # Records an activity in the database, based on supplied arguments.
    #
    # @example
    #   PublicActivity.record "user.avatar_changed", :actor => @user if @user.avatar_file_name_changed?
    #
    #   PublicActivity.record "user.received_a_message", :actor => current_user, :recipient => @message.recipient, :trackable => @message
    #
    #   PublicActivity.record "user.commented_article", :actor => current_user, :trackable => @comment,
    #                         :article_title => @article.title # :article_title is a custom value that will be serialized and saved in PublicActivity::Activity.parameters
    #
    # @param key
    #   Custom unique key that will be used as a i18n translation key - *required*
    # @param [Hash] options
    #
    # @option options [ActiveRecord::Base] actor
    #    Polymorphic association specifying the actor of this activity (for example, a User who performed this task)
    #
    #     PublicActivity.record "user.commited_changes", :actor => current_user
    #
    # @option options [ActiveRecord::Base] recipient
    #     Set this to a model instance if you want the activity to be private. For example: notifications about private messages
    #     should only be visible to the user receiving them.
    #
    #      PublicActivity.record "user.received_a_message", :actor => current_user, :recipient => @message.recipient
    #
    # @option options [ActiveRecord::Base] trackable
    #     Model instance this activity is about. For example a Comment or an Article.
    #
    #      PublicActivity.record "user.commented", :actor => current_user, :trackable => @article
    #
    #   Every additional key-value pair will be serialized and accessible when displaying the activity. Useful for
    #   caching article title or truncated body to skip additional database requests.
    #
    # @return [PublicActivity::Activity]
    def record(key, options = {})
      PublicActivity::Activity.create(:key => key, :actor => options.delete(:actor), :trackable => options.delete(:trackable), :recipient => options.delete(:actor), :parameters => options)
    end
  end

end

require 'public_activity/version'
require 'public_activity/activity'
require 'public_activity/actor'

