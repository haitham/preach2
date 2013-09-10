input = ARGV[0]
grayscale = ARGV[1] == "grayscale"

row_labels, column_labels = "", ""
matrix = ""
graymap = ""
open input do |fin|
	column_labels = "{#{fin.gets.strip.split.map{|l| "'#{l}'"}.join " "}}"
	row_counter = 0
	until (line = fin.gets).nil?
		row_counter = row_counter + 1
		parts = line.strip.split.map{|p| p.strip}
		row_labels = "#{row_labels} '#{parts[0]}'"
		matrix = "#{matrix}\n#{parts[1..parts.size-1].join " "}"
	end
	row_counter.times do |i|
		color_row = 3.times.map{1.0 - i.to_f/row_counter.to_f}.join(" ")
		graymap = "#{graymap}\n#{color_row}"
	end
	row_labels = "{#{row_labels}}"
	matrix = "[#{matrix}]"
	graymap = "[#{graymap}]"
end

open "matlab/#{input.gsub(".table", ".m").gsub("reachability.", "cluster_#{"gray_" if grayscale}")}", "w" do |fout|
	fout.puts "RowLabels = #{row_labels}"
	fout.puts "ColumnLabels = #{column_labels}"
	fout.puts "Matrix = #{matrix}"
	if grayscale
		fout.puts "ColorMap = #{graymap}"
		fout.puts "CG = clustergram(Matrix, 'RowLabels', RowLabels, 'ColumnLabels', ColumnLabels, 'Symmetric', false, 'ColorMap', ColorMap, 'Standardize', 'none')"
	else
		fout.puts "CG = clustergram(Matrix, 'RowLabels', RowLabels, 'ColumnLabels', ColumnLabels, 'Symmetric', false, 'Standardize', 'none')"
	end
end
