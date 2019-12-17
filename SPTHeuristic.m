function [NextActivity] = SPTHeuristic (instance)
 [~,NextActivity] = min([instance.upcomingActivities.processingTime]);
end