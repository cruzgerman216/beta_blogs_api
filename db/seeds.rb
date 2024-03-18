
User.find_each do |user|
  rand(1..5).times do
    blog = user.blogs.create!(
      title: 'Title',
      content: 'Content',
      created_at: 1.month.ago
    )


    # give random likes to the blgo 
    rand(1..10).times do |i|

      liker = User.offset(rand(User.count)).first

      liker.likes.create!(likeable: blog)
    end
  end
end