# adds dummy prob, and outputs the terminal nodes
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

sources = levels[levels.keys.max]
targets = []
open datafile do |fin|
	open datafile.gsub(".txt", ".dummy.txt"), "w" do |fout|
		until (line = fin.gets).nil?
			next if line.strip.empty?
			s, t = line.split
			targets << s unless non_leaf[s]
			targets << t unless non_leaf[t]
			fout.puts "#{line.strip} \t 0.5"
		end
	end
end

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