require 'squib'

Squib::Deck.new(cards: 2, width: 300*8.0, height: 300*10.5) do

  svg file: 'board.svg',
      width: 16 * 300,
      height: :scale,
      x: [-150, -2000],
      y: 75

  save_png prefix: 'board_'

  save_pdf file: 'board.pdf',
           width: 8.5 * 300, height: 11 * 300,
           crop_marks: false

end