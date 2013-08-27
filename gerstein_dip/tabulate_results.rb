#works on reachability.typex.final.out files, tabulating the results, padding the missing cells with 0.0
files = ARGV
files.each do |file|
	sources, targets, probs = [], [], {}
	open file do |f|
		until (line = f.gets).nil?
			next if line.strip.empty?
			s, t, p = line.strip.split
			s = s.split("source").last.split(".").first
			t = t.split("target").last.split(".").first
			sources << s unless sources.include? s
			targets << t unless targets.include? t
			probs[s] ||= {}
			probs[s][t] = p
		end
	end
	open file.gsub(".final.out", ".table"), "w" do |f|
		f.puts "#{sprintf "%-14s", ""}#{targets.map{|t| sprintf "%-14s", t}.join}"
		sources.each do |s|
			f.puts "#{sprintf "%-14s", s}#{targets.map{|t| sprintf "%-14s", probs[s][t] || "0.0"}.join}"
		end
	end
end