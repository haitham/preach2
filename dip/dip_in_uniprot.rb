input, output = ARGV

open input do |fin|
	open output, "w" do |fout|
		fin.gets #ignore header line
		until (line = fin.gets).nil?
			next if line.strip.empty?
			p1, p2 = line.split[0..1]
			next unless p1.include? "uniprotkb:" and p2.include? "uniprotkb:"
			
			p1 = p1.split("uniprotkb:").last.split("|").first
			p2 = p2.split("uniprotkb:").last.split("|").first
			
			fout.puts "#{p1} \t\t #{p2}"
		end
	end
end