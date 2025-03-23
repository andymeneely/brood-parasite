require 'squib'
require_relative 'version'

data = Squib.csv file: 'data/cards.csv' do |h,v|
  if h == 'name'
    v.to_s.downcase.gsub(' ','_')
  elsif h == 'type'
    v.to_s.downcase
  else
    v
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

Squib::Deck.new(cards: data.nrows) do
  use_layout file: 'layouts/cards.yml'
  background color: :white
  svg file: 'card_master.svg'

  text str: data.name, layout: :name
  text str: data.type, layout: :type
  text str: data.cpu, layout: :cpu

  svg layout: :quick, file: dot_svg(data.quick_icon)
  svg layout: :bots,  file: dot_svg(data.bots_icon)
  svg layout: :dev,   file: dot_svg(data.dev_icon)

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


