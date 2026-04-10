require 'xcodeproj'
project = Xcodeproj::Project.open('/Users/jaysn/Documents/MAD/LAB/LabWeek7/LabWeek7.xcodeproj')
project.main_group.children.each do |child|
  puts child.name || child.path
end
