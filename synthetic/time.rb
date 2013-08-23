dir = ARGV[0]
size = dir.split("/").last.split("-").first.to_i

open "#{dir}/time.out", "w" do |f|
	0.upto(size-1) do |s|
		0.upto(size-1) do |t|
			next if s == t
			puts `../stats #{dir}/network.txt #{dir}/node#{s}.txt #{dir}/node#{t}.txt`
			output = `echo -n (#{"`time -p ../preach #{dir}/network.txt #{dir}/node#{s}.txt #{dir}/node#{t}.txt`"})`
			time = output.split("real ").last.split(/\s+/).first
			f.puts "#{s}  #{t}  #{time.strip}"
			#f.puts "../preach #{dir}/network.txt #{dir}/node#{s}.txt #{dir}/node#{t}.txt"
		end
	end
end

