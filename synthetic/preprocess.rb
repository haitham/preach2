#adds 0.5 probabilities to network files, generates max_size node files
max_size = ARGV[0].to_i
dir = ARGV[1]
files = ARGV[2..ARGV.size-1]
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

0.upto(max_size-1) do |i|
	open "#{dir}/node#{i}.txt", "w" do |f|
		f.puts i
	end
end