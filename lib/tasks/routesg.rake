# Runs: rake routes | grep -i [arg]
task :rg, [:route_str] do |t, arg|
  if arg.empty?
    puts "Enter route resource to grep for"
  else
    sys_str = "rake routes | grep -i #{arg[:route_str]}"
    puts "Calling: '#{sys_str}'"
    system(sys_str)
  end
end