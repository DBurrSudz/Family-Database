
/**This family consists of grace as mother, josephjr as father
 * and daniel and joshua as sons.
**/
family([grace,josephjr],[[daniel,male],[joshua,male]]).

/**This family consists of joyce as mother, dussel as father,
 * auvil, tony, stanley and ricky as sons, and grace as only daughter.
**/
family([joyce,dussel],[[auvil,male],[tony,male],[stanley,male],[grace,female],[ricky,male]]).

/**This family consists of mazie as mother, josephsr as father,
 * no daughters and barry, raymond, josephjr and louis as sons.
**/
family([mazie,josephsr],[[barry,male],[raymond,male],[josephjr,male],[louis,male]]).

/**This family consists of casilda as mother and samuel as father with
 * joyce as only daughter.
**/
family([casilda,samuel],[[joyce,female]]).

/**Adlin is mother, thomas is father and dussel is son.
 * 
**/
family([adlin,thomas],[[dussel,male]]).

/**juliet is mother, zebedee is father and mazie is mother.*/
family([juliet,zebedee],[[mazie,female]]).

/**letheita is mother, elihu is father and josephsr is son.
**/
family([letheita,elihu],[[josephsr,male]]).

/**Recursively determines the length of a list**/
list_length([],0).
list_length([_|T],Num)  :-  
    list_length(T,X),  Num  is  X+1.

/**Finds if M is a part of the given list.
 * More specifically this predicate determine if a child belongs to a
 * family.
**/
member(M,[[M,_]|_]).
member(M,[_|T]) :-
    member(M,T).

/**X is female if she is a mother**/
female(X) :-
    family([X,_],_).

/**X is female if she is a daughter of a family**/
female(X,[[X,female]|_]).
female(X,[_|T]) :-
    female(X,T).

/**X is male if he is a father**/
male(X) :-
    family([_,X],_).

/**X is male if he is a son of a family**/
male(X,[[X,male]|_]).
male(X,[_|T]) :-
    male(X,T).
   
/**Determines if someone is a son**/
is_son(X) :-
    X = [_,male].

/**determines if someone is a daugter**/
is_daughter(X) :-
    X = [_,female].

/**First born if Child is at the front of the list for a given family**/
first_born(Child,[[Child,_]|_]).
    
 
/**is Father the father of Child.
 * Using Father, the list of daughters and sons is retrived and Child is tested
 * to see if it is a member of any of them.
**/
father_of(Father,Child) :-
    family([_,Father],Children),
    member(Child,Children),
    Father \== Child.


/**is Mother the mother of Child.
 * Using Mother, the list of daughters and sons is retrived and Child is tested
 * to see if it is a member of any of them.
**/
mother_of(Mother,Child) :-
    family([Mother,_],Children),
    member(Child,Children),
    Mother \== Child.

/*Parent is the parent of Child if Parent is the father of Child*/
parent_of(Parent,Child) :-
    father_of(Parent,Child),
    Parent \== Child.

/*Parent is the parent of Child if Parent is the mother of Child*/
parent_of(Parent,Child) :-
    mother_of(Parent,Child),
    Parent \== Child.


/**is Sib1 a sibling of Sib2.
 * Given either Sib1 or Sib2, a list of all possible siblings is returned.
 * For this statement to be true, Sib1 and Sib2 must share similar parents and
 * Sib1 and Sib2 cannot be referring to the same child.
 **/
sibling_of(Sib1,Sib2) :-
    parent_of(Z,Sib1),
    parent_of(Z,Sib2),
    Sib1 \== Sib2.

/**is Sister a sister of Sibing.
 * This predicate builds on the sibling predicate adding the additional
 * constraint of Sister being a female.
**/
sister_of(Sister,Sibling) :-
    sibling_of(Sister,Sibling),
    family(_,Children),
    (female(Sister,Children) ; female(Sister)),
    Sister \== Sibling.

/**is Brother a brother of Sibing.
 * This predicate builds on the sibling predicate adding the additional
 * constraint of Brother being a male.
**/
brother_of(Brother,Sibling) :-
    sibling_of(Brother,Sibling),
    family(_,Children),
    (male(Brother) ; male(Brother,Children)),
    Brother \== Sibling.



/**finds the oldest child of Parent by checking the front of the children
 * list.
**/
oldest_child(Parent,Oldest) :-
    (family([Parent,_],[[Oldest,_]|_]) ; family([_,Parent],[[Oldest,_]|_])),
    Parent \== Oldest.

/**Finds all the children of given Parent and filters out the sons.
 * The oldest son is at the beginning of that new list.
**/
oldest_son(Parent,OldestSon) :-
    (family([Parent,_],Children) ; family([_,Parent],Children)),
	include(is_son,Children,Sons),
    first_born(OldestSon,Sons),
    Parent \== OldestSon.


/**Finds all the children of given Parent and filters out the daughters.
 * The oldest daughter is at the beginning of that new list.
**/
oldest_daughter(Parent,OldestDaughter) :-
    (family([Parent,_],Children) ; family([_,Parent],Children)),
	include(is_daughter,Children,Daughters),
    first_born(OldestDaughter,Daughters),
    Parent \== OldestDaughter.


/**List of all children for the given parent is returned and counted.**/
number_of_children(Parent,Num) :-
    (family([Parent,_],Children) ; family([_,Parent],Children)),
    list_length(Children,Num).

/**List of all children for the given parent is returned and all sons are 
 * filtered out. That new list is now counted.
**/
number_of_sons(Parent,N) :-
    (family([Parent,_],Children) ; family([_,Parent],Children)),
    include(is_son,Children,Sons),
    list_length(Sons,N).
    
/**List of all children for the given parent is returned and all daughters are 
 * filtered out. That new list is now counted.
**/
number_of_daughters(Parent,N) :-
    (family([Parent,_],Children) ; family([_,Parent],Children)),
    include(is_daughter,Children,Daughters),
    list_length(Daughters,N).

/**is Ancestor an ancestor of Descendant. This is the base case that represents
 * the simplest ancestor of someone - their parent.
**/
ancestor_of(Ancestor,Descendant) :-
    parent_of(Ancestor,Descendant),
    Ancestor \== Descendant.


/**is Ancestor an ancestor of Descendant. 
 * This predicate makes a recursive call making its way down to the 
 * base case defined
 **/
ancestor_of(Ancestor,Descendant) :-
    parent_of(Ancestor,X),
    ancestor_of(X,Descendant).
    
    
    










    