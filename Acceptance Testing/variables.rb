# Change the values of these variables to set employment statuses through the HEDAT event

module Prsn

TEST_DB = "C"  # Set to "B", "C", "D", or "F"
INTN_ID = "426410049"


FAST_PATH = "hedat"
EFFDT = "07012014"

EMPL_STAT = "TERM"
PSFT_ACTION_CD = "TER"
PSFT_REASON_CD = "390"
AARC_COMBINED = PSFT_ACTION_CD + PSFT_REASON_CD

PSFT_EMPL_STAT= "T"

PERMTEMP = nil #or "P"
EXEMPT_STAT = "N" #or "E"
HEALTH_INS_IND = "Y" #or "N"
HEALTH_INS_CC = "2" #"1"-"8" or "N"
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