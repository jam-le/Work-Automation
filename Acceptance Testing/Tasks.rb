# C:\Ruby193\bin\Scripts

# start: This method will start GUI with selected database.
# set_emplstat: 

require "rautomation"
require "win32/screenshot"
require "timeout"
require "variables.rb"

wait_timeout = 15


def start
include Prsn
	@test_database = Prsn::TEST_DB
	@intn_id = Prsn::INTN_ID

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

include Prsn
@fast_path = Prsn::FAST_PATH
@effdt = Prsn::EFFDT
@empl_stat = Prsn::EMPL_STAT
@PSFT_Action_Cd = Prsn::PSFT_ACTION_CD
@PSFT_Reason_Cd = Prsn::PSFT_REASON_CD
@AARC_Combined = @PSFT_Action_Cd + @PSFT_Reason_Cd

@PSFT_Empl_Stat= Prsn::PSFT_EMPL_STAT

@PermTemp = Prsn::PERMTEMP
@exempt_stat = Prsn::EXEMPT_STAT
@health_ins_ind = Prsn::HEALTH_INS_IND
@health_ins_cc = Prsn::HEALTH_INS_CC
@paygroup = Prsn::PAYGROUP
@union = Prsn::UNION
@paygrade = Prsn::PAYGRADE
@ftpt = Prsn::FTPT
@YTR_elig = Prsn::YTR_ELIG
@orgn_hir = Prsn::ORGN_HIR
@last_hir = Prsn::LAST_HIR
@bnft_service = Prsn::BNFT_SERVICE
@reg_reg = Prsn::REG_REG




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


unless @empl_stat.nil?
employmentstat = enter_info.text_field(:class => "Edit", :index =>0).set "#{@empl_stat}"
        enter_info.send_keys :f4
        enter_info.send_keys [:control, 'x']
        enter_info.send_keys [:control, 'v']
        enter_info.send_keys :tab
        enter_info.send_keys :tab

     enter_info.text_field(:class => "Edit", :index => 1).set "#{@effdt}" unless @effdt.nil?
     enter_info.send_keys :tab
end

unless @PSFT_Action_Cd.nil?
     enter_info.text_field(:class => "Edit", :index => 2).set "#{@PSFT_Action_Cd}"
        enter_info.send_keys :f4
        enter_info.send_keys [:control, 'x']
        enter_info.send_keys [:control, 'v']
        enter_info.send_keys :tab
        enter_info.send_keys :tab
end

unless @PSFT_Reason_Cd.nil?
     enter_info.text_field(:class => "Edit", :index => 4).set "#{@PSFT_Reason_Cd}"
        enter_info.send_keys :f4
        enter_info.send_keys [:control, 'x']
        enter_info.send_keys [:control, 'v']
        enter_info.send_keys :tab
        enter_info.send_keys :tab
end

enter_info.send_keys :page_down

unless @AARC_Combined.nil?
     aarc = enter_info.text_field(:class => "Edit", :index => 6).set "#{@AARC_Combined}"
        enter_info.send_keys :f4
        enter_info.send_keys [:control, 'x']
        enter_info.send_keys [:control, 'v']
        enter_info.send_keys :tab
        enter_info.send_keys :tab
end

unless @PermTemp.nil?
     enter_info.text_field(:class => "Edit", :index => 8).set "#{@PermTemp}"
        enter_info.send_keys :f4
        enter_info.send_keys [:control, 'x']
        enter_info.send_keys [:control, 'v']
     enter_info.send_keys :tab
     enter_info.text_field(:class => "Edit", :index => 9).set "#{@effdt}"
end

unless @exempt_stat.nil?
     enter_info.text_field(:class => "Edit", :index => 10).set "#{@exempt_stat}"
        enter_info.send_keys :f4
        enter_info.send_keys [:control, 'x']
        enter_info.send_keys [:control, 'v']
     enter_info.send_keys :tab
     enter_info.text_field(:class => "Edit", :index => 11).set "#{@effdt}"
end

enter_info.send_keys :page_down

unless @health_ins_ind.nil?
     enter_info.text_field(:class => "Edit", :index => 12).set "#{@health_ins_ind}"
        enter_info.send_keys :f4
        enter_info.send_keys [:control, 'x']
        enter_info.send_keys [:control, 'v']
     enter_info.send_keys :tab
     enter_info.text_field(:class => "Edit", :index => 13).set "#{@effdt}"
end

enter_info.send_keys :page_down

