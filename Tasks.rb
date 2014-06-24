# C:\Ruby193\bin\Scripts

# start: This method will start GUI with selected database.
# set_emplstat: 

require "rautomation"
require "win32/screenshot"
require "timeout"

wait_timeout = 15


def start(test_database, intn_id)

	@test_database = test_database # Set to "B", "C", "D", or "F"
	@intn_id = intn_id

#######################################################################This script opens a ppt in GUI



window =  RAutomation::Window.new :title => "TBA Clients - Acceptance"

puts window.text if window.exist?

window.send_keys :page_up

case @test_database
when "B"
  $trans_id = "(W358)"
  window.send_keys :down
  window.send_keys :down
  window.send_keys :enter

when "C"
  $trans_id = "(W388)"
  window.send_keys :down
  window.send_keys :down
  window.send_keys :down
  window.send_keys :down
  window.send_keys :down
  window.send_keys :enter

when "D"
  $trans_id = "(W3B8)"
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
  $trans_id = "(W3Q8)"
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

puts $trans_id

trans = RAutomation::Window.new :title => /00567 - U.S. Bank/
trans.activate
trans.send_keys :enter

person_selector = RAutomation::Window.new :title => "Person Selector"
person_selector.send_keys [:left_alt, 'a']
#sleep 1

intn_id_win = RAutomation::Window.new :title => "Search by Alternate ID Field"
intn_id_win.text_field(:class => "Edit", :index => 0).set "#{@intn_id}"
intn_id_win.send_keys :enter
puts "Internal Id: " << @intn_id

end

########### Set Empl Stat #######################################################################################################

def set_emplstat
require "empl_stat_variables.rb"
@fast_path = fast_path
@effdt = "07012014"
@empl_stat = "TERM"
@PSFT_Action_Cd = "TER"
@PSFT_Reason_Cd = "390"
@AARC_Combined = @PSFT_Action_Cd + @PSFT_Reason_Cd

@PSFT_Empl_Stat= "T"

@PermTemp = "T" #or "P"
@exempt_stat = "N" #or "E"
@health_ins_ind = "Y" #or "N"
@health_ins_cc = "1" #"1"-"8" or "N"
@paygroup = nil
@union = nil
@paygrade =nil
@ftpt = "P" #fulltime/parttime
@YTR_elig = nil
@orgn_hir = nil
@last_hir = nil
@bnft_service = nil
@reg_reg = nil




menu_win = RAutomation::Window.new :title => /xxx/
#puts "#{$trans_id}"
menu_win.send_keys :enter if menu_win.exist?

event_selector = RAutomation::Window.new :title => "Event Selector"
event_selector.activate
event_selector.text_field(:class => "Edit", :index => 0).set "#{@fast_path}"
event_selector.text_field(:class => "Edit", :index => 1).set "#{@effdt}" if !@effdt.nil?
event_selector.send_keys :enter

puts "FastPath: #{@fast_path}"
puts "Effective Date: #{@effdt}"

@fast_path.upcase!
     event_editor = RAutomation::Window.new :title => /#{@fast_path}/
     event_editor.send_keys :down
     event_editor.send_keys :enter

enter_info = RAutomation::Window.new :title => /HR Active Data Maintenance/
enter_info.activate

employmentstat = enter_info.text_field(:class => "Edit", :index =>0)

     while !employmentstat.value.match(/#{@empl_stat}/)
	enter_info.send_keys :down
     end
     if employmentstat.value.match(/#{@empl_stat}/)
        enter_info.send_keys :enter
     end

     enter_info.text_field(:class => "Edit", :index => 1).set "#{@effdt}" unless @effdt.nil?
     enter_info.send_keys :tab


########THIS ONE WORKS
        enter_info.send_keys :f4
     enter_info.text_field(:class => "Edit", :index => 2).set "#{@PSFT_Action_Cd}"
        enter_info.send_keys :f4
        enter_info.send_keys [:control, 'x']
        enter_info.send_keys [:control, 'v']
        enter_info.send_keys :tab
        enter_info.send_keys :tab
##########
     enter_info.send_keys :f4
     enter_info.text_field(:class => "Edit", :index => 4).set "#{@PSFT_Reason_Cd}"
        enter_info.send_keys :f4
        enter_info.send_keys [:control, 'x']
        enter_info.send_keys [:control, 'v']
        enter_info.send_keys :tab
        enter_info.send_keys :tab
enter_info.activate
     enter_info.send_keys :f4
     aarc = enter_info.text_field(:class => "Edit", :index => 6).set "#{@AARC_Combined}"
        enter_info.send_keys :f4
        enter_info.send_keys [:control, 'x']
        enter_info.send_keys [:control, 'v']
        enter_info.send_keys :tab
        enter_info.send_keys :tab
enter_info.activate
     enter_info.text_field(:class => "Edit", :index => 8).set "#{@PermTemp}" unless @PermTemp.nil? 
        enter_info.send_keys :f4
        enter_info.send_keys [:control, 'x']
        enter_info.send_keys [:control, 'v']
     enter_info.send_keys :tab
     enter_info.text_field(:class => "Edit", :index => 9).set "#{@effdt}" unless @PermTemp.nil?

event_editor.activate
event_editor.send_keys [:alt, 'v']


end