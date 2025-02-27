require 'squib'
require_relative 'version'

data = Squib.csv file: 'data/actions.csv'

Squib::Deck.new(cards: data.nrows) do
  background color: :white
  use_layout file: 'layouts/actions.yml'

  text str: data.name, layout: :name
  text str: data.desc, layout: :desc

  # type = {};
  # data['type'].each_with_index{ |t, i| (type[t] ||= []) << i}
  # text range: type['Thinker'],
  #      str: 'Only for Thinkers!',
  #      x:25, y: 500
  #
  child_svg = data.child.map {|c| c.to_s.empty? ? nil : 'child.svg' }
  # svg layout: children
  svg file: child_svg, layout: :child


  svg layout: :action_scan
  svg layout: :action_broadcast
  svg layout: :action_crack
  svg layout: :action_script




  safe_zone
  cut_zone

  save_png prefix: 'actions_'

  save_pdf file: 'pnp_actions.pdf', trim: '0.125in'

  save_sheet prefix: 'sheet_actions_',
    trim: '0.125in',
    rows: 3, columns: 3

end
