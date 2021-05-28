male(joshua). /*joshua is a male*/
male(daniel). /*daniel is a male*/
male(josephjr). /*josephjr is a male*/
male(josephsr). /*josephsr is a male*/
male(elihu). /*elihu is a male*/
male(zebedee). /*zebedee is a male*/
male(dussel). /*dussel is a male*/
male(thomas). /*thomas is a male*/
male(samuel). /*samuel is a male*/
male(ricky). /*ricky is a male*/
male(auvil). /*auvil is a male*/
male(stanley). /*stanley is a male*/
male(tony). /*tony is a male*/
male(barry). /*barry is a male*/
male(louis). /*louis is a male*/
male(raymond). /*raymond is a male*/

female(grace). /*grace is a female*/
female(joyce). /*joyce is a female*/
female(adlin). /*adlin is a female*/
female(casilda). /*casilda is a female*/
female(mazie). /*mazie is a female*/
female(juliet). /*juliet is a female*/
female(letheita). /*letheita is a female*/

parent_of(josephjr,daniel). /*josephjr is the parent of daniel*/
parent_of(josephjr,joshua). /*josephjr is the parent of joshua*/
parent_of(grace,daniel). /*grace is the parent of daniel*/
parent_of(grace,joshua). /*grace is the parent of joshua*/

parent_of(josephsr,josephjr). /*josephsr is the parent of josephjr*/
parent_of(mazie,josephjr). /*mazie is the parent of josephjr*/
parent_of(josephsr,barry). /*josephsr is the parent of barry*/
parent_of(mazie,barry). /*mazie is the parent of barry*/
parent_of(josephsr,raymond). /*josephsr is the parent of raymond*/
parent_of(mazie,raymond). /*mazie is the parent of raymond*/
parent_of(josephsr,louis). /*josephsr is the parent of louis*/
parent_of(mazie,louis). /*mazie is the parent of louis*/
parent_of(dussel,grace). /*dussel is the parent of grace*/
parent_of(joyce,grace). /*joyce is the parent of grace*/
parent_of(dussel,tony). /*dussel is the parent of tony*/
parent_of(joyce,tony). /*joyce is the parent of tony*/
parent_of(dussel,ricky). /*dussel is the parent of ricky*/
parent_of(joyce,ricky). /*joyce is the parent of ricky*/
parent_of(dussel,stanley). /*dussel is the parent of stanley*/
parent_of(joyce,stanley). /*joyce is the parent of stanley*/
parent_of(dussel,auvil). /*dussel is the parent of auvil*/
parent_of(joyce,auvil). /*joyce is the parent of auvil*/

parent_of(zebedee,mazie). /*zebedee is the parent of mazie*/
parent_of(juliet,mazie). /*juliet is the parent of mazie*/
parent_of(elihu,josephsr). /*elihu is the parent of josephsr*/
parent_of(letheita,josephsr). /*letheita is the parent of josephsr*/
parent_of(adlin,dussel). /*adlin is the parent of dussel*/
parent_of(thomas,dussel). /*thomas is the parent of dussel*/
parent_of(casilda,joyce). /*casilda is the parent of joyce*/
parent_of(samuel,joyce). /*samuel is the parent of joyce*/

/**is 'X' the father of 'Y'.
 * This predicate attempts to determine if X is the father of Y.
 * Given X, a search is made for all possible values of Y.
 * Given Y a search is made for all possible values of X.
 * For this statement to be true, X has to be a parent of Y and 
 * X has to be a male.
 * **/
father_of(X,Y) :-
    parent_of(X,Y),
    male(X).


/**is 'X' the mother of 'Y'.
 * This predicate attempts to determine if X is the mother of Y.
 * Given X, a search is made for all possible values of Y.
 * Given Y a search is made for all possible values of X.
 * For this statement to be true, X has to be a parent of Y
 * and X has to be a female.
 * **/
mother_of(X,Y) :-
    parent_of(X,Y),
    female(X).


/**is X the son of Y.
 * Given son 'X', a search is made for all possible parents 'Y'.
 * Given a parent 'Y', a search is made for all sons 'X'.
 * For this statement to be true, X has to be a child of parent Y
 * and X has to be a male.
 * 
 **/

son_of(X,Y) :-
    parent_of(Y,X),
    male(X).


/**is X the daughter of Y.
 * Given daughter 'X', a search is made for all possible parents 'Y'.
 * Given a parent 'Y', a search is made for all daughter 'X'.
 * For this statement to be true, X has to be a child of parent Y
 * and X has to be a female.
 * 
 **/
daughter_of(X,Y) :-
    parent_of(Y,X),
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


    

