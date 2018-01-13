require_relative 'student'

students = [
  Student.new('Sergio', 'Bobillier'),
  Student.new('John', 'Doe'),
  Student.new('Jane', 'Doe')
]

students.each do |student|
  puts [student.first_name, student.last_name, student.full_name].inspect
end

puts Student.count
