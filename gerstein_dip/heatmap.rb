table = ARGV[0]
row_labels, column_labels = "", ""

open("matlab/row_labels.txt"){|f| row_labels = "{#{f.gets}}"}
open("matlab/column_labels.txt"){|f| column_labels = "{#{f.gets}}"}
ordered_sources = row_labels.gsub(/\{|\}|\'/, "").strip.split
ordered_targets = column_labels.gsub(/\{|\}|\'/, "").strip.split

probs = {}
open table do |f|
	targets = f.gets.strip.split
	ordered_sources.size.times do
		parts = f.gets.strip.split
		s = parts[0]
		probs[s] = {}
		parts[1..targets.size].each_with_index{|p, i| probs[s][targets[i]] = p}
	end
end

matrix = ""
ordered_sources.each do |s|
	matrix = "#{matrix}\n #{ordered_targets.map{|t| probs[s][t] || "0.0"}.join " "}"
end
matrix = "[#{matrix}]"

open "matlab/#{table.gsub(".table", ".m").gsub("reachability.", "heatmap_")}", "w" do |fout|
	fout.puts "RowLabels = #{row_labels}"
	fout.puts "ColumnLabels = #{column_labels}"
	fout.puts "Matrix = #{matrix}"
	fout.puts "HM = HeatMap(Matrix, 'RowLabels', RowLabels, 'ColumnLabels', ColumnLabels, 'Symmetric', false, 'Standardize', 'none')"
end