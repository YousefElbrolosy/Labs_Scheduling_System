# Labs_Scheduling_System
In this project a scheduling system is implemented in Prolog to assign the weekly labs of a course to the available TAs

The following should be noted:
-Each lab should be assigned exactly one TA.
-Each TA has a teaching load (the number of labs they are required to teach per
week).
-Each TA should not be assigned more labs than their teaching load (but can get
less load).
-The number of slots assigned to each TA per day must not exceed a particular
specified number.

The project uses the following predicates:

a) week_schedule(WeekSlots,TAs,DayMax,WeekSched) such that: 
• WeekSlots is a list of 6 lists with each list representing a working day from
Saturday till Thursday. A list representing a day is composed of 5 numbers
representing the 5 slots in the day. The number at position i in a day list represents the number of parallel labs at slot i.

b) day_schedule(DaySlots,TAs,RemTAs,Assignment) such that:
• DaySlots is a list of 5 numbers representing the number of parallel labs in the
5 slots of the day.
• TAs and RemTAs are lists of TA structures.
• Assignment is a list of lists of TA names in TAs representing the assignment
of the day.
day_schedule/4 succeeds if Assignment is a possible day assignment given the
available DaySlots and list of course TAs, while RemTAs is the list of updated TA
2
structures after the day assignment.

c) max_slots_per_day(DaySched,Max) such that:
• DaySched is a day schedule showing the assignment of the TAs in every slot.
• Max is a number showing the maximum amount of labs a TA can be assigned
in a day.
max_slots_per_day/2 succeeds if no TA is assigned more than Max labs in DaySched.

d) slot_assignment(LabsNum,TAs,RemTAs,Assignment) such that:
• LabsNum is a number representing the amount of parallel labs in this slot.
• TAs is a list of TAs structures.
• RemTAs is the updated list of TAs structures after the assignment to this slot.
• Assignment is a list of the names of TAs in TAs assigned to this slot.
slot_assignment/4 succeeds if Assignment is a possible assignment to a single
slot with LabsNum labs and RemTAs is the list of modified TAs after the assignment.

e) ta_slot_assignment(TAs,RemTAs,Name) such that:
• TAs and RemTAs are lists of TA structures
• Name is a name of a TA in TAs.
ta_slot_assignment/3 succeeds if RemTAs is the list of TA structures resulting
from updating the load of TA Name in TAs.

