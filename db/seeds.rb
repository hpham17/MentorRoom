mentee_list = [
  ["Hubert", "hubqwerty@gmail.com"],
  [ "Sally", "sally@gmail.com"],
  [ "Andrew", "andrew@gmail.com"],
  [ "Ryan", "ryan@gmail.com"]
]

mentor_list = [
  ["Andrea", "andrea@gmail.com"],
  [ "Marie", "marie@gmail.com" ],
  [ "Bill", "bill@gmail.com" ],
  [ "Karen", "karen@gmail.com"]
]



mentee_list.each do |name, email|
  @user = User.create(name: name, email: email, password: "hubert", role: "Mentee", organization_id: 1, confirmed_at: DateTime.now )
end

mentor_list.each do |name, email|
  @user = User.create(name: name, email: email, password: "hubert", role: "Mentor", limit: 2, organization_id: 1, confirmed_at: DateTime.now )
  Profile.create(user_id: @user.id, role: 'Software Engineer', location: 'San Francisco', linkedin: 'http://www.linkedin.com/in/hpham95', company: 'Google', major: 'Computer Science', school: 'UC Berkeley')
end

User.create(name: "Dante Leon", email: "dante@gmail.com", password: "dantes", role: "Admin")

Organization.create(name: "MentorRoom", private: false, trial: false, creator_id: 1)
