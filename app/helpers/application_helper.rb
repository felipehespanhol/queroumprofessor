module ApplicationHelper
  def teacher_specialities(teacher)
    teacher_specialities_string = ""
    teacher.specialities.each_with_index do |s, index|
      if index == 0
        teacher_specialities_string << "#{s.name.capitalize}"
      else
        teacher_specialities_string << ", #{s.name.downcase}"
      end
    end
    return teacher_specialities_string  
  end
end
