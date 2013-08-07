network, output = ARGV
sources = Dir.glob "*_source*.txt"
targets = Dir.glob "*_target*.txt"

open output, "w" do |f|
	sources.each do |source|
		targets.each do |target|
			puts "../preach #{network} #{source} #{target}"
			output = `../preach #{network} #{source} #{target}`
			f.puts output.strip
		end
	end
end

