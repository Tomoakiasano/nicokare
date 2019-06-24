# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Team.create!(
  [
    {
      id: 1,
      team_name: 'SF team'
    },
    {
      id: 2,
      team_name: 'WEB team'
    },
    {
      id: 3,
      team_name: 'BDE team'
    },
    {
      id: 4,
      team_name: 'QA team'
    },
  ]
)

User.create!(
  [
    {
      id: 1,
      team_id: 1,
      name: 'asano',
      email: 'testasano@gmail.com',
      password: 'password'
    },
    {
      id: 2,
      team_id: 2,
      name: 'tomoaki',
      email: 'testtomoaki@gmail.com',
      password: 'password'
    },
    {
      id: 3,
      team_id: 3,
      name: 'nagahama',
      email: 'testnagahama@gmail.com',
      password: 'password'
    },
    {
      id: 4,
      team_id: 4,
      name: 'hiroyuki',
      email: 'testhiroyuki@gmail.com',
      password: 'password'
    },
    {
      id: 5,
      team_id: 1,
      name: 'yamane',
      email: 'testyamane@gmail.com',
      password: 'password'
    },
    {
      id: 6,
      team_id: 2,
      name: 'shota',
      email: 'testshota@gmail.com',
      password: 'password'
    },
    {
      id: 7,
      team_id: 3,
      name: 'sato',
      email: 'testsato@gmail.com',
      password: 'password'
    },
    {
      id: 8,
      team_id: 4,
      name: 'wataru',
      email: 'testwataru@gmail.com',
      password: 'password'
    },
  ]
)
