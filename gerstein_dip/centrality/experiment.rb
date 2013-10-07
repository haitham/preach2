#argument example: "type9" or "type_GSE42414_0"
dataset = ARGV[0]
sources = Dir.glob("source*.txt").map{|file| file.split("source").last.split(".").first.to_i}.sort
targets = Dir.glob("target*.txt").map{|file| file.split("target").last.split(".").first.to_i}.sort
reference = {}
ref_edges = {}

#reset mid file
open "#{dataset}.mid", "w" do |f|
end
sources.each do |source|
	reference[source] = {}
	ref_edges[source] = {}
	targets.each do |target|
		print "Running #{dataset} reference from #{source} to #{target}: "
		output = `../../preach #{dataset}.txt source#{source}.txt target#{target}.txt`
		parts = output.strip.split
		open "#{dataset}.mid", "a" do |f|
			f.puts "#{source}  #{target}  #{output}"
		end
		reference[source][target] = parts.pop.to_f
		ref_edges[source][target] = parts.pop
		puts reference[source][target]
	end
end

#reset out file
open "#{dataset}.out", "w" do |f|
end
nodes = Dir.glob("#{dataset}.missing_*.txt").map{|file| file.split("missing_").last.split(".txt").first}
values = {}
nodes.each do |node|
	values[node] = 0.0
	sources.each do |source|
		targets.each do |target|
			print "Running missing_#{node} from #{source} to #{target}: "
			if reference[source][target] == 0.0
				puts "N/A"
				next
			end
			output = `../../preach #{dataset}.missing_#{node}.txt source#{source}.txt target#{target}.txt #{ref_edges[source][target]}`
			new_value = output.strip.split.last
			puts new_value
			values[node] = values[node] + reference[source][target] - new_value.to_f unless new_value == "REFSAME"
		end
	end
	open "#{dataset}.out", "a" do |f|
		f.puts "#{sprintf "%-14s", node}#{values[node]}"
	end
end

open "#{dataset}.sort", "w" do |f|
	values.map{|k,v| [k,v]}.sort{|a,b| b[1] <=> a[1]}.each{|p| f.puts "#{sprintf "%-12f", p[1]}#{"  "}#{p[0]}"}
end
