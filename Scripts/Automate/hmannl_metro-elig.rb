# C:\Ruby193\bin\Scripts

# This script will run HMANNL and check ppt's metropass eligibility. It will also take Snagits.


require "rautomation"
require "win32/screenshot"
require "timeout"

wait_timeout = 15

#Set the information below:


	test_database = "C" # Set to "B", "C", "D", or "F"
	intn_id = "497810034"
	fast_path = "hmannl"   ###SET FASTPATH CD HERE
	effdt = nil    ###SET EFFECTIVE DATE HERE


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
############### Check to see if ppt is elig for metropass plan **********************

     hmannl_editor = RAutomation::Window.new :title => /#{fast_path}/
     hmannl_editor.send_keys 'm'
     hmannl_editor.send_keys :enter

     metropass_title = "Active Annual Enrollment - Metropass/Metroplus-Enrl"
     metropass = RAutomation::Window.new :title => /#{metropass_title}/
     
if metropass.exists?
       metropass.send_keys :down

     hmannl_editor.activate
     hmannl_editor.send_keys [:alt, 'v']

     #Overrideable edit will trigger
    
     hmannl_editor.send_keys :tab
     hmannl_editor.send_keys :tab
     hmannl_editor.send_keys :enter

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

     hmannl_editor.send_keys [:alt, 'v']
     sleep 5
     Win32::Screenshot::Take.of(:desktop).write("metropass_eligible.jpg")

else
     Win32::Screenshot::Take.of(:window, :title => /#{fast_path}/).write("hmannl.jpg")
end
     #while !hmannl_options.value.match(/Metropass/)
     #  hmannl_editor.send_keys :down
     #  status = Timeout::timeout(20)
     #end
     #Win32::Screenshot::Take.of(:window, :title => /#{fast_path}/).write("otherfolder\hmannl.jpg")

