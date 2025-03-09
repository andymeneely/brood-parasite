require 'squib'
require_relative 'version'

data = Squib.csv file: 'data/assets.csv'
# id,cpu,qty,name,type,scan,broadcast,crack,script,child

def range_any(arr)
  result = []
  0.upto(arr.size) do |i|
    result << i unless arr[i].to_s.empty?
  end
  return result
end

Squib::Deck.new(cards: data.nrows) do
  use_layout file: 'layouts/assets.yml'
  background color: :white
  svg file: 'action_backdrop.svg'

  text str: data.name, layout: :name
  text str: data.type, layout: :type
  text str: data.cpu, layout: :cpu

  child_svg = data.child.map {|c| c.to_s.empty? ? nil : 'child.svg' }
  svg layout: :child, file: child_svg
  text layout: :child_text, str: data.child

  rect layout: :scan_box, range: range_any(data.scan)
  rect layout: :crack_box, range: range_any(data.crack)
  rect layout: :script_box, range: range_any(data.script)

  svg layout: :vuln_scan, file: 'icons.svg', range: range_any(data.scan)
  svg layout: :vuln_crack, file: 'icons.svg', range: range_any(data.crack)
  svg layout: :vuln_script, file: 'icons.svg', range: range_any(data.script)

  text str: data.scan, layout: :scan_text
  text str: data.crack, layout: :crack_text
  text str: data.script, layout: :script_text

  # svg layout: :action_broadcast,
  #     file: data.broadcast.map { |s| s == 'Y' ? 'icons.svg' : nil }

  # svg layout: :action_crack,
  #     file: data.crack.map { |s| s == 'Y' ? 'icons.svg' : nil }

  # svg layout: :action_script,
  #     file: data.script.map { |s| s == 'Y' ? 'icons.svg' : nil }


  # safe_zone
  cut_zone

  save_png prefix: 'asset_'

  save_pdf file: 'pnp_assets.pdf', trim: '0.125in'

  save_sheet prefix: 'sheet_assets_',
    trim: '0.125in',
    rows: 3, columns: 3

end


