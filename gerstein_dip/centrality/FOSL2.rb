#read ref values
sources = Dir.glob("source*.txt").map{|file| file.split("source").last.split(".").first.to_i}.sort
targets = Dir.glob("target*.txt").map{|file| file.split("target").last.split(".").first.to_i}.sort
ref = {}
ref_edges = {}

open "type1.mid" do |f|
	until (line = f.gets).nil?
		parts = line.strip.split
		ref[parts[0].to_i] ||= {}
		ref_edges[parts[0].to_i] ||= {}
		ref[parts[0].to_i][parts[1].to_i] = parts.pop.to_f
		ref_edges[parts[0].to_i][parts[1].to_i] = parts.pop
	end
end

sources.each do |source|
	targets.each do |target|
		print "Running missing_FOSL2 from #{source} to #{target}: "
		if ref[source][target] == 0.0
			puts "N/A"
			next
		end
		output = `../../preach type1.missing_FOSL2.txt source#{source}.txt target#{target}.txt #{ref_edges[source][target]}`
		new_value = output.strip.split.last
		puts new_value
		open "type1FOSL2", "a" do |f|
			puts "#{sprintf "%-10s", (ref[source][target] < new_value.to_f)}#{ref[source][target]}=>#{new_value.to_f}(#{new_value})"
		end
	end
end