# C:\Ruby193\bin\Scripts

# This script will run HEDAT and change ppt's location code. It will also take Snagits.


require "rautomation"
require "win32/screenshot"
require "timeout"

wait_timeout = 15

#Set the information below. Put everything in between double quotes.


	test_database = "C" # Set to "B", "C", "D", or "F"
	intn_id = "810072"
	fast_path = "hedat"   ###SET FASTPATH CD HERE
	effdt = nil           ###SET EFFECTIVE DATE HERE

###### Set the Metropass Location Code Here:

metro_cd = "EP-MN-L6RE"
mail_location_flag = "i" #set to "i" for "Work Location" or "x" for "Home Address"
mail_location_flag.downcase!

#######################################################################This script opens a ppt in GUI

window =  RAutomation::Window.new :title => "TBA Clients - Acceptance"

puts window.text if window.exist?

window.send_keys :page_up

case test_database
when "B"
  trans_id = "(W358)"
  window.send_keys :down
  window.send_keys :down
  window.send_keys :enter

when "C"
  trans_id = "(W388)"
  window.send_keys :down
  window.send_keys :down
  window.send_keys :down
  window.send_keys :down
  window.send_keys :down
  window.send_keys :enter

when "D"
  trans_id = "(W3B8)"
  window.send_keys :down
  window.send_keys :down
  window.send_keys :down
  window.send_keys :down
  window.send_keys :down
  window.send_keys :down
  window.send_keys :down
  window.send_keys :down
  window.send_keys :enter

when "F"
  trans_id = "(W3Q8)"
  window.send_keys :down
  window.send_keys :down
  window.send_keys :down
  window.send_keys :down
  window.send_keys :down
  window.send_keys :down
  window.send_keys :down
  window.send_keys :down
  window.send_keys :down
  window.send_keys :down
  window.send_keys :down
  window.send_keys :enter
else
"Error: The code does not recognize which database you want to use."
end

puts trans_id

trans = RAutomation::Window.new :title => /00567 - U.S. Bank/
trans.activate
trans.send_keys :enter

person_selector = RAutomation::Window.new :title => "Person Selector"
person_selector.send_keys [:left_alt, 'a']
#sleep 1

intn_id_win = RAutomation::Window.new :title => "Search by Alternate ID Field"
intn_id_win.text_field(:class => "Edit", :index => 0).set "#{intn_id}"
intn_id_win.send_keys :enter
puts "Internal Id: " << intn_id

#######################################################################This script goes to event selector

menu_win = RAutomation::Window.new :title => /#{trans_id}/
menu_win.send_keys :enter if menu_win.exist?

event_selector = RAutomation::Window.new :title => "Event Selector"
event_selector.activate
event_selector.text_field(:class => "Edit", :index => 0).set "#{fast_path}"
event_selector.send_keys :tab
event_selector.send_keys :tab
event_selector.text_field(:class => "Edit", :index => 1).set "#{effdt}" if !effdt.nil?
event_selector.send_keys :enter

puts "FastPath: #{fast_path}"
puts "Effective Date: #{effdt}"

fast_path.upcase!
     event_editor = RAutomation::Window.new :title => /#{fast_path}/
     event_editor.send_keys 'l'
     event_editor.send_keys :enter




enter_info = RAutomation::Window.new :title => /HR Active Data Maintenance/
enter_info.activate
     enter_info.send_keys :tab
     enter_info.send_keys 'i' if mail_location_flag.match("i")
     enter_info.send_keys 'x' if mail_location_flag.match("x")
     enter_info.send_keys :tab
     enter_info.send_keys :tab
     enter_info.send_keys :delete
     enter_info.text_field(:class => "Edit", :index => 5).set "XX"

     event_editor.activate
     event_editor.send_keys [:alt, 'v']
     
###################################################### If overrideable edit triggers... ################
     confirmation = RAutomation::Window.new :title => "Confirmation"
unless confirmation.exists?     

     event_editor.send_keys :tab
     event_editor.send_keys :tab
     event_editor.send_keys :enter

     edit_summary = RAutomation::Window.new :title => "Edit Summary"
     edit_summary.send_keys :tab
     edit_summary.send_keys :right
     edit_summary.send_keys [:alt, 'd']
     
     edit_detail = RAutomation::Window.new :title => "Edit Detail"

     if edit_detail.exists?
       edit_detail.button(:value => "&Close").click
       edit_summary.send_keys :down
       edit_summary.send_keys :enter
       #edit_summary.send_keys [:alt, 'v']
       edit_summary.send_keys [:alt, 'o']

     else
       edit_summary.send_keys :enter
     end

     event_editor.send_keys [:alt, 'v']
     sleep 5
     Win32::Screenshot::Take.of(:desktop).write("location code updated.jpg")
end

confirmation.send_key :enter
Win32::Screenshot::Take.of(:desktop).write("location code updated.jpg")
#else
#     Win32::Screenshot::Take.of(:window, :title => /#{fast_path}/).write("hmannl.jpg")
#end