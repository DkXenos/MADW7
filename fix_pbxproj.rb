path = "/Users/jaysn/Documents/MAD/LAB/LabWeek7/LabWeek7.xcodeproj/project.pbxproj"
content = File.read(path)
lines = content.split("\n")

out = []
in_exceptions = false
lines.each do |line|
  if line.include?("membershipExceptions = (")
    in_exceptions = true
    out << line
    out << "\t\t\t\tContentView.swift,"
    out << "\t\t\t\tModel/Pet.swift,"
    out << "\t\t\t\tModel/Stat.swift,"
    out << "\t\t\t\tViewModel/PetViewModel.swift,"
    out << "\t\t\t\tVIew/watchOS/WatchActionViews.swift,"
    out << "\t\t\t\tVIew/watchOS/WatchStatusView.swift,"
    next
  end
  
  if in_exceptions
    if line.strip == ");"
      in_exceptions = false
      out << line
    end
    next
  end
  
  out << line
end

File.write(path, out.join("\n") + "\n")
