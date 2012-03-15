# MATLAB FS12 – Research Plan

> * Group Name: Baby-chiefs
> * Group participants names: Hans Hardmeier, Andrin Jenal , Beat Kueng, Felix Thaler
> * Project Title: Modelling Situations of Evacuation in a Multi-level Building

## General Introduction

Simulating the evacuation scenario of a 2D single-level building is well known but not general enough. Though we want to introduce a more sophisticated simulation within a multi-level building. 

E.g.: What would happen, if the ETH building has to be evacuated? Which escape routes would be mostly used?

Since skyscraper/tower building are getting more common in large cities, engineers have to care more about the behaviour in situations of emergency namely evacuation. 

## The Model

We are planning to base our work on the social force model of Disaster spreading and pedestrian dynamics.
In an evacuation we depend on the floor structures, connections between the different floors, obstacles to be avoided (known as the initial conditions) as well as on the amount of people being evacuated.
An important aspect refers to the psychological pressure of each person being evacuated. The reaction of each individuum is unpredictable. We want to include all possible scenarios (from an ordered evacuation-model, to a total chaos model). By reaching this level of abstraction, we can calculate the worst case scenario in a specific building and provide improvement proposals.


## Fundamental Questions

Research object: Main Building ETH

--- Can we improve the evacuation model from the ETH ? ---

Which escapes are mostly used in case of evacuation?
- Psycological pressure, knowledge of the building...

Which would be the best strategy for an evacuation?
- Which escapes would be over-used, which ones under-used?
- Do we need more escapes or wider exit doors?

What is the behaviour of the people as a group (not individuum)?
- Best-/Worst-Cases
- Different kind of reaction under pressure
- Influence to other people (panic distribution?)



(At the end of the project you want to find the answer to these questions)
(Formulate a few, clear questions. Articulate them in sub-questions, from the more general to the more specific. )


## Expected Results

We expect the stairs and the main building exit to be the bottlenecks. The amount of people in lower levels is increasing with time until a certain point, when most of the people have exited the building.
Also we think that if the velocity of the people is higher (people are more in panic), jams at the exit will be increased and people will mainly try to take the main exit instead of emergency exits.

(What are the answers to the above questions that you expect to find before starting your research?)


## References 

(Add the bibliographic references you intend to use)
(Explain possible extension to the above models)
(Code / Projects Reports of the previous year)


## Research Methods

We will use the agent-based social force model to simulate the behaviour of invdividual persons. Shortest evacuation paths may probably be precalculated using a grid discretization and fast marching or fast sweeping methods.
The parameters of the model will be based on empirical data from accordant literature.

(Cellular Automata, Agent-Based Model, Continuous Modeling...) (If you are not sure here: 1. Consult your colleagues, 2. ask the teachers, 3. remember that you can change it afterwards)


## Other

(mention datasets you are going to use)
