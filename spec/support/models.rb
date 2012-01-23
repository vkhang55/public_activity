class User < ActiveRecord::Base
  extend PublicActivity::Actor
  acts_as_actor
end

class Post < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :body
end

class Comment < ActiveRecord::Base
  belongs_to :post
end
