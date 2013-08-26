network, output = ARGV
sources = Dir.glob "*_source*.txt"
targets = Dir.glob "*_target*.txt"

open output, "w" do |f|
	sources.each do |source|
		targets.each do |target|
			stat = `../stats #{network} #{source} #{target}`
			puts "#{source}  #{target}  #{stat.strip}"
			next if stat.split.size == 4
			output = `../preach #{network} #{source} #{target}`
			f.puts "#{source}  #{target}  #{output.strip.split.last}"
		end
	end
end

