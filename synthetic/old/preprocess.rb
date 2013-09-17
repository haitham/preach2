#converts sif network into txt, throws summy 0.5 probablities, and creates node files
dirs = ARGV
dirs.each do |dir|
	puts dir
	open "#{dir}/network.sif" do |sif|
		open "#{dir}/network.txt", "w" do |txt|
			until (line = sif.gets).nil?
				s, d, t = line.split
				next if s.nil? or t.nil?
				txt.puts "#{s}   #{t}   0.5"
			end
		end
	end
	0.upto(dir.split("/").last.split("-").first.to_i - 1) do |i|
		open("#{dir}/node#{i}.txt", "w"){|f| f.puts i}
	end
end