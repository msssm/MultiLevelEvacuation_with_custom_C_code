# Code Folder 

this folder contains the matlab & c code

to run the simulation, first compile the c code using the matlab function
'compile\_c.m' (install a c compiler first, eg gcc on UNIX).

run the simulation with: simulate() with the optional config file as argument
(eg '../data/config1.conf').


## some conventions

- image coordinates:
 img(y,x), where y is vertcal index, x is horizontal index
 img(1,1) is the upper leftmost point

- data format:
 all internal data is stored in pixels not in meters

