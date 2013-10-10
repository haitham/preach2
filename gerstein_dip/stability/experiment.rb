#example parameter: type1 or type_type_GSE42414_1
deltas = ["0.05", "0.1", "0.15", "0.2", "0.25", "0.3"]
repetitions = 20
dataset = ARGV[0]

#read reference reachabilities and filter zeros
pairs = []
ref = {}
open "#{dataset}.mid" do |f|
	until (line = f.gets).nil?
		parts = line.strip.split
		next if parts.last == "0.0"
		pairs << "#{parts[0]} #{parts[1]}"
		ref["#{parts[0]} #{parts[1]}"] = parts.last.to_f
	end
end

#reinitialize the output file
open "#{dataset}.out", "w" do |f|
	f.puts "#{sprintf "%-4s", "#s"}#{sprintf "%-4s", "t"}#{sprintf "%-4s", "i"}#{sprintf "%-14s", "ref"}#{deltas.map{|d| sprintf "%-14s", d}.join}"
end
#run reptitions for each delta
pairs.each do |pair|
	s, t = pair.split.map{|p| p.strip}
	puts pair
	repetitions.times do |i|
		vals = []
		deltas.each do |delta|
			output = `../../preach #{dataset}_#{delta}_#{i}.txt source#{s}.txt target#{t}.txt`
			vals << output.strip.split.last.to_f
		end
		open "#{dataset}.out", "a" do |f|
			f.puts "#{sprintf "%-4s", s}#{sprintf "%-4s", t}#{sprintf "%-4d", i}#{sprintf "%-14f", ref[pair].round(8)}#{vals.map{|v| sprintf("%-14f", val.round(8))}.join}"
		end
	end
end