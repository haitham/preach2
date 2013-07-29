datafile = ARGV[0]

open datafile do |fin|
	open datafile.gsub(".txt", ".dummy.txt"), "w" do |fout|
		until (line = fin.gets).nil?
			next if line.strip.empty?
			fout.puts "#{line.strip} \t 0.5"
		end
	end
end