dir = ARGV[0]
size = ARGV[1].to_i
nets = Dir.glob "#{dir}/#{dir}*_#{size}.txt"

open "#{dir}/time_#{size}.out", "w" do |f|
	nets.each do |net|
		0.upto(size-1) do |s|
			0.upto(size-1) do |t|
				next if s == t
				stat = `../stats #{net} #{dir}/node#{s}.txt #{dir}/node#{t}.txt`
				next if stat.split.size == 4
				puts "#{s}  #{t}  " + stat
				time = `(time -p ../preach #{net} #{dir}/node#{s}.txt #{dir}/node#{t}.txt) 2>&1 | grep real | tr -d '\n' | cut -d" " -f2`
				f.puts "#{s}  #{t}  #{time.strip}"
			end
		end
	end
end
