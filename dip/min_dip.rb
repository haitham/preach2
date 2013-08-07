input = ARGV[0]
edges = {}
open input do |fin|
	until (line = fin.gets).nil?
		next if line.strip.empty?
		edge = line.split.sort.join "<-->"
		count = edges[edge] || 0
		edges[edge] = count + 1
	end
end

open input.gsub(".txt", ".min.txt"), "w" do |fout|
	edges.each{|edge, count| fout.puts "#{edge.split("<-->"). join " \t\t "} \t\t #{count}"}
end
