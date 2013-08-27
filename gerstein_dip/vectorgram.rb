typenames = {"1" => "Hyperdiploid",
"2" => "TCF3-PBX1",
"3" =>	"ETV6_RUNX1",
"4" => "MLL",
"5" => "Ph",
"6" => "Hypo",
"7" => "Other",
"8" => "T-ALL",
"9" => "CD10CD19",
"10" => "CD34"}

files = ARGV
pairs = []
#fix a specific ordering for sources and targets for all files
open files.first do |f|
	until (line = f.gets).nil?
		next if line.strip.empty?
		s, t, p = line.strip.split
		s = s.split("source").last.split(".").first
		t = t.split("target").last.split(".").first
		pairs << "#{s},#{t}"
	end
end

probs = {}
files.each do |file|
	prob = {}
	open file do |f|
		until (line = f.gets).nil?
			next if line.strip.empty?
			s, t, p = line.strip.split
			s = s.split("source").last.split(".").first
			t = t.split("target").last.split(".").first
			prob["#{s},#{t}"] = p
		end
	end
	type = file.split("type").last.split(".").first
	probs[type] = prob
end

open "reachability.vectors.table", "w" do |f|
	f.puts "#{sprintf "%-16s", ""}#{pairs.map{|p| sprintf "%-14s", p}.join}"
	probs.each do |type, prob|
		f.puts "#{sprintf "%-16s", typenames[type]}#{pairs.map{|p| sprintf "%-14s", prob[p]}.join}"
	end
end










