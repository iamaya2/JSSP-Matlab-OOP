function [NextActivity] = JSSPHeurLPT (instance)
 [~,NextActivity] = max([instance.upcomingActivities.processingTime]);
end
