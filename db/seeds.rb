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


Group.create(title: 'CS 2023', description: 'Group for CS 2023 students', user_id: 7)
Group.create(title: 'Software 2023', description: 'Group for Software 2023 students', user_id: 7)

6.times do |i|
    Member.create(
      user_id: i+1,
      group_id: 1
    )
  end
  Exercise.create(title: "Give FA that accepts at most 2 a's", exercise_type: 'FA', user_id: 1, group_id: 1)
  Exercise.create(title: "Give FA that accepts an even number of a's", exercise_type: 'FA', user_id: 1, group_id: 1)
  Exercise.create(title: "Give FA that accepts an even number of a's and b's over the languge Σ ={a, b}", exercise_type: 'FA', user_id: 1, group_id: 1)
  Exercise.create(title: "Construct the DFA for the following language. $L\: =\: \{w \in \Sigma^* \mid n_b(w) \:mod\: 3\: =\: 0 \:and\: does\: not\: have\: the\: substring\: aab\}$ , Σ ={a, b}. For example, bbba, bababa, babbbbbaaandaaaa are in L. But baababa is not.", exercise_type: 'CFL', user_id: 7, group_id: 1)
  Exercise.create(title: "Write a grammar for the alphabet $\Sigma = \{a, b\}$ and language $L = \{b, ab, bab\}$.", exercise_type: 'grammer', user_id: 7, group_id: 1)
  Exercise.create(title: "Construct the PDA that accepts strings in $\{w \mid w \in \{a, b\}^*\}$ that have twice as many a's as b's.", exercise_type: 'PDA', user_id: 7, group_id: 1)
  Exercise.create(title: "Give a regular expression whose language is strings over $\{a, b\}$ that contain aba.", exercise_type: 'Regular', user_id: 7, group_id: 1)
  Exercise.create(title: "Give a Turing Machine that accepts all strings that has a number of a’s that is a power of two $L = \{a^{2^n}\mid n>0\}, \Sigma = \{a\}$. In other words, it implements the language in Turing Acceptable form.", exercise_type: 'TM', user_id: 7, group_id: 1)
  Exercise.create(title: "Convert the following NFA to a DFA.", exercise_type: 'Regular', user_id: 7, group_id: 1)

  9.times do |i|
    Task.create(
      group_id: 1,
      exercise_id: i+1
    )
  end
  Submission.create(user_id: 1, exercise_id: 1, grade: 100.0, solution: "{\"nodes\":[{\"left\":184.5,\"top\":66.60000610351562,\"i\":true,\"f\":true,\"name\":\"q0\"},{\"left\":351.5,\"top\":36.600006103515625,\"i\":false,\"f\":true,\"name\":\"q1\"},{\"left\":581.5,\"top\":76.60000610351562,\"i\":false,\"f\":true,\"name\":\"q2\"},{\"left\":405.5,\"top\":346.6000061035156,\"i\":false,\"f\":false,\"name\":\"q3\"}],\"edges\":[{\"start\":0,\"end\":1,\"weight\":\"a\"},{\"start\":1,\"end\":2,\"weight\":\"a\"},{\"start\":2,\"end\":3,\"weight\":\"a\"},{\"start\":3,\"end\":3,\"weight\":\"a\"}],\"names\":[\"q0\",\"q1\",\"q2\",\"q3\"],\"shorthand\":false}")
  Submission.create(user_id: 1, exercise_id: 2, grade: 100.0, solution: "{\"nodes\":[{\"left\":111.5,\"top\":77.60000610351562,\"i\":true,\"f\":true,\"name\":\"q0\"},{\"left\":283.5,\"top\":86.60000610351562,\"i\":false,\"f\":false,\"name\":\"q1\"}],\"edges\":[{\"start\":0,\"end\":1,\"weight\":\"a\"},{\"start\":1,\"end\":0,\"weight\":\"a\"}],\"names\":[\"q0\",\"q1\"],\"shorthand\":false}")
  Submission.create(user_id: 1, exercise_id: 3, grade: 100.0, solution: "{\"nodes\":[{\"left\":112.5,\"top\":68.19999694824219,\"i\":true,\"f\":true,\"name\":\"q0\"},{\"left\":461.5,\"top\":82.19999694824219,\"i\":false,\"f\":false,\"name\":\"q1\"},{\"left\":460.5,\"top\":263.1999969482422,\"i\":false,\"f\":false,\"name\":\"q2\"},{\"left\":142.5,\"top\":279.1999969482422,\"i\":false,\"f\":false,\"name\":\"q3\"}],\"edges\":[{\"start\":0,\"end\":1,\"weight\":\"a\"},{\"start\":0,\"end\":3,\"weight\":\"b\"},{\"start\":1,\"end\":0,\"weight\":\"a\"},{\"start\":1,\"end\":2,\"weight\":\"b\"},{\"start\":2,\"end\":1,\"weight\":\"b\"},{\"start\":2,\"end\":3,\"weight\":\"a\"},{\"start\":3,\"end\":2,\"weight\":\"a\"},{\"start\":3,\"end\":0,\"weight\":\"b\"}],\"names\":[\"q0\",\"q1\",\"q2\",\"q3\"],\"shorthand\":false}")
  Submission.create(user_id: 2, exercise_id: 1, grade: 80.0, solution: "{\"nodes\":[{\"left\":183.5,\"top\":77.60000610351562,\"i\":true,\"f\":false,\"name\":\"q0\"},{\"left\":391.5,\"top\":74.60000610351562,\"i\":false,\"f\":true,\"name\":\"q1\"},{\"left\":544.5,\"top\":76.60000610351562,\"i\":false,\"f\":true,\"name\":\"q2\"},{\"left\":534.5,\"top\":228.60000610351562,\"i\":false,\"f\":false,\"name\":\"q3\"}],\"edges\":[{\"start\":0,\"end\":1,\"weight\":\"a\"},{\"start\":1,\"end\":2,\"weight\":\"a\"},{\"start\":2,\"end\":3,\"weight\":\"a\"},{\"start\":3,\"end\":3,\"weight\":\"a\"}],\"names\":[\"q0\",\"q1\",\"q2\",\"q3\"],\"shorthand\":false}")
  Submission.create(user_id: 2, exercise_id: 2, grade: 85.71428571428571, solution: "{\"nodes\":[{\"left\":85.5,\"top\":104.60000610351562,\"i\":true,\"f\":true,\"name\":\"q0\"},{\"left\":467.5,\"top\":125.60000610351562,\"i\":false,\"f\":false,\"name\":\"q1\"}],\"edges\":[{\"start\":0,\"end\":1,\"weight\":\"a\"},{\"start\":1,\"end\":0,\"weight\":\"a\"}],\"names\":[\"q0\",\"q1\"],\"shorthand\":false}")
