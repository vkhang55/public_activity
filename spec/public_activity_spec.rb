require 'spec_helper'

describe PublicActivity do
  before :all do
    self.class.fixtures :posts, :users, :comments

  end

  let(:current_user) {User.where(:name => "Piotrek").first}

  it "should create a record in activity table" do
    lambda do
      PublicActivity.record "something.happened"
    end.should change(PublicActivity::Activity, :count).by(1)
  end

  it "should have a key specified" do
    PublicActivity.record "user.commented"
    PublicActivity::Activity.last.key.should == "user.commented"
  end

  it "should have an actor" do
    PublicActivity.record "user.commented", :actor => current_user
    PublicActivity::Activity.last.actor.should_not be_nil
  end
end