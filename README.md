%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Who?

@article{ping,
    Author = {E. Ohn-Bar and K. Kitani and C. Asakawa},
    Title = {Personalized Dynamics Models for Adaptive Assistive Navigation Systems},
    Journal = {Conference on Robot Learning},
    Year = {2018}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

What?

**** Processed, ready to use data ****
- All data can be found in data.mat

- 'contextdata' array contains information about the three floors.
    - floorid: [-1, 1, 3] = [basement, first floor, third floor] 
    - floorplan: original map of the floorplan
    - floorobstacles: processed floorplan to only show obstacles (1) and free space (0)
    - floortactile: processed floorplan to only show tactile paving
    - scale: rescale the floorplan to meters
    - origin: elevator chosen as the same origin (0,0) across all floors
    - plannedpath: points along the planned path by the system

- 'trajdata' array contains information about the trajectories of each participant from 1-9.
  There are two types of data arrays. One is at 1 second intervals, as annotations of user positions were done at 1 sec intervals.
  these are 'gtpos', 'estpos', 'gttime', 'gtroute', 'gtfloor'. The other is information directly from the sensor readings, which is at much higher sampling, 
  can be found at 'logtime', 'logorientation', and 'logposition'.
    - gttime: timestamp for corresponding position in 'gtpos', 'estpos', 'gtroute', 'gtfloor'. Can also be used to align with the timestamp in 'logtime'
    - gtpos: annotated position (x,y) in the floorplan of current user position.
    - estpos: estimated position (x,y) in the floorplan by the system.
    - gtroute: current route ID, either [1,2,3], used for training/testing. Route 1 goes from basement floor to 3rd floor in the building. Route 2 is from the 3rd floor to 1st floor. and Route 3 is from 1st floor back to the initial position in the basement floor.
    - gtfloor: current floor ID, either [-1,1,3]

    - logtime: timestamp for 'logposition' and 'logorientation', sampled at higher frequency from the system. 
               Can be used to match data with 'gttime'. I use the data logs to find current user's orientation and for better estimate of user speed.
    - logposition: estimated position (x,y) in the floorplan by the system.    
    - logorientation: estimated orientation (in degrees in the array, recommend using deg2rad) in the floorplan by the system.
    
    - instructions: output by the system to the user. The array contain a lists of all the instruction events, their type (could be multiple composed)
                    the time of their onset (can be used to match with the above timestamps), and the time in which the announcement was completed ('timeend').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

How?

**** Training/testing split ****
-  There are 9 participants, each has 3 routes. 
   Note that the protocol in the paper uses routes 1-2 for adapting the model (i.e., training), and route 3 for testing (i.e., evaluation is kept fixed).
   In this case, training can begin from scratch or from a model learned from other users. 
-  For training and evaluation data, I use the estimated position of the users, not groundtruth, from the logs (logposition and logorientation).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Please contact me at eohnbar@gmail.com if further questions, I'll be happy to help. 



