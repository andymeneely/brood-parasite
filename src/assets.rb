require 'squib'
require_relative 'version'

data = Squib.csv file: 'data/assets.csv'

Squib::Deck.new(cards: data.nrows, width: 825, height: 600) do
  background color: :white
  use_layout file: 'layouts/assets.yml'

  text str: data.name, layout: :name
  text str: data.desc, layout: :desc

  safe_zone
  cut_zone

  save_png prefix: 'asset_'

  save_pdf file: 'pnp_buffs.pdf', trim: '0.125in'

  save_sheet prefix: 'sheet_buffs_',
    trim: '0.125in',
    rows: 3, columns: 3

end
