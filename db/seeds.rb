if User.all.count == 0
  User.create(name: "wong", password: "1234")
  User.create(name: "weijia", password: "1234")
end