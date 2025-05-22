require 'squib'
require_relative 'version'

data = Squib.csv file: 'data/rigs.csv' do |h,v|
  if h == 'name'
    v.to_s.downcase.gsub(' ','_')
  else
    v
  end
end

Squib::Deck.new(cards: data.nrows) do
  use_layout file: 'layouts/rigs.yml'
  background color: :white
  svg file: 'rig.svg'

  text str: data.name, layout: :name
  text str: data.type, layout: :type
  text str: data.desc, layout: :desc
  text str: data.cpu, layout: :cpu
  text str: data.jobs, layout: :jobs
  text str: data.devs, layout: :devs

  # safe_zone
  cut_zone

  # save_png prefix: 'cards_'

  # save_pdf file: 'pnp_rigs.pdf', trim: '0.125in'

  save_sheet prefix: 'sheet_rigs_',
    trim: '0.125in',
    rows: 3, columns: 3

end

puts "Done!"