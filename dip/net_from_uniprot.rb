require 'uri'
require 'net/http'
require 'active_support/core_ext/hash'

input, output = ARGV

open input do |fin|
	open output, "w" do |fout|
		count = 0
		fin.gets #ignore header line
		until (line = fin.gets).nil?
			count = count + 1
			puts count
			next if line.strip.empty?
			p1, p2 = line.split[0..1]
			next unless p1.include? "uniprotkb:" and p2.include? "uniprotkb:"
			
			p1 = p1.split("uniprotkb:").last.split("|").first
			xml = Net::HTTP.get URI.parse("http://www.uniprot.org/uniprot/#{p1}.xml")
			next if xml.strip.empty?
			hash = Hash.from_xml xml
			gene = hash["uniprot"]["entry"]["gene"]
			next if gene.nil?
			p1name = (gene.class == Array) ? gene.map{|g| g["name"]}.flatten : gene["name"]
			p1name = p1name.join("|") if p1name.class == Array
			
			p2 = p2.split("uniprotkb:").last.split("|").first
			xml = Net::HTTP.get URI.parse("http://www.uniprot.org/uniprot/#{p2}.xml")
			next if xml.strip.empty?
			hash = Hash.from_xml xml
			gene = hash["uniprot"]["entry"]["gene"]
			next if gene.nil?
			p2name = (gene.class == Array) ? gene.map{|g| g["name"]}.flatten : gene["name"]
			p2name = p2name.join("|") if p2name.class == Array
			
			fout.puts "#{p1} \t\t #{p2} \t\t #{p1name} \t\t #{p2name}"
		end
	end
end