require 'rails_helper'

describe Topic do
   
  describe "scopes" do
 
    before do 
      @public_topic  = Topic.create(name: "This is a public topic name") # default is public
      @private_topic = Topic.create(public: false, name: "This is a private topic name")
    end
   
    describe "publicly_viewable" do
      it "returns a relation of all public topics" do
        expect( Topic.publicly_viewable ).to eq( [@public_topic] )
      end
    end
   
    describe "privately_viewable" do
      it "returns a relation of all private topics" do
        expect( Topic.privately_viewable ).to eq( [@private_topic] )
      end
    end
   
    describe "visible_to(user)" do
      it "returns all topics if the user is present" do
        user = true # sneaky solution; we don't need a real user, just something truthy
        expect( Topic.visible_to(user).count ).to eq(Topic.count)
      end
    end

    it "returns only public topics if user is nil" do
      user = nil # sneaky solution; we don't need a real user, just something truthy
      expect( Topic.visible_to(user).count ).to eq(Topic.count - 1)
    end

  end # describe "scopes"

 end # Topic