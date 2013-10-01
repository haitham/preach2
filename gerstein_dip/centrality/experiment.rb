#argument example: "type9" or "type_GSE42414_0"
dataset = ARGV[0]
sources = Dir.glob("source*.txt").map{|file| file.split("source").last.split(".").first.to_i}.sort
targets = Dir.glob("target*.txt").map{|file| file.split("target").last.split(".").first.to_i}.sort
reference = {}

sources.each do |source|
	reference[source] = {}
	targets.each do |target|
		print "Running #{dataset} reference from #{source} to #{target}: "
		output = `../../preach #{dataset}.txt source#{source}.txt target#{target}.txt`
		reference[source][target] = output.strip.split.last.to_f
		puts reference[source][target]
	end
end

nodes = Dir.glob("#{dataset}.missing_*.txt").map{|file| file.split("missing_").last.split(".txt").first}
values = {}
nodes.each do |node|
	values[node] = 0.0
	sources.each do |source|
		targets.each do |target|
			print "Running missing_#{node} from #{source} to #{target}: "
			output = `../../preach #{dataset}.missing_#{node}.txt source#{source}.txt target#{target}.txt`
			new_value = output.strip.split.last.to_f
			puts new_value
			values[node] = values[node] + reference[source][target] - new_value
		end
	end
	open "#{dataset}.out", "a" do |f|
		f.puts "#{sprintf "%-14s", node}#{values[node]}"
	end
end

open "#{dataset}.sorted.out", "w" do |f|
	values.map{|k,v| [k,v]}.sort{|a,b| b[1] <=> a[1]}.each{|p| f.puts "#{sprintf "%-12f", p[1]}#{"  "}#{p[0]}"}
end
