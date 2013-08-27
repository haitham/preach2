network, reach_file = ARGV

open reach_file do |fin|
	open reach_file.gsub(".out", ".final.out"), "w" do |fout|
		until (line = fin.gets).nil?
			source, target, prob = line.split
			unless prob =~ /bad/
				fout.puts line
				next
			end
			stat = `../stats #{network} #{source} #{target}`
			puts "#{source}  #{target}  #{stat.strip}"
			next if stat.split.size == 4
			output = `../preach #{network} #{source} #{target}`
			fout.puts "#{source}  #{target}  #{output.strip.split.last}"
		end
	end
end
