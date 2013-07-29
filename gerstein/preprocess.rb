# removes the leaf nodes, adds dummy prob, and outputs the terminal nodes
datafile, hierarchy = ARGV
levels = {}
non_leaf = {}
open hierarchy do |f|
	until (line = f.gets).nil?
		next if line.strip.empty?
		node, level = line.strip.split.map{|p| p.strip}
		levels[level.to_i] ||= []
		levels[level.to_i] << node
		non_leaf[node] = true
	end
end

open datafile do |fin|
	open datafile.gsub(".txt", ".min.txt"), "w" do |fout|
		until (line = fin.gets).nil?
			next if line.strip.empty?
			t = line.strip.split.last
			fout.puts "#{line.strip} \t 0.5" if non_leaf[t]
		end
	end
end

sources = levels[levels.keys.max]
targets = levels[levels.keys.min]
open datafile.gsub(".txt", "_allsources.txt"), "w" do |fall|
	sources.each_with_index do |s, i|
		fall.puts s
		open(datafile.gsub(".txt", "_source#{i}.txt"), "w"){|f| f.puts s}
	end
end
open datafile.gsub(".txt", "_alltargets.txt"), "w" do |fall|
	targets.each_with_index do |t, i|
		fall.puts t
		open(datafile.gsub(".txt", "_target#{i}.txt"), "w"){|f| f.puts t}
	end
end