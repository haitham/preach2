dir, output = ARGV
size = dir.split("/").last.split("-"),first.to_i

open output, "w" do |f|
	0.upto(size-1) do |s|
		0.upto(size-1) do |t|
			next if s == t
			puts "../preach #{dir}/network.txt node#{s}.txt node#{t}.txt"
			output = `../preach #{dir}/network.txt node#{s}.txt node#{t}.txt`
			f.puts "#{s}  #{t}  #{output.strip}"
			#f.puts "../preach #{network} #{source} #{target}"
		end
	end
end
