require 'squib'
require_relative 'version'

data = Squib.csv file: 'data/temp.csv'

# binding.irb
puts "rows: #{data.nrows}"

Squib::Deck.new(cards: data.nrows) do
  background color: :white
  use_layout file: 'layouts/actions.yml'

  # text str: data.name, layout: :name
  # text str: data.desc, layout: :desc

  safe_zone
  cut_zone

  save_png prefix: 'actions_'

  # save_pdf file: 'pnp_actions.pdf', trim: '0.125in'

  # save_sheet prefix: 'sheet_actions_',
  #   trim: '0.125in',
  #   rows: 3, columns: 3

end
