FactoryGirl.define do
  factory :student, class: User do
    name                  "John Doe"
    login                 'john'
    email                 'john@example.com'
    password              'secret'
    password_confirmation 'secret'
    role                  'student'
  end

  factory :admin, parent: :student do
    role 'admin'
  end
end
