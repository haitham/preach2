gerstein, dip = ARGV

dip_edges = {}
open dip do |f|
	until (line = f.gets).nil?
		next if line.strip.empty?
		p1names, p2names = line.split[0..1].map{|name| name.split("|")}
		p1names.each do |p1|
			p2names.each do |p2|
				dip_edges[p1] ||= {}
				dip_edges[p2] ||= {}
				dip_edges[p1][p2] = true
				dip_edges[p2][p1] = true
			end
		end
	end
end

open gerstein do |fin|
	open gerstein.gsub(".txt", ".dip.txt"), "w" do |fout|
		until (line = fin.gets).nil?
			next if line.strip.empty?
			s, t = line.split[0..1]
			fout.puts line if dip_edges[s] and dip_edges[s][t]
		end
	end
end
