typenames = {"1" => "Hyperdiploid",
"2" => "TCF3-PBX1",
"3" =>	"ETV6_RUNX1",
"4" => "MLL",
"5" => "Ph",
"6" => "Hypo",
"7" => "Other",
"8" => "T-ALL",
"_GSE42414_1" => "Control_HSC",
"_GSE42414_2" => "Control_lymphoid",
"_GSE42414_3" => "Control_myeloid"}
deltas = ["0.05", "0.1", "0.15", "0.2", "0.25", "0.3"]
datasets = ARGV

avg = {}
abs = {}
datasets.each do |dataset|
	open dataset do |f|
		values = deltas.map{|d| 0.0}
		abs_values = deltas.map{|d| 0.0}
		count = 0
		f.gets #skip header
		until (line = f.gets).nil?
			line.strip.split.last(deltas.size).each_with_index do |v, i|
				values[i] = values[i] + v.to_f
				abs_values[i] = abs_values[i] + v.to_f.abs
			end
			count = count + 1
		end
		avg[dataset.split("type").last.split(".out").first] = values.map{|v| v/count}
		abs[dataset.split("type").last.split(".out").first] = abs_values.map{|v| v/count}
	end
end

open "avg.out", "w" do |f|
	f.puts "#{sprintf "%-8s", "#delta"}#{avg.keys.map{|t| sprintf "%-18s", typenames[t]}.join}"
	deltas.each_with_index do |d, i|
		f.puts "#{sprintf "%-8s", d}#{avg.keys.map{|t| sprintf "%-18f", avg[t][i].round(12)}.join}"
	end
end

open "avg_abs.out", "w" do |f|
	f.puts "#{sprintf "%-8s", "#delta"}#{abs.keys.map{|t| sprintf "%-18s", typenames[t]}.join}"
	deltas.each_with_index do |d, i|
		f.puts "#{sprintf "%-8s", d}#{abs.keys.map{|t| sprintf "%-18f", abs[t][i].round(12)}.join}"
	end
end

