require 'xcodeproj'
project_path = '/Users/jaysn/Documents/MAD/LAB/LabWeek7/LabWeek7.xcodeproj'
project = Xcodeproj::Project.open(project_path)

watch_target = project.targets.find { |t| t.name == 'LabWeek7Watch Watch App' }
ios_target = project.targets.find { |t| t.name == 'LabWeek7' }

if !watch_target || !ios_target
  puts "Targets not found"
  exit 1
end

# Remove the deleted ContentView.swift from the watch target
watch_target.source_build_phase.files.each do |f|
  if f.file_ref.path == 'ContentView.swift' && f.file_ref.real_path.to_s.include?('LabWeek7Watch Watch App')
    puts "Removing #{f.file_ref.path} from watch target"
    f.remove_from_project
  end
end

# Find files to add to watch target
files_to_add = [
  'LabWeek7/ContentView.swift',
  'LabWeek7/Model/Pet.swift',
  'LabWeek7/Model/Stat.swift',
  'LabWeek7/ViewModel/PetViewModel.swift',
  'LabWeek7/VIew/watchOS/WatchActionViews.swift',
  'LabWeek7/VIew/watchOS/WatchStatusView.swift'
]

files_to_add.each do |path|
  file_ref = project.files.find { |f| f.real_path.to_s.end_with?(path) }
  if file_ref
    # Check if it's already in the target
    unless watch_target.source_build_phase.files.any? { |f| f.file_ref == file_ref }
      puts "Adding #{path} to watch target"
      watch_target.source_build_phase.add_file_reference(file_ref)
    end
  else
    puts "File reference not found for #{path}"
  end
end

project.save
puts "Successfully updated project"
