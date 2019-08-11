close all
clear all
%%
%LOAD DATA
%For format see README.txt
d = load('data.mat');
%%
%VISUALIZE TRAJECTORY DATA IN TOP-DOWN MAP
ParticipantID = 1;  %1-9, participant ID
PlotIDX = 50;  %a time index to plot

%Determine current floorplan for visualization
ContextIDX = [];
for i = 1:length(d.contextdata)
    if d.contextdata(i).floorid == d.trajdata(ParticipantID).gtfloor(PlotIDX)
        ContextIDX = i;
    end
end

Iw = d.contextdata(ContextIDX).floorobstacles;
origin = d.contextdata(ContextIDX).origin; 
scale = d.contextdata(ContextIDX).scale;  
Isize = [1968, 1968];
x = ([1-origin(1) Isize(1)-origin(1)]-1)./scale; y = ([1-origin(2) Isize(2)-origin(2)]-1)./scale;
      
image(x,y,flipud(uint8(255*Iw))); colormap gray
set(gca,'YDir','normal')

hold on
plotR = 30;
visR = 10;
idxvals = PlotIDX-plotR:PlotIDX+plotR; idxvals = max(1,idxvals); idxvals = min(length(d.trajdata(ParticipantID).estpos),idxvals);
xvals = d.trajdata(ParticipantID).estpos(idxvals,1);
yvals = d.trajdata(ParticipantID).estpos(idxvals,2);
plot(xvals,yvals,'linewidth',2)

xlim([mean(xvals)-visR mean(xvals)+visR]); %success and end are often same in movement space
ylim([mean(yvals)-visR mean(yvals)+visR]);
grid on

%Can also plot the instructions
vocabtoshow =  {'Misc','Info','Distance From POI','Forward','Approaching','Turn Left','Turn Right','Turn Diagonal Left','Turn Diagonal Right','Turn Little Left','Turn Little Right','Obstacle Left','Obstacle Right'};
actccc=1; 
clear str1
alphaplot = .3;
for i = 1:length(idxvals)
    currTime = d.trajdata(ParticipantID).gttime(idxvals(i));
    
    [mval,midx] = min(abs(currTime-[d.trajdata(ParticipantID).instructions.timestart{:}]));
    if mval < 1 %milliseconds
       %Plot
       ctext = d.trajdata(ParticipantID).instructions.command{midx};
       str1(actccc) = { ['(' num2str(actccc) ') ' ctext]};
              
       pos = [ xvals(i)-1/2,yvals(i)-1/2,1,1];
       rectangle('Position',pos,'Curvature',[1 1],'facecolor',[1 0 1 alphaplot],'edgecolor',[1 0 1]);
       htt = text(xvals(i),yvals(i),num2str(actccc));
       htt.HorizontalAlignment = 'center';
       htt.VerticalAlignment = 'middle';
       
       actccc=actccc+1;
    end
end

if actccc>1
    textposshow = [.23 .8];
    t = annotation('textbox');
    t.String = str1;
    t.FontSize = 12;
    currsize = t.Position;
    t.Position = [textposshow currsize(3) currsize(4)];
    t.BackgroundColor = [1 1 1];
    t.FaceAlpha = .9;
end


%%
%EXAMPLE ONEHOT ENCODING OF INSTRUCTIONS
vocab = {'Misc','Info','DistanceFromPOI','Forward','Approaching','TurnLeft','TurnRight','TurnDiagonalLeft','TurnDiagonalRight','TurnLittleLeft','TurnLittleRight','ObstacleLeft','ObstacleRight'};

defaultidx = 1;
curr = 'Forward';
encoded = toOneHot(curr,vocab,defaultidx);

