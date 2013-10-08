typenames = {"1" => "Hyperdiploid",
"2" => "TCF3-PBX1",
"3" =>	"ETV6_RUNX1",
"4" => "MLL",
"5" => "Ph",
"6" => "Hypo",
"7" => "Other",
"8" => "T-ALL",
"9" => "CD10CD19",
"10" => "CD34",
"_GSE42414_1" => "Control_HSC",
"_GSE42414_2" => "Control_lymphoid",
"_GSE42414_3" => "Control_myeloid"}

REACHABLE_PAIRS_COUNT = 249
files = ARGV
nodes = []
#fix a specific ordering for nodes across all files
open files.first do |f|
	until (line = f.gets).nil?
		next if line.strip.empty?
		nodes << line.strip.split.first
	end
end

cents = {}
files.each do |file|
	cent = {}
	open file do |f|
		until (line = f.gets).nil?
			next if line.strip.empty?
			node, c = line.strip.split
			cent[node] = c.to_f.round(6)
		end
	end
	type = file.split("type").last.split(".").first
	cents[type] = cent
end

# filter out nodes of all-zero centrality
deleteables = []
nodes.each{|n| deleteables << n if cents.keys.map{|t| cents[t][n] < 1.0}.all?}
nodes = nodes - deleteables

open "centrality.vectors.table", "w" do |f|
	f.puts "#{sprintf "%-20s", ""}#{nodes.map{|p| sprintf "%-14s", p}.join}"
	cents.each do |type, cent|
		f.puts "#{sprintf "%-20s", typenames[type]}#{nodes.map{|n| sprintf "%-14f", 100.0*cent[n]/REACHABLE_PAIRS_COUNT}.join}"
	end
end










