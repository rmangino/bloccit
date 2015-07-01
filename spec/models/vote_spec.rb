require 'rails_helper'

describe Vote do

  include TestFactories
  
  describe "validations" do

    describe "value validations" do
      it "only allow -1 or 1 as values" do
        user  = User.create(name: "Tom", email: "test@example.com", password: "testtest")
        topic = Topic.create(name: "topic name", description: "topic description " * 3)
        post  = Post.create(title: "post title", body: "Post bodies must be pretty long.",
                            user: user, topic: topic)
        
        (-10..10).each do |val|
          vote = Vote.create(value: val, post: post)
          if val == 1 || val == -1
            expect(vote.valid?).to eq(true)
          else
            expect(vote.valid?).to eq(false)
          end
        end
      end  
    end

    describe "after_save" do
      it "calls `Post#update_rank` after save" do
        post = associated_post
        vote = Vote.new(value: 1, post: post)

        expect( post ).to receive(:update_rank)

        # trigger the call to update_rank. this *has* to happen after we
        # set the expectation.
        vote.save
      end
    end

  end # describe "validations"

end # describe Vote