require 'squib'
require 'irb'
require 'rake/clean'

# Add Rake's clean & clobber tasks
CLEAN.include('_output/*').exclude('_output/gitkeep.txt')

desc 'By default, just build the deck without extra options'
task default: [:buffs]

desc 'Build the buffs deck'
task(:buffs)     { load 'src/buffs.rb' }

