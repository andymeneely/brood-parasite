# require 'squib'
require_relative '../../squib/lib/squib'
require_relative 'version'

data = Squib.csv file: 'data/actions.csv'

Squib::Deck.new(cards: data.nrows) do
  use_layout file: 'layouts/actions.yml'

  background color: :white
  svg file: 'action_backdrop.svg'

  text str: data.name, layout: :name
  text str: data.type, layout: :type
  text str: data.cpu, layout: :cpu

  text(layout: :time_str,
       str: data.time.map { |t| t > 0 ? "#{t} :time:" : ''}) do |embed|
    embed.svg key: ':time:', layout: :time_str_embed
  end

  text str: data.desc, layout: :desc do |embed|
    embed.svg key: ':scan:', layout: :scan_embed_icon
    embed.svg key: ':broadcast:', layout: :broadcast_embed_icon
    embed.svg key: ':crack:', layout: :crack_embed_icon
    embed.svg key: ':script:', layout: :script_embed_icon
    embed.svg key: ':time:', layout: :time_embed_icon
  end



  child_svg = data.child.map {|c| c.to_s.empty? ? nil : 'child.svg' }
  svg layout: :child, file: child_svg
  text layout: :child_text, str: data.child

  svg layout: :action_scan,
      file: data.scan.map { |s| s == 'Y' ? 'icons.svg' : nil }

  svg layout: :action_broadcast,
      file: data.broadcast.map { |s| s == 'Y' ? 'icons.svg' : nil }

  svg layout: :action_crack,
      file: data.crack.map { |s| s == 'Y' ? 'icons.svg' : nil }

  svg layout: :action_script,
      file: data.script.map { |s| s == 'Y' ? 'icons.svg' : nil }

  safe_zone
  cut_zone

  save_png prefix: 'actions_'

  save_pdf file: 'pnp_actions.pdf', trim: '0.125in'

  save_sheet prefix: 'sheet_actions_',
    trim: '0.125in',
    rows: 3, columns: 3

end
