# Leetcode problems

Good collection by topic [here](https://leetcode.com/discuss/study-guide/448285/List-of-questions-sorted-by-common-patterns.)

General binary search template [here](https://leetcode.com/discuss/study-guide/786126/Python-Powerful-Ultimate-Binary-Search-Template.-Solved-many-problems)

## Recursion

Some languages can optimize tail recursion calls s.t. further calls overwrite
prior calls' memory locations
  * Only possible if sole recursion call is in final `return` statement
  * Python is not one of these languages

### Linked Lists

Linked lists are good candidates for recursion practice
  * Simplest implementation is typically stack, so you can reverse
  * Recursion incurs `O(n)` space and emulates stack
  * Better method is typically iteration with two pointers for `O(1)` space

Common idiom for LL recursion is `if not h: return None; h.next = f(h.next); 
return h if condition else h.next`
  * This zips to the end of the list, then unravels back like a stack
  * See P-83 Remove Duplicates or P-203 Remove Values

P-206 Reverse -- keep iterator on previous and current

P-234 Palindrome has easy `O(n)` space stack solution. 
  * `O(1)` space reverses latter half of list, then checks in tandem 
  with two pointers. "Floyd's algorithm"
  * Emulate stack with (ugly) recursion -- zip to end like above, then check 
  against nonlocal header node and set nonlocal flag if bad.

Useful tip: initialize dummy header that points to real header, then do work, 
then return `dummy.next` at the end. Helps deal with empty edge cases.

P-21 Merge Two has simple and efficient iterator solution with one pointer on
each list, a `current` pointer, and a `dummy_head` for safety
  * Recursion compares two nodes, then edits the min node's `next` field 
  via `min_node.next = f(min_node.next, max_node)` and finally `return min_node`

### Math

P-50 Power has simple `O(n)` iteration/recursion, but you can get `O(log n)` 
time by halving the exponent if even, and subtracting one if odd.

P-779 Kth Symbol has brute force `O(2^n)` recursion solution, building up 
rows one at a time. 
  * Better is to use rules to find patterns for even/odd indices, then 
  traverse backwards one row at a time. `O(n)` time.

P-231 Power of 2 recursion checks if `x==1`, then if `x%2==0` proceed to halve. 
  * Don't forget to check for `x<=0`, for which the answer is False

## Divide and Conquer

1. Divide `sub_problems = divide(p)`
2. Solve `solutions = [f(p) for p in sub_problems]`
3. Merge `return merge(solutions)`

General framework:
  * define `Problem` and `Solution` objects 
  * `f` maps one Problem to one Solution
    * `def f(p): evaluate current problem, then 
    return merge([ f(pl) for pl in divide(p) ])`
    * Evaluation ensures `divide` doesn't get too small a problem
  * `merge` maps a list of Solutions to one Solution
    * `def merge(ss): ...`
  * `divide` maps one Problem to a list of Problems
    * `def divide(p): ...`
    * Can filter out irrelevant subproblems

May need to only apply `f(pl)` to some subproblems -- e.g., quick-sort

### Examples

Validate BST
  * `class Problem: TreeNode node, int lo, int hi`
  * `class Solution: bool valid` -- can simplify to raw bool
  * `def f: if not p.node: return Solution(True); 
  if p.node.val <= p.lo or p.node.val >= p.hi: return Solution(False); 
  return merge([f(pl) for pl in divide(p)])`
  * `def merge: return Solution(ss[0].valid and ss[1].valid)`
  * `def divide: return 
  [ Problem(p.node.left, p.lo, min(p.hi, p.node.val)), 
  Problem(p.node.right, max(p.lo, p.node.val), p.hi) ]`
  * Finally, call `f( Problem(root, -1<<32, 1<<32) ).valid` to get desired bool

Validate BST -- alternative explanation
  * remember to include lower and upper bounds! Can have tricky tree 
  where all subtrees are BSTs, but there's a violation further up the tree.
  * If going left, pass along new upper bound `max(hi, r.val)`. If going right,
    pass along new lower bound `min(lo, r.val)`.

Merge-sort -- focuses on `merge` step
  * `class Problem: List nums` -- can simplify to raw list
  * `class Solution: List nums` -- can simplify to raw list
  * `def f: if len(p) <= 1: return p;
  return merge([f(pl) for pl in divide(p)])`
  * `def merge: fill up long list by iterating through each short list`
  * `def divide: return [ p[:len(p)//2], p[len(p)//2:] ]
  * Finally, call `f(p)` to get desired sorted list

Merge-sort -- alternative explanation
  1. Split down middle to create only 2 subproblems
    * Just `return p` if empty or single
  2. Recurse with `merge( p[:len//2], p[len//2:] )`
  3. Merge: zip together each of the two arrays into a third array using iterators
    * If either iterator is at end, then trivially append other array to result
      array
    * Otherwise, pick the min of the two elements and increment the iterator

Merge-sort takes `O(n)` time for the zip stage, which happens `O(log n)` times.
Time complexity is `O(n log n)` and space is `O(n)` to store other array.

Quick-sort -- focuses on `divide` step
  * `class Problem: List nums` -- can simplify to raw list
  * `class Solution: List nums` -- can simplify to raw list
  * `def f: if len(p) <= 1: return p;
  return merge([f(pl[0]), pl[1], f(pl[2])])` -- skip over middle (equal to pivot) 
  to avoid infinite recursion!
  * `def merge: concatenate lists in order (inputs are pre-ordered!)`
  * `def divide: pick pivot, then create lists with x < p, x==p, and x > p`
  * Finally, call `f(p)` to get desired sorted list

Quick-sort has `O(N log N)` time complexity if median is selected every time.
`O(N^2)` time if min or max is selected, in which case it's equivalent to
insertion sort. `O(log N)` space due to recursion (no cost to build sublists?)

### Tips

⚠️  Some problems seem like DnC, but can more easily and efficiently be solved via
tree traversal (linear time rather than product of logarithm)
  * E.g., P-240 search 2D matrix is actually a binary tree starting from
    the top-right corner. This gives `O(m + n)` time
  * 👍 Good example of using all the rules, plus changing perspective
  * My DnC solution considers each of 4 submatrices, throwing out those whose
    range (topleft - bottomright) doesn't include target. I think this gives
    `O(log m log n)` time. If only 1 submatrix is valid at each pass, you get 
    best case `O(logmn) = O(log m + log n)` time

### Master theorem

Time complexity has general recurrence `T(n) = a * T(n/b) + f(n)`
  * `f(n)` is time to divide and merge, which is normally `O(n^d)`
  * Typically, `a = b` since all subproblems need to be solved

3 cases
  1. `a < b^d` or `d < log2(a) / log2(b)` --> `O(n^logb(a))`
    * e.g., max depth of binary tree has `a = b = 2` and `d = 0`
  2. `a = b^d` or `d = log2(a) / log2(b)` --> `O(n^d log(n))`
    * e.g., binary search has `a = 1`, `b = 2`, `d = 0`
    * e.g., merge-sort has `a = 2`, `b = 2`, `d = 1`
  3. `a > b^d` or `d > log2(a) / log2(b)` --> `O(n^d)`
    * e.g., quickselect has `a = 1`, `b = 2`, `d = 1`

Only works if subproblems are the same size! Won't work for fibonacci, e.g.

## Backtracking

Build candidates, then abandon those as soon as it cannot yield a valid solution

Useful for constraint satisfaction problems

Similar to DFS

E.g., traverse trie to find word -- if current node has wrong letter, then
backtrack and move to next candidate. If it has correct letter, continue
downwards

E.g., Number of ways to place N queens on NxN chess board -- iterate over rows 
and cols, placing queen if not under attack. Remove queen if bad solution.
  * `def f(row, count): for col in range(n): if not-attacked: place-queen and if 
    bottom then increment count, else count = f(row+1, count); remove-queen; 
    return count`
  * `remove-queen` peels back queens for next iteration

General framework:
  * define `Problem` and `Solution` objects 
  * `f` maps one Problem to one Solution
    * `def f(p): if find_solution(p): output(p); return; else for pl in ps: if
      is_valid(pl): place(pl), f(pl), remove(pl)
    return merge([ f(pl) for pl in divide(p) ])`
  * Each recursion is next step closer to end. Each iteration within recursion 
  is at same spot 
  * Backtracking should happen within iteration
  * `is_valid` prunes search zones, like `not-attacked` for N-queens
  * `place` and `remove` are symmetric