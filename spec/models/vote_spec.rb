require 'rails_helper'

describe Vote do
  
  describe "validations" do
    
    describe "value validations" do
      it "only allow -1 or 1 as values" do
        user  = User.create
        topic = Topic.create
         post = Post.create(title: "post title", body: "Post bodies must be pretty long.",
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

  end

end