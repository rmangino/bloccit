module TestFactories

  include Warden::Test::Helpers
  Warden.test_mode!

  FactoryGirl.define do
    factory :user do
      email 'test@example.com'
      password 'f4k3p455w0rd'

      # if needed
      # is_active true
    end
  end

  def associated_post(options={})
    post_options = {
      title: 'Post title',
      body:  'Post bodies must be pretty long.',
      topic:  Topic.create(name: 'Topic name'),
      user:   authenticated_user
    }.merge(options)

    Post.create(post_options)
  end

  def authenticated_user(options={})
    user_options = { email: "email#{(rand*1000).to_i}@fake.com",
                     password: 'password' }.merge(options)

    user = User.new(user_options)
    user.skip_confirmation!
    user.save
    user
  end
end