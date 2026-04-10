require 'xcodeproj'

project_path = '/Users/jaysn/Documents/MAD/LAB/LabWeek7/LabWeek7.xcodeproj'
project = Xcodeproj::Project.open(project_path)
watch_target = project.targets.find { |t| t.name == "LabWeek7Watch Watch App" }

def find_files(group, target)
  group.children.each do |child|
    if child.is_a?(Xcodeproj::Project::Object::PBXGroup)
      find_files(child, target)
    elsif child.is_a?(Xcodeproj::Project::Object::PBXFileReference)
      if child.path && child.path.end_with?('.swift')
        puts "Found swift file: #{child.path}"
        if child.path.match?(/(PetViewModel|Pet|Stat|WatchActionViews|WatchStatusView)\.swift$/)
          unless target.source_build_phase.files_references.include?(child)
            puts "Adding #{child.path} to watch target"
            target.source_build_phase.add_file_reference(child)
          end
        end
      end
    end
  end
end

project.main_group.children.each do |group|
  if group.is_a?(Xcodeproj::Project::Object::PBXGroup)
    find_files(group, watch_target)
  end
end

project.save
puts "Done configuring files."
