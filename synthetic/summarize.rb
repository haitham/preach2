datasets = ["barabasi", "erdos"]
sizes = ["40", "60", "80", "100"]

open "summary.out", "w" do |fout|
	fout.puts "#{sprintf "%-8s", "size"}#{datasets.map{|d| sprintf "%-14s", d}.join}"
	sizes.each do |size|
		fout.print sprintf("%-8d", size)
		datasets.each do |dataset|
			open Dir.glob("#{dataset}/#{size}-*/time.out").first do |f|
				count = 0
				total = 0.0
				until (line = f.gets).nil?
					count = count + 1
					total = total + line.split.last.to_f
				end
				fout.print sprintf("%-14f", total/count)
			end
		end
		fout.puts
	end
end