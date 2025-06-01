require 'squib'
require_relative 'version'

data = Squib.csv file: 'data/cards.csv' do |h,v|
  if h == 'name'
    v.to_s.downcase.gsub(' ','_')
  elsif h == 'type' || h == 'type_prefix'
    v.to_s.downcase
  else
    v
  end
end

data.bots_text.each.with_index do |t, i|
  if data.bots_icon[i] == 'bots_vuln'
    data.bots_text[i] = "REQUIRES EXPLOIT. #{data.bots_text[i]}"
  end

  if data.bots_icon[i] == 'bots_action'
    data.bots_text[i] = "REQUIRES ASSET OR EXPLOIT. #{data.bots_text[i]}"
  end

  if data.bots_icon[i] == 'bots_chain'
    data.bots_text[i] = "REQUIRES ASSET & EXPLIOT. #{data.bots_text[i]}"
  end
end

def range_any(arr)
  result = []
  0.upto(arr.size) do |i|
    result << i unless arr[i].to_s.empty?
  end
  return result
end

def dot_svg(arr)
  arr.map do |f|
    f.to_s.empty? ? nil : "#{f}.svg"
  end
end

data['job_target_exploit_svg'] = data.job_target_exploit.map do |v|
  v == 'Y' ? 'job_target_exploit.svg' : nil
end

Squib::Deck.new(cards: data.nrows) do
  use_layout file: 'layouts/cards.yml'
  background color: :white
  svg file: 'card_master.svg'


  full_types = data.type_prefix.zip(data.type).map { |s| s.join(' ').strip }

  text str: full_types, layout: :type
  text str: data.name, layout: :name
  text str: data.cpu, layout: :cpu

  svg layout: :type_icon,  file: dot_svg(data.type)
  svg layout: :quick, file: dot_svg(data.quick_icon)
  svg layout: :bots,  file: dot_svg(data.bots_icon)
  svg layout: :dev,   file: dot_svg(data.dev_icon)
  svg layout: :job_target1,  file: data.job_target_exploit_svg

  text layout: :quick_text, str: data.quick_text
  text layout: :bots_text,  str: data.bots_text
  text layout: :ops_text,   str: data.ops
  text layout: :dev_text,   str: data.dev_text

  # safe_zone
  cut_zone

  # save_png prefix: 'cards_'

  save_pdf file: 'pnp_cards.pdf', trim: '0.125in'

  save_sheet prefix: 'sheet_cards_',
    trim: '0.125in',
    rows: 3, columns: 3

end

puts "Done!"