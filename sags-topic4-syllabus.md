# IT SAGs — Topic 4 Syllabus (lesson-planning checklist)

**Source:** IEB *Information Technology Subject Assessment Guidelines*, updated
January 2024, implementation Grade 12 2025 (`20. Information Technology SAGS 2025
(Updated Jan 2024).pdf` in this folder).

**What this file is.** Topic 4 — *Data and Information Management, Solution
Development* — pulled out of Appendix G's scattered three-column grid and laid
out as a teaching checklist, Grade 10 → 11 → 12. Topics 1–3 (hardware, networks,
social) are not programming and are not covered here. Pair this with
[`pascal-house-style.md`](pascal-house-style.md) for how the code itself is
written.

Subtopics keep the SAGs numbering: `10.4.3` is "Grade 10, Topic 4, subtopic 3".
The same subtopic number is the same skill strand across all three grades.

---

## 1. Exam context

- **Languages allowed:** Delphi (Object Pascal), Java, or C#. This course is
  Delphi/Object Pascal.
- **Practical exam (Paper 1):** SQL, algorithms and OOP. **Text-based interface,
  not a GUI.** No programmatic database connection. 150 marks → 100.
- **Theory exam (Paper 2):** Topic 4 is 50 of 150 marks. 150 → 100.
- **PAT:** 100 marks, Grade 12 (may start in Grade 11), all Topic 4.
- **Cognitive-level weighting** (set every test to this spread):

  | Level | Band | Weight | Hint verbs |
  |---|---|---|---|
  | 1 | Knowledge, Comprehension | 30% | list, identify, name, state, define, what is, explain |
  | 2 | Application, Analysis | 40% | describe, compare, contrast, distinguish, discuss, illustrate, classify |
  | 3 | Computational thinking, Synthesis, Problem solving, Evaluation | 30% | modify, design, assess, recommend, support, arrange, combine, create, rank, conclude |

### Not examinable in the practical exam (theory / PAT only)

Teach for understanding, but don't drill as practical-exam prep:

- **Dynamic arrays** (`12.4.3`) — concept only, compared to static arrays.
- **JSON files** (`12.4.7`) — purpose, structure, vs text files and databases.
- **Multi-table database design & normalisation** (`12.4.10`) — SBA and PAT only.
- **Accessing a multi-table database from code** — PAT only.
- **UI components for validation** — drop-downs, calendars (`11.4.12`).
- **Help systems** (`11.4.15`, `12.4.15`) and **project documentation**
  (`12.4.16`) — PAT only.

---

## 2. Working scope for this course

