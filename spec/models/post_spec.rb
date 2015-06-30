require 'rails_helper'

describe Post do
  describe "vote methods" do

    before do
      user  = User.create(name: "Tom", email: "test@example.com", password: "testtest")
      topic = Topic.create(name: "topic name", description: "topic description " * 3)
      @post = Post.create(title: "post title", body: "post body" * 5,
                          user: user, topic: topic)

      # Note: a post is automatically upvoted once when it is created
      3.times { @post.votes.create(value:  1) }
      2.times { @post.votes.create(value: -1) }
    end

    describe "#up_votes" do
      it "counts the number of votes with value = 1" do
        expect( @post.up_votes ).to eq(3 + 1)
      end
    end

    describe "#down_votes" do
      it "counts the number of votes with value = -1" do
        expect( @post.down_votes ).to eq(2)
      end
    end

    describe "#points" do
      it "returns the sum of all up and down votes" do
        expect( @post.points ).to eq(2) # 4 - 2
      end
    end
  end

end