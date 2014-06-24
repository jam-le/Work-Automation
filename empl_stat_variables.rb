# To set employment statuses through the HEDAT event, change the values of these variables

module Empl

FAST_PATH = "hedat"
EFFDT = "07012014"
EMPL_STAT = "TERM"
PSFT_ACTION_CD = "TER"
PSFT_REASON_CD = "390"
AARC_COMBINED = PSFT_ACTION_CD + PSFT_REASON_CD

PSFT_EMPL_STAT= "T"

PERMTEMP = "T" #or "P"
EXEMPT_STAT = "N" #or "E"
HEALTH_INS_IND = "Y" #or "N"
HEALTH_INS_CC = "1" #"1"-"8" or "N"
PAYGROUP = nil
UNION = nil
PAYGRADE = nil
FTPT = "P" #fulltime/parttime
YTR_ELIG = nil
ORGN_HIR = nil
LAST_HIR = nil
BNFT_SERVICE = nil
REG_REG = nil

def test
puts FAST_PATH
puts EXEMPT_STAT
end
end