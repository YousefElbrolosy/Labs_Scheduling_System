% Start of ta_slot_assignment/3
% base case of ta_slot_assignment/3

ta_slot_assignment1([],[],_).

ta_slot_assignment1([ta(Name,Load)|T],[ta(Name,NewLoad)|T1],Name):- Load>0,
																NewLoad is Load-1,
																ta_slot_assignment1(T,T1,Name).
																
ta_slot_assignment1([ta(Name,Load)|T],[ta(Name,Load)|T1],Y):-  
															Y\=Name ,
															ta_slot_assignment1(T,T1,Y).

% End of ta_slot_assignment/3











% part (e)

ta_slot_assignment([],[],_).

ta_slot_assignment([ta(Name,Y)|TAs2],[ta(Name,Y1)|TAs2],Name):-
											Y \= 0,
											Y1 is Y-1,
											ta_slot_assignment(TAs2,TAs2,Name).
ta_slot_assignment([ta(X,Y)|TAs2],[ta(X,Y)|TAs3],Name):-	
											X\= Name,
											ta_slot_assignment(TAs2,TAs3,Name).
											
	/*										
ta_slot_assignment3([],[],_).

ta_slot_assignment3([ta(_,Y)|TAs2],[H1|TAs2],Name):-
											Y \= 0,
											member(ta(Name,Load),[H|TAs2]),
											NewLoad is Load-1,
											H1 = ta(Name,NewLoad),
											ta_slot_assignment3(TAs2,TAs2,Name).
ta_slot_assignment3([ta(X,Y)|TAs2],[ta(X,Y)|TAs3],Name):-	
											\+ member(ta(Name,Load),[H|TAs2]),
											ta_slot_assignment3(TAs2,TAs3,Name).
	
% e with no recursion
ta_slot_assignment2(TAs,RemTAs,Name):-
									member(ta(Name,Load),TAs),
									select(ta(Name,Load),TAs,NewTAs),
									NewLoad is Load-1,
									H1 = ta(Name,NewLoad),
									append([H1],NewTAs,RemTAs).
									
	
	
	
	
	
	
	
	
	
ta_slot_assignment2(TAs,[ta(Name,Load)|TAs],d).
ta_slot_assignment2([ta(H1,Load)|T1],[H2|T2],Name):-
										H1 = Name,
										NewLoad is Load - 1,
										H2 = ta(Name,NewLoad),
										ta_slot_assignment2(T1,[H2|T1],d).
ta_slot_assignment2([ta(H1,_)|T1],[_|T2],Name):-
													H1 \= Name,
													ta_slot_assignment2(T1,T2,Name).
										
																		
									



% part d baskat

slot_assignment(0,NewTAs,NewTAs,[]).
slot_assignment(X,T,[H|T1],[Name|T2]):- 
										X>=0,
										% by default here it goes through the TAs list by its order
										% therefore it will always be y,h,r if order in TAs is so and then it backtracks
										% note that this is when Goal is Assignment
										% whenever prolog is given the option to select from something and it can select
										% anything then there is an option to use semi columns, there won't be if you hardwire a specific
										% operation
										select(ta(Name, Load), T, NewTAs),
										NewLoad is Load - 1,
										H = ta(Name, NewLoad),
										Z is X-1,
										slot_assignment(Z,NewTAs, T1, T2).



% part d with e (no backtracking)
slot_assignment2(0,TAs,TAs,[]).
slot_assignment2(LabsNum,TAs,[H2|T2],[H|T]):-
											LabsNum >0,
											ta_slot_assignment2(TAs,RemTAs,H),
											select(ta(H,Load),RemTAs,NewTAs),
											H2 = ta(H,Load),
											NewLabsNum is LabsNum - 1,
											slot_assignment2(NewLabsNum,NewTAs,T2,T).


*/

% slot assignment without e											
slot_assignment(0,TAs,TAs,[]).
slot_assignment(LabsNum,TAs,[H2|T2],[H|T]):-
												LabsNum >0,
												
												select(ta(H,Load),TAs,NewTAs),
												Load >0,
												NewLoad is Load - 1,
												H2 = ta(H,NewLoad),
												
												NewLabsNum is LabsNum - 1,
												slot_assignment(NewLabsNum,NewTAs,T2,T).
												
			

% this is a code with wrong logic, this checks if each slot is not greater than max_slots_per_day
% while requirement is that Max is the number of slots per day that a TA can teach
% So I need to check how many times a certain TA appears in the List of lists and 
% check if that number is smaller than max

/* Part c
I need to make sure base case is reached only when
it is the 5th slot



helper(_,_,C,L):-
				C>L.
				
helper(([]|T),_,Counter,L):- 					
						Counter < L ,
						CounterNew is Counter +1,
						helper(T,Max,CounterNew,L).
max_slots_per_day(ListofLists,Max):-
							length(ListofLists,L),
							helper(ListofLists,Max,1,L).

% last helper contains if Counter = L
helper([H|T],Max,Counter,L):-
							length(H,LengthSlot),
							LengthSlot =< Max,
							CounterNew is Counter +1,
							helper(T,Max,CounterNew,L).
								
*/							
								
								
% Excercise c


max_slots_per_day(DaySched,Max):-
								append(DaySched,NormalList),
								list_to_set(NormalList,NoDups),
								helper(NoDups,NormalList,Max).
								
helper([H|T],NormalList,Max):-
									intersection(NormalList,[H],M),
									length(M,L),
									L=<Max,
									helper(T,NormalList,Max).

% base case is when last element is reached so will be true since if it
% was false the body would have output it
helper([],_,_).

% Excercise b
day_schedule([],RemTAs1,RemTAs1,[]).
day_schedule([H1|T1],TAs,RemTAs,[H|T]):-
										slot_assignment(H1,TAs,RemTAs1,H),
										day_schedule(T1,RemTAs1,RemTAs,T).
			


/**			
 week_schedule([[]|T],_,):-
							
					week_schedule(T,TAs,DayMax,WeekSched):-
week_schedule([[H|T]],TAs,DayMax,[[H_Slots|T_Slots]]):-
											
											
											
											slot_assignment(H1,TAs,RemTAs1,Assignment),
											H_Slots = Assignment,
											max_slots_per_day(H_Slots,DayMax),
											
											week_schedule(T,RemTAs1,DayMax,[T_Slots]).
											
	*/		

% (a) week_schedule	
week_schedule([],_,_,[]).											
week_schedule([H|T],TAs,DayMax,[Day|TDay]):-
													
													day_schedule(H,TAs,RemTAs,Assignment),
													max_slots_per_day(Assignment,DayMax),
													Day = Assignment,
													
													week_schedule(T,RemTAs,DayMax,TDay).
													
																						
								
								
								
								
								
								
								
								
								
								
								
						