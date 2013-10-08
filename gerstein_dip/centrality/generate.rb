datasets = ARGV

datasets.each do |dataset|
	edges = []
	nodes = []
	open dataset do |f|
		until (line = f.gets).nil?
			next if line.strip.empty?
			parts = line.split.map{|p| p.strip}
			edges << parts
			nodes << parts[0] unless nodes.include? parts[0]
			nodes << parts[1] unless nodes.include? parts[1]
		end
	end
	puts "nodes: #{nodes.size}"

	nodes.each do |node|
		open dataset.gsub(".txt", ".missing_#{node}.txt"), "w" do |f|
			edges.each do |edge|
				f.puts edge.join " " unless edge.include? node
			end
		end
	end
end