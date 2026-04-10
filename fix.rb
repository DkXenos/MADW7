require 'xcodeproj'
project_path = '/Users/jaysn/Documents/MAD/LAB/LabWeek7/LabWeek7.xcodeproj'
project = Xcodeproj::Project.open(project_path)

watch_target = project.targets.find { |t| t.name.include? 'Watch App' }

project.files.each do |f|
  next unless f.real_path
  if f.real_path.to_s.end_with?('LabWeek7Watch Watch App/ContentView.swift')
    f.remove_from_project
  end
end

paths = [
  'LabWeek7/ContentView.swift',
  'LabWeek7/Model/Pet.swift',
  'LabWeek7/Model/Stat.swift',
  'LabWeek7/ViewModel/PetViewModel.swift',
  'LabWeek7/VIew/watchOS/WatchActionViews.swift',
  'LabWeek7/VIew/watchOS/WatchStatusView.swift'
]

project.files.each do |f|
  next unless f.real_path
  if paths.any? { |p| f.real_path.to_s.end_with?(p) }
    unless watch_target.source_build_phase.files_references.include?(f)
      watch_target.source_build_phase.add_file_reference(f)
      puts "Added #{f.path}"
    end
  end
end

project.save
puts "Done"
