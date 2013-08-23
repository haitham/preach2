dir = ARGV[0]
size = dir.split("/").last.split("-").first.to_i

open "#{dir}/time.out", "w" do |f|
	0.upto(size-1) do |s|
		0.upto(size-1) do |t|
			next if s == t
			stat = `../stats #{dir}/network.txt #{dir}/node#{s}.txt #{dir}/node#{t}.txt`
			next if stat.split.size == 4
			puts "#{s}  #{t}  " + stat
			time = `(time -p ../preach #{dir}/network.txt #{dir}/node#{s}.txt #{dir}/node#{t}.txt) 2>&1 | grep real | tr -d '\n' | cut -d" " -f2`
			f.puts "#{s}  #{t}  #{time.strip}"
		end
	end
end

