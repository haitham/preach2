#adds 0.5 probabilities to network files
files = ARGV
files.each do |file|
	puts file
	lines = []
	open file do |f|
		until (line = f.gets).nil?
			next if line.strip.empty?
			lines << line.strip
		end
	end
	open file, "w" do |f|
		lines.each{|l| f.puts "#{l}   0.5"}
	end
end