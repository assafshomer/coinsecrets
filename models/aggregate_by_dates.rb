require 'csv'
require 'json'
require 'time'

path = '/home/assaf/ruby_projects/coinsecrets/data/foo.tsv'
data = CSV.read(path,col_sep: "\t")

play =  data[95..100]

# p play

days =  play.map{|l| l.each_with_index.map{|x,i| if i > 0 then x else Time.parse(x).strftime "%Y-%m-%d" end}}
p "***************"
p days
p "***************"

# days.inject([]){ |result, element| result + element }



