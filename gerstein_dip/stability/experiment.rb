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
	f.puts "#{sprintf "%-4s", "#s"}#{sprintf "%-4s", "t"}#{deltas.map{|d| sprintf "%-14s", d}.join}"
end
#run reptitions for each delta
pairs.each do |pair|
	s, t = pair.split.map{|p| p.strip}
	open "#{dataset}.out", "a" do |f|
		f.print "#{sprintf "%-4s", s}#{sprintf "%-4s", t}"
	end
	deltas.each do |delta|
		print "#{pair} d#{delta}: #{ref[pair]}=>"
		agg = 0.0
		repetitions.times do |i|
			output = `../../preach #{dataset}_#{delta}_#{i}.txt source#{s}.txt target#{t}.txt`
			agg = agg + output.strip.split.last.to_f
		end
		open "#{dataset}.out", "a" do |f|
			f.print sprintf("%-14f", (ref[pair] - agg/repetitions).round(8))
		end
		puts "#{agg/repetitions}(#{(ref[pair] - agg/repetitions).round(8)})"
	end
	open "#{dataset}.out", "a" do |f|
		f.puts
	end
end