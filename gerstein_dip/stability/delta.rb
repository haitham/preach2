#example parameter: type1.txt or type_GSE42414_1.txt
datasets = ARGV
deltas = [0.05, 0.1, 0.15, 0.2, 0.25, 0.3]
repetitions = 20
datasets.each do |dataset|
	lines = []
	open dataset do |f|
		until (line = f.gets).nil?
			next if line.strip.empty?
			lines << line.split.map{|p| p.strip}
		end
	end

	deltas.each do |delta|
		repetitions.times do |i|
			open dataset.gsub(".txt", "_#{delta}_#{i}.txt"), "w" do |f|
				puts dataset.gsub(".txt", "_#{delta}_#{i}.txt")
				lines.each do |line|
					prob = line[2].to_f
					max = prob + delta > 1.0 ? 1.0 : prob + delta
					min = prob - delta < 0.0 ? 0.0 : prob - delta
					prob = min + rand * (max - min)
					f.puts "#{line[0]} #{line[2]} #{prob}"
				end
			end
		end
	end
end