*(Not from the SAGs — a build decision, recorded here so it isn't relitigated.)*

A browser-based self-marking site is a good fit for subtopics **`.1`–`.8`**:
computational thinking, data representation, data structures, Boolean logic, OOP
language mechanics, parameters, text-file persistence, and algorithms. That is
most of Grade 10–11 and the highest-frequency practical-exam material.

It is **not** a fit for the Delphi RTL, GUI/backend separation, the IDE debugger
skills in `.13`, or the PAT. Those stay in Lazarus/Delphi proper.

Databases and SQL (`.9`–`.11`) are a separate teaching track — flag here for
completeness, out of scope for the Pascal site itself.

---

## 3. Topic 4 strands

### 4.1 — Computational thinking / problem solving

Four **iterative** stages. Applied to progressively larger problems each grade.

**Grade 10** — simple problems
- [ ] Decomposition: understand the problem, state in own words, break into parts
      using **IPO** and methods
- [ ] Pattern recognition: spot previously-solved problems; spot repetition
      (loops, methods)
- [ ] Abstraction: ignore irrelevant detail; pick relevant parts; represent data
      with appropriate types/structures; treat each solved part as one concept
- [ ] Algorithm: combine parts; represent in **pseudocode and flowcharts**; code
      and test
- [ ] Evaluate: find errors and inefficiencies. Efficiency = no duplicated code
      **and** no unnecessary processing

**Grade 11** — more complex problems
- [ ] Decomposition: parts representable by **arrays and objects**; separate
      interface from backend; identify permanent storage
- [ ] Pattern recognition: similar data → arrays/classes; similar behaviour →
      methods; reuse/adapt objects, methods, classes, UIs
- [ ] Abstraction: design classes to encapsulate fields + methods; information
      hiding to isolate and protect data
- [ ] Algorithm: apply design and testing principles so each part works alone
      and together

**Grade 12** — large problems, with stakeholders
- [ ] Decomposition: identify goals and sub-goals with users / dev / test teams;
      break into parts solvable with earlier concepts
- [ ] Pattern recognition: choose the best data structure (incl. existing
      classes) from data, behaviour and goals
- [ ] Abstraction: use inheritance to reduce complexity
- [ ] Algorithm: combine abstract parts; pseudocode + flowchart; test against
      external / existing / previous solutions
- [ ] Evaluate: efficiency = reuse of classes and inheritance + no unnecessary
      processing

### 4.2 — Representing data in a fixed number of bits

**Grade 10**
- [ ] Number systems: decimal, binary, hexadecimal; convert between all three
- [ ] Combinations vs number of bits
- [ ] Character representation: ASCII/UTF-8, Unicode

**Grade 11**
- [ ] Why binary: word size (CPU registers), implications of fixed width
- [ ] Integers: formulas for min/max of signed and unsigned; overflow errors and
      consequences
- [ ] Reals: mantissa and exponent; overflow; accuracy — rounding vs truncation
- [ ] Fixed-width combinations applied: IPv4 vs IPv6, MAC in hex, pixel colour
      depth and screen resolution
- [ ] Hex as a shortening technique for binary

*(No Grade 12 additions.)*

### 4.3 — Data and data structures

**Grade 10** — simple data has forms; typing matters
- [ ] Types: string, char, integer, real, Boolean
- [ ] Arithmetic operators per type: `+ - * /` (real division), `mod`, `div`
- [ ] Precedence and brackets
- [ ] Right type for the job — e.g. ID number / phone number as **string**
- [ ] Data-type ranges; constant vs variable; naming conventions
- [ ] Conversions: string↔numeric, string↔char, char↔integer, real↔integer;
      narrowing vs widening effects
- [ ] Strings: length, concatenation, upper/lowercase, comparison

**Grade 11** — analyse a problem, code a suitable structure
- [ ] Use language-provided classes to input/validate/store/output **dates and
      times**
- [ ] String methods: isolate chars/substrings, compare, count, insert, replace,
      append, delete
- [ ] **Static arrays:** one-dimensional; parallel arrays; arrays of objects;
      parallel arrays vs arrays of objects
- [ ] Sort, search, calculate, manipulate over arrays
- [ ] Acquire data from a UI component and from a text file

**Grade 12** — combined structures
- [ ] Dynamic arrays: purpose, function, vs static *(theory only — see §1)*
- [ ] Combined designs: array as an object field; array of inherited objects;
      object-as-field; object whose fields are arrays of two different object
      types

### 4.4 — Boolean logic

**Grade 10**
- [ ] Identify a Boolean among other types
- [ ] Relational: `> >= < <=`, `=`, `<> / !=`
- [ ] Logical: `NOT AND OR`
- [ ] Order of operations and brackets; evaluate multi-condition expressions
- [ ] Truth tables, **max 3 variables**
- [ ] Apply in search engines, code, and SQL

**Grade 12**
- [ ] Evaluate and code **complex** Boolean expressions in all three contexts
- [ ] Truth tables, **max 4 variables**

### 4.5 — Methods and OOP

**Grade 10** — use what exists
- [ ] Call maths functions: min/max, sum, average, power, abs, `div`/`mod`,
      sqrt, rounding (whole and fixed decimals), random numbers
- [ ] Instantiate objects of existing classes; purpose of constructors
- [ ] Call a typed function vs a void procedure

**Grade 11** — design classes
- [ ] Fields and methods; static vs non-static (class vs instance)
- [ ] `private` / `protected` / `public`; constant fields
- [ ] Constructors — default and parameterised — to instantiate and assign
- [ ] Accessor, mutator, `toString`
- [ ] Encapsulation and information hiding
- [ ] Method overloading; dynamic binding
- [ ] Private helper methods
- [ ] Parameter passing into an object's method; return types
- [ ] Terminology: instance, instantiation, declare
- [ ] Object = backend, independent of the frontend
- [ ] **Class diagrams** — fields, methods, accessibility
- [ ] Use a typed method inside an output statement, condition, or assignment

**Grade 12** — inheritance and reuse
- [ ] Extended objects: fields of complex type (objects, arrays of objects);
      passing/returning complex types; null objects and null fields
- [ ] Inheritance: superclass/subclass; overriding — polymorphism and dynamic
      binding; advantages of inheritance
- [ ] Object-as-field vs inherited object — when to use which
- [ ] Type determination (`instanceof` / `is`)
- [ ] Compare data structures and give advantages

### 4.6 — Data transfer between methods/objects

**Grade 10**
- [ ] Parameters to send data: match count, type, order
- [ ] Return type to send data back

**Grade 11**
- [ ] Parameter passing + return values as frontend↔backend communication
- [ ] Send: single primitive; object
- [ ] Return: single primitive; object; **string with fields separated by `#`**
      (or similar); null
- [ ] Parameters as abstraction — fewer, more generic methods (code efficiency)
- [ ] Scope and lifetime of variables, fields, parameters

**Grade 12**
- [ ] Send and return **arrays and arrays of objects**

### 4.7 — Persistence

**Grade 11** — text files
- [ ] Create, append, read
- [ ] Multiple lines, fields for the same data structure
- [ ] Multiple lines, fields for different data structures
- [ ] Read into a complex structure — e.g. an array of objects
- [ ] Test whether the file exists — exception handling

**Grade 12** — JSON *(theory only — see §1)*
- [ ] Purpose and function of JSON files
- [ ] Structure for storing and transferring complex data
- [ ] Compare JSON, text files and databases — advantages and disadvantages

### 4.8 — Algorithms

**Grade 10** — selection and simple looping
- [ ] Concept of an algorithm; pseudocode or flowchart
- [ ] Selection and looping: `if`, `if…else`, `case`, `for`, `while`,
      `repeat…until`
- [ ] Classic problems: smallest, biggest, sum, average, factors and multiples,
      swapping values, isolating digits of an integer
- [ ] `if` vs `case` — when to use which
- [ ] Counting loop vs condition loop — `for` vs `while`
- [ ] Pre-check (`while`) vs post-check (`repeat`) loops
- [ ] Nested / cascading selection; nested loops with independent inner variables
- [ ] Use methods to abstract nested-structure complexity

**Grade 11** — array and string manipulation
- [ ] Search: sequential and **binary**
- [ ] Sort: selection, improved selection, bubble, **bubble with a flag**
- [ ] Insert an element; delete an element
- [ ] Remove duplicates — simple types and objects
- [ ] Strings: count words; isolate words; remove vowels; encode/encrypt;
      `"Fred John Smith"` → `"FJ Smith"`
- [ ] Validate input such as an ID number; calculate check digits
- [ ] Spot duplicated code → extract reusable methods and parameters

*(No separate Grade 12 algorithm list — algorithms at G12 are "search / sort /
insert / delete over arrays of objects and extended objects", i.e. §4.3 and §4.5
applied.)*

### 4.9–4.11 — Databases and SQL *(separate track — see §2)*

**Grade 10**
- [ ] Relational concepts: field, record, table; primary key; schema vs data
- [ ] Create a single-table database in an application package: field types and
      sizes, default values, autonumber PK, not-null and indexed fields
- [ ] `SELECT … FROM … WHERE`, `DISTINCT`, `LIMIT`/`TOP`, `ORDER BY ASC/DESC`
- [ ] Logical operators `NOT AND OR IN`; special operators `BETWEEN`, `LIKE`,
      `IS NULL`
- [ ] `INSERT`, `UPDATE`, `DELETE` with `WHERE`

**Grade 11**
- [ ] DBMS purpose and features: data-integrity management (accuracy,
      correctness, currency, completeness, relevance); security — multiuser
      access control, encryption, SQL injection, malware; backup, recovery,
      management
- [ ] Single-table SQL: `GROUP BY`, `HAVING`, multi-condition `WHERE`
- [ ] Calculated fields: concatenation, `AS` renaming, random numbers,
      `ROUND`/`INT`/`FLOOR`/`CEILING`, casting, `MOD` and `DIV`
- [ ] Aggregates: `SUM`, `AVG`, `MIN`, `MAX`, `COUNT`
- [ ] Dates: `NOW`, `YEAR`, `MONTH`, `TIME`, `DATE`, `HOUR`, `MINUTE`, `DAY`;
      accurate age calculation
- [ ] Strings: `LENGTH`, `MID`, `LEFT`, `RIGHT`, `SUBSTR`, char position
- [ ] `INSERT` with limited fields / autonumber PK

**Grade 12** *(SBA and PAT only — see §1)*
- [ ] Threats to data quality: corrupted, outdated, invalidated data;
      vulnerability (SQL injection, malware)
- [ ] Data warehousing — description, purpose, uses
- [ ] Data mining; big data sources (social media, activity-generated data, logs
      and audit trails, location data)
- [ ] NoSQL — description, example (MongoDB), comparison to SQL
- [ ] Normalisation: redundancy and repeating groups; update/insert/edit
      anomalies; 1NF, 2NF, 3NF; partial and transitive dependencies
- [ ] Keys: primary, foreign, composite; atomic vs non-atomic fields; duplicate
      / derived / redundant data
- [ ] Relationships: one-to-one, one-to-many, many-to-many; referential
      integrity
- [ ] Multi-table SQL: subqueries; `INNER JOIN` / `WHERE` on matching keys;
      `LEFT`/`RIGHT JOIN`; `NOT IN` / outer join to find unrelated records;
      `INSERT … SELECT`
- [ ] Access a multi-table database from code *(PAT only)* — connection class /
      path in code, query and edit, access and modify fields and records,
      represent in memory with suitable structures

### 4.12 — User interface

**Grade 10**
- [ ] Code a simple **text-based** UI: prompts and error messages from simple
      validation
- [ ] Good-UI principles (visual): structure, simplicity, visibility, feedback,
      tolerance, reuse
- [ ] Desktop UI vs mobile app UI

**Grade 11** *(not in the practical exam — see §1)*
- [ ] Descriptive error messages that indicate a solution
- [ ] Prompts and messages based on exceptions caught
- [ ] Metaphors / images (printer icon on a print button)
- [ ] Consistent behaviour, de facto standards (F1 = Help, ESC = cancel)
- [ ] Uncluttered screens, effective colour
- [ ] Components for validation — drop-downs, calendars

### 4.13 — Testing and debugging

**Grade 10**
- [ ] Choose standard, extreme and abnormal test data
- [ ] Trace tables to test logic and find errors
- [ ] Syntax vs runtime vs logic errors — differences and causes

**Grade 11**
- [ ] Debugger: watches, traces, breakpoints
- [ ] Trace tables to test logic, find errors, judge execution efficiency
- [ ] Identify and correct syntax, runtime and logic errors
- [ ] Value of generated test data
- [ ] Test with standard, extreme and abnormal data

### 4.14 — Data validation *(Grade 11)*

- [ ] Reasons for validation — prevent erroneous data entry
- [ ] Exception handling for errors
- [ ] Checks: presence, range, uniqueness, length, type, logical, check digit,
      check sum — with conditional loops where appropriate

### 4.15–4.16 — Help and documentation *(PAT only — see §1)*

- [ ] Context-sensitive help, menus, FAQs in a program
- [ ] APIs and comments in the project
- [ ] Specification, Design, Technical and Testing documents

---

## 4. School-Based Assessment

SBA is 25% of the NSC mark. Components:

| Component | Mark |
|---|---|
| 1 Practical Test | 17.5 |
| 1 Theory Test | 17.5 |
| Alternative assessment OR test (theory / practical / integrated) | 15 |
| Grade 12 Preliminary Exam Paper 1 | 25 |
| Grade 12 Preliminary Exam Paper 2 | 25 |
| **Total** | **100** |

Suggested Topic 4 tests: Normalisation Test (theory), OOP Test (written), OOP
Test (programming), SQL Test (practical), Data Validation Task (alternative).
Cluster-set tests are written on a common date and moderated by the cluster or
another IEB IT teacher.

---

## 5. Formative-assessment principle (SAGs 3.3.5)

> When teachers review a task, they should listen to the candidate and give
> advice. They should be careful not to give the candidate the solution. They
> should suggest alternate resources and query explanations.

The teaching-site equivalent: a wrong attempt gets a nudge and another go, not
the answer. Reveal and lock only after the attempts are used. Marking rewards
correct ideas and never deducts for spelling, grammar or informal language.
