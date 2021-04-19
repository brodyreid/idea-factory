# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PASSWORD = "123"

Review.delete_all ###### WOW my mega-bug was that I had these .delete_all calls in a different order................ Wow how does that even make sense. Why you do dis to me railz >:(
Idea.delete_all
User.delete_all


super_user = User.create(
    name: "Brody",
    email: "brody@ideas.com",
    password: PASSWORD,
)

10.times do
    User.create(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: PASSWORD,
    )
end

users = User.all

100.times do
    created_at = Faker::Date.backward(days: 365 * 5)
    i = Idea.create(
        title: Faker::Hacker.say_something_smart,
        description: Faker::TvShows::GameOfThrones.quote,
        like_count: rand(100_100),
        created_at: created_at,
        updated_at: created_at,
        user: users.sample,
    )
    if i.valid?
        i.reviews = rand(0..15).times.map do
            Review.new(
                description: Faker::GreekPhilosophers.quote,
                user: users.sample,
                )
        end
    end
end