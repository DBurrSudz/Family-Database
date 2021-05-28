/**This family consists of grace as mother, josephjr as father
 * and daniel and joshua as sons.
**/
family([grace,josephjr],[[],[daniel,joshua]]).

/**This family consists of joyce as mother, dussel as father,
 * auvil, tony, stanley and ricky as sons, and grace as only daughter.
**/
family([joyce,dussel],[[grace],[auvil,tony,stanley,ricky]]).

/**This family consists of mazie as mother, josephsr as father,
 * no daughters and barry, raymond, josephjr and louis as sons.
**/
family([mazie,josephsr],[[],[barry,raymond,josephjr,louis]]).

/**This family consists of casilda as mother and samuel as father with
 * joyce as only daughter.
**/
family([casilda,samuel],[[joyce],[]]).

/**Adlin is mother, thomas is father and dussel is son.
 * 
**/
family([adlin,thomas],[[],[dussel]]).

/**juliet is mother, zebedee is father and mazie is mother.*/
family([juliet,zebedee],[[mazie],[]]).

/**letheita is mother, elihu is father and josephsr is son.
**/
family([letheita,elihu],[[],[josephsr]]).


/**Predicate to test if M is found in the given list
**/
member(M,[M|_]).
member(M,[_|T]) :-
    member(M,T).


/**is X the father of Y.
 * Using X, the list of daughters and sons is retrived and Y is tested
 * to see if it is a member of any of them.
**/
father_of(X,Y) :-
    family([_,X],[Daughters,Sons]),
    (member(Y,Daughters) ; member(Y,Sons)).


/**is X the father of Y.
 * Using X, the list of daughters and sons is retrived and Y is tested
 * to see if it is a member of any of them.
**/
mother_of(X,Y) :-
    family([X,_],[Daughters,Sons]),
    (member(Y,Daughters) ; member(Y,Sons)).


/**X is male if he is a father */
male(X) :-
    family([_,X],_).

/**X is male if he is a son in any family*/
male(X) :- 
    family(_,[_,Sons]),
    member(X,Sons).

/*X is female if she is a mother*/
female(X) :-
    family([X,_],_).

/*X is female if she is a daughter in any family*/
female(X) :-
    family(_,[Daughters,_]),
    member(X,Daughters).

/*X is the parent of Y if X is the father of Y*/
parent_of(X,Y) :-
    father_of(X,Y).

/*X is the parent of Y if X is the mother of Y*/
parent_of(X,Y) :-
    mother_of(X,Y).

/**X is the son of Y if Y is either the mother or father of X.
 * Additionally, X has to be a male.
**/
son_of(X,Y) :-
    (father_of(Y,X) ; mother_of(Y,X)),
    male(X).

/**X is the daughter of Y if Y is either the mother or father of X.
 * Additionally, X has to be a female.
**/
daughter_of(X,Y) :-
    (father_of(Y,X) ; mother_of(Y,X)),
    female(X).


/**is X a sibling of Y.
 * Given either X or Y, a list of all possible siblings is returned.
 * For this statement to be true, X and Y must share similar parents and
 * X and Y cannot be referring to the same child.
 **/
sibling_of(X,Y) :-
    parent_of(Z,X),
    parent_of(Z,Y),
    X \== Y.

/**is X a brother of Y.
 * This predicate builds on the sibling predicate adding the additional
 * constraint of X being a male.
**/
brother_of(X,Y) :-
    sibling_of(X,Y),
    male(X),
    X \== Y.


/**is X a sister of Y.
 * This predicate builds on the sibling predicate adding the additional
 * constraint of X being a female.
**/
sister_of(X,Y) :-
    sibling_of(X,Y),
    female(X),
    X \== Y.

/**is X a grandparent of Y.
 * For this predicate to be true, the parent of Y must be a child of
 * X. Given X all possible grandchildren is returned. Given Y all possible
 * grandparents are returned.
 **/
grandparent_of(X,Y) :-
    parent_of(X,Z),
    parent_of(Z,Y),
    X \== Y.


/**is X an ancestor of Y. This is the base case that represents
 * the simplest ancestor of someone - their parent.
**/
ancestor_of(X,Y) :-
    parent_of(X,Y),
    X \== Y.

/**is X an ancestor of Y. 
 * This predicate makes a recursive call making its way down to the 
 * base case defined
 **/
ancestor_of(X,Y) :-
    parent_of(X,Z),
    ancestor_of(Z,Y),
    X \== Y.

/**S is the oldest son of P is either the mother or father and S is the 
 * first child in the P's list of sons.
**/
oldest_son(S,P) :-
    (family([P,_],[_,[S|_]]) ; family([_,P],[_,[S|_]])).

/**S is the oldest daughter of P is either the mother or father and S is the 
 * first child in the P's list of daughters.
**/
oldest_daughter(D,P) :-
    (family([P,_],[[D|_],_]) ; family([_,P],[[D|_],_])).
    


    

