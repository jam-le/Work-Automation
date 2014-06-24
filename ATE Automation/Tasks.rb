require "rautomation"
require "win32/screenshot"
require "timeout"
require "ATE.rb"

def start
include ATE
  @subsystem = ATE::SUBSYSTEM
  @database = ATE::DATABASE

window =  RAutomation::Window.new(:title => /Advanced Table Editor/, adapter: :ms_uia)
puts "here" if window.exist?

select = window.list_box(id:"subsystem")
puts select.count
end
