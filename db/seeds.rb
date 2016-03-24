# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# User Creation
User.create(name: 'Harsha', email:'skunapa@ncsu.edu', password: '1234', usertype: 'Super Admin')
User.create(name: 'Harini', email:'hkumbam@ncsu.edu', password: '1234', usertype: 'Admin')
User.create(name: 'Yuvraj', email:'yrathor@ncsu.edu', password: '1234', usertype: 'Admin')
User.create(name: 'Jaithrik', email:'jbollab@ncsu.edu', password: '1234', usertype: 'Student')
User.create(name: 'Dr. Edward Gehringer', email:'edg@ncsu.edu', password: '1234', usertype: 'Instructor')
User.create(name: 'Dr. Steffen Heber', email:'heber@ncsu.edu', password: '1234', usertype: 'Instructor')
User.create(name: 'Anush', email:'abonam@ncsu.edu', password: '1234', usertype: 'Student')
User.create(name: 'Dheeraj', email:'rnagaru@ncsu.edu', password: '1234', usertype: 'Student')
