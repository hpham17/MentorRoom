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
  User.create(name: name, email: email, password: "hubert", role: "Mentee" )
end

mentor_list.each do |name, email|
  User.create(name: name, email: email, password: "hubert", role: "Mentor", limit: 2 )
end

User.create(name: "Dante Leon", email: "dante@gmail.com", password: "dantes", role: "Admin")
