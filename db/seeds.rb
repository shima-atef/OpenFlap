# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create(first_name: 'Abdelrahman', last_name: 'Samir', email: 'abdelrahmansamir326@gmail.com', password: '123456', can_add_exercise: true)
User.create(first_name: 'Seif', last_name: 'Amr', email: 'seifelnasr@gmail.com', password: '123456', can_add_exercise: true)
User.create(first_name: 'Marwa', last_name: 'Ahmed', email: 'marwaahmed@gamil.com', password: '123456', can_add_exercise: true)
User.create(first_name: 'Shimaa', last_name: 'Atef', email: 'shimaatef@gmail.com', password: '123456', can_add_exercise: true)
User.create(first_name: 'Shimaa', last_name: 'Nasr', email: 'Shimaanasr@gmail.com', password: '123456', can_add_exercise: true)
User.create(first_name: 'Samaa', last_name: 'Khaled', email: 'samaakhaled@gmail.com', password: '123456', can_add_exercise: true)
User.create(first_name: 'Mostafa', last_name: 'Kamel', email: 'mostafakamel@gmail.com', password: '123456', can_add_exercise: true)
User.create(first_name: 'Admin', last_name: ' ', email: 'admin@gmail.com', password: '123456', can_add_exercise: true)


Group.create(title: 'CS 2023', description: 'Group for CS 2023 students', user_id: 1)
Group.create(title: 'CS 2022', description: 'Group for CS 2023 students', user_id: 7)
Group.create(title: 'Software 2023', description: 'Group for Software 2023 students', user_id: 7)

8.times do |i|
    Member.create(
      user_id: i+1,
      group_id: 1
    )
  end
  Exercise.create(title: 'Even frequency', exercise_type: 'FA', user_id: 7, group_id: 1)
  Exercise.create(title: 'Odd frequency', exercise_type: 'FA', user_id: 7, group_id: 1)
  Task.create(group_id: 1, exercise_id: 1)
  Task.create(group_id: 1, exercise_id: 2)

    Submission.create(user_id: 1, exercise_id: 1, grade: 100.0, solution: "{\"nodes\":[{\"left\":42.0,\"top\":148.60000610351562,\"i\":true,\"f\":true,\"name\":\"q0\"},{\"left\":389.0,\"top\":168.60000610351562,\"i\":false,\"f\":false,\"name\":\"q1\"}],\"edges\":[{\"start\":0,\"end\":1,\"weight\":\"a\"},{\"start\":0,\"end\":1,\"weight\":\"b\"},{\"start\":1,\"end\":0,\"weight\":\"a\"},{\"start\":1,\"end\":0,\"weight\":\"b\"}],\"names\":[\"q0\",\"q1\"],\"shorthand\":false}")
    Submission.create(user_id: 1, exercise_id: 2, grade: 75.0, solution: '{\"nodes\":[{\"left\":48.0,\"top\":68.60000610351562,\"i\":true,\"f\":false,\"name\":\"q0\"},{\"left\":494.0,\"top\":63.600006103515625,\"i\":false,\"f\":false,\"name\":\"q1\"},{\"left\":46.0,\"top\":265.6000061035156,\"i\":false,\"f\":false,\"name\":\"q2\"},{\"left\":497.0,\"top\":260.6000061035156,\"i\":false,\"f\":true,\"name\":\"q3\"}],\"edges\":[{\"start\":0,\"end\":1,\"weight\":\"a\"},{\"start\":0,\"end\":2,\"weight\":\"b\"},{\"start\":1,\"end\":0,\"weight\":\"a\"},{\"start\":1,\"end\":3,\"weight\":\"b\"},{\"start\":2,\"end\":3,\"weight\":\"a\"},{\"start\":2,\"end\":0,\"weight\":\"b\"},{\"start\":3,\"end\":1,\"weight\":\"b\"},{\"start\":3,\"end\":2,\"weight\":\"a\"}],\"names\":[\"q0\",\"q1\",\"q2\",\"q3\"],\"shorthand\":false}')
   