unless @health_ins_cc.nil?
     enter_info.text_field(:class => "Edit", :index => 14).set "#{@health_ins_cc}"
        enter_info.send_keys :f4
        enter_info.send_keys [:control, 'x']
        enter_info.send_keys [:control, 'v']
     enter_info.send_keys :tab
     enter_info.text_field(:class => "Edit", :index => 15).set "#{@effdt}"
end

unless @paygroup.nil?
     enter_info.text_field(:class => "Edit", :index => 16).set "#{@paygroup}"
        enter_info.send_keys :f4
        enter_info.send_keys [:control, 'x']
        enter_info.send_keys [:control, 'v']
     enter_info.send_keys :tab
     enter_info.text_field(:class => "Edit", :index => 17).set "#{@effdt}"
end

unless @union.nil?
     enter_info.text_field(:class => "Edit", :index => 18).set "#{@union}"
        enter_info.send_keys :f4
        enter_info.send_keys [:control, 'x']
        enter_info.send_keys [:control, 'v']
     enter_info.send_keys :tab
     enter_info.text_field(:class => "Edit", :index => 19).set "#{@effdt}"
end

unless @paygrade.nil?
     enter_info.text_field(:class => "Edit", :index => 20).set "#{@paygrade}"
        enter_info.send_keys :f4
        enter_info.send_keys [:control, 'x']
        enter_info.send_keys [:control, 'v']
     enter_info.send_keys :tab
     enter_info.text_field(:class => "Edit", :index => 21).set "#{@effdt}"
end

unless @ftpt.nil?
     enter_info.text_field(:class => "Edit", :index => 22).set "#{@ftpt}"
        enter_info.send_keys :f4
        enter_info.send_keys [:control, 'x']
        enter_info.send_keys [:control, 'v']
     enter_info.send_keys :tab
     enter_info.text_field(:class => "Edit", :index => 23).set "#{@effdt}"
end

enter_info.send_keys :page_down

unless @YTR_elig.nil?
     enter_info.text_field(:class => "Edit", :index => 24).set "#{@YTR_elig}"
        enter_info.send_keys :f4
        enter_info.send_keys [:control, 'x']
        enter_info.send_keys [:control, 'v']
     enter_info.send_keys :tab
     enter_info.text_field(:class => "Edit", :index => 25).set "#{@effdt}"
end

unless @orgn_hir.nil?
     enter_info.text_field(:class => "Edit", :index => 26).set "#{@orgn_hir}"
        enter_info.send_keys :f4
        enter_info.send_keys [:control, 'x']
        enter_info.send_keys [:control, 'v']
     enter_info.send_keys :tab
     enter_info.text_field(:class => "Edit", :index => 27).set "#{@effdt}"
end

unless @last_hir.nil?
     enter_info.text_field(:class => "Edit", :index => 28).set "#{@last_hir}"
        enter_info.send_keys :f4
        enter_info.send_keys [:control, 'x']
        enter_info.send_keys [:control, 'v']
     enter_info.send_keys :tab
     enter_info.text_field(:class => "Edit", :index => 29).set "#{@effdt}"
end

enter_info.send_keys :page_down
enter_info.send_keys :page_down

unless @bnft_service.nil?
     enter_info.text_field(:class => "Edit", :index => 30).set "#{@bnft_service}"
        enter_info.send_keys :f4
        enter_info.send_keys [:control, 'x']
        enter_info.send_keys [:control, 'v']
     enter_info.send_keys :tab
     enter_info.text_field(:class => "Edit", :index => 31).set "#{@effdt}"
end

unless @reg_reg.nil?
     enter_info.text_field(:class => "Edit", :index => 32).set "#{@reg_reg}"
        enter_info.send_keys :f4
        enter_info.send_keys [:control, 'x']
        enter_info.send_keys [:control, 'v']
     enter_info.send_keys :tab
     enter_info.text_field(:class => "Edit", :index => 33).set "#{@effdt}"
end

unless @PSFT_Empl_Stat.nil?
     enter_info.text_field(:class => "Edit", :index => 34).set "#{@PSFT_Empl_Stat}"
        enter_info.send_keys :f4
        enter_info.send_keys [:control, 'x']
        enter_info.send_keys [:control, 'v']
     enter_info.send_keys :tab
     enter_info.text_field(:class => "Edit", :index => 35).set "#{@effdt}"
end

event_editor.activate
event_editor.send_keys [:alt, 'v']


end