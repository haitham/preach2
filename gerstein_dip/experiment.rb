network, output = ARGV
sources = Dir.glob(network.gsub(".txt", "_source*.txt")).map{|file| file.split("source").last.split(".").first.to_i}.sort
targets = Dir.glob(network.gsub(".txt", "_target*.txt")).map{|file| file.split("target").last.split(".").first.to_i}.sort


open output, "w" do |f|
	sources.each do |source|
		targets.each do |target|
			puts "../preach #{network} #{network.gsub(".txt", "_source#{source}.txt")} #{network.gsub(".txt", "_target#{target}.txt")}"
			output = `../preach #{network} #{network.gsub(".txt", "_source#{source}.txt")} #{network.gsub(".txt", "_target#{target}.txt")}`
			f.puts output
		end
	end
end

