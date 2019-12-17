function [NextActivity] = LPTHeuristic (instance)
 [~,NextActivity] = max([instance.upcomingActivities.processingTime]);
end
