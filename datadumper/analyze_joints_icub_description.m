% analyze_joints_icub_description(datadumper_path)
% 
% Analyze the data of joints of iCub, dumped by datadumper. 
% Data should be recorded as data.log in the folders created automatically
% by the yarpdatadumper, named as leftArm, rightLeg, etc. This
% function needs the path where you saved the dataDumper data.
% It automatically generates the plots and saves them as PNG.
%
% example of use:
% analyze_joints('/home/icub/data')
% analyze_joints('/Volumes/NO NAME/data_debug') 
%
% author: Serena Ivaldi - serena.ivaldi@inria.fr
% Copyright: Cecill Licence



function analyze_joints_icub_description(datadumper_path)
% example: datadumper_path='/Volumes/NO NAME/data_debug_FTS';

plot_each_limb=false;
plot_each_sensor=true;

fullFileName=strcat(datadumper_path,'/head/data.log');
if exist(fullFileName, 'file')
    [jointsHE,NjointsHE] = load_joints_data (fullFileName);
    if(plot_each_limb==true) 
        plot_joints(jointsHE, NjointsHE, 'heads','head_joints.png'); 
    end
else
    disp('not found head data');
end

fullFileName=strcat(datadumper_path,'/torso/data.log');
if exist(fullFileName, 'file')
    [jointsTO,NjointsTO] = load_joints_data (fullFileName);
    if(plot_each_limb==true) 
        plot_joints(jointsTO, NjointsTO, 'torso','torso_joints.png');
    end
else
    disp('not found torso data');
end


fullFileName=strcat(datadumper_path,'/leftArm/data.log');
if exist(fullFileName, 'file')
    [jointsLA,NjointsLA] = load_joints_data (fullFileName);
    if(plot_each_limb==true) 
        plot_joints_arm(jointsLA, NjointsLA, 'left arm', 'left hand','left_arm_joints.png','left_hand_joints.png');
    end
else
    disp('not found left arm data');
end

fullFileName=strcat(datadumper_path,'/rightArm/data.log');
if exist(fullFileName, 'file')
    [jointsRA,NjointsRA] = load_joints_data (fullFileName);
    if(plot_each_limb==true) 
        plot_joints_arm(jointsRA, NjointsRA, 'right arm', 'right hand', 'right_arm_joints.png','right_hand_joints.png');
    end
else
    disp('not found right arm data');
end

fullFileName=strcat(datadumper_path,'/leftLeg/data.log');
if exist(fullFileName, 'file')
    [jointsLL,NjointsLL] = load_joints_data (fullFileName);
    if(plot_each_limb==true) 
        plot_joints(jointsLL, NjointsLL, 'left leg','left_leg_joints.png');
    end
else
    disp('not found left leg data');
end

fullFileName=strcat(datadumper_path,'/rightLeg/data.log');
if exist(fullFileName, 'file')
    [jointsRL,NjointsRL] = load_joints_data (fullFileName);
    if(plot_each_limb==true) 
        plot_joints(jointsRL, NjointsRL, 'right leg','right_leg_joints.png');
    end
else
    disp('not found right leg data');
end

fullFileName=strcat(datadumper_path,'/waist/data.log');
if exist(fullFileName, 'file')
    [jointsWA,NjointsWA] = load_joints_data (fullFileName);
    if(plot_each_limb==true) 
        plot_waist(jointsWA, NjointsWA, 'waist','waist.png','onlyPos');
    end
else
    disp('not found waist data');
end

fullFileName=strcat(datadumper_path,'/rightFootAnalog/data.log');
if exist(fullFileName, 'file')
    [jointsRF_FTS,NjointsRF_FTS] = load_joints_data (fullFileName);
    if(plot_each_sensor==true) 
        plot_FTsensor(jointsRF_FTS, NjointsRF_FTS, 'right foot FTS','right_foot_FTS.png');
    end
else
    disp('not found right foot analog data');
end

fullFileName=strcat(datadumper_path,'/leftFootAnalog/data.log');
if exist(fullFileName, 'file')
    [jointsLF_FTS,NjointsLF_FTS] = load_joints_data (fullFileName);
    if(plot_each_sensor==true) 
        plot_FTsensor(jointsLF_FTS, NjointsLF_FTS, 'left foot FTS','left_foot_FTS.png');
    end
else
    disp('not found left foot analog data');
end


plot_joints_compare_joints(jointsLL, jointsRL, NjointsLL, 'Legs joints', 'compare_legs_joints.png');
plot_joints_compare_FTsensor(jointsLF_FTS, jointsRF_FTS, NjointsLF_FTS, 'Feet FTS', 'compare_foot_FTS.png');

t_start=[800 3788 7300];
t_end=t_start+1000;
t_labels={'aluminium', 'wood', 'steel'};

plot_joints_compare_joints_episodes(jointsTO, NjointsTO, t_start, t_end, t_labels, 'Torso joints', 'compare_torso_grounds.png');
plot_joints_compare_joints_episodes(jointsLL, NjointsLL, t_start, t_end, t_labels, 'Left leg joints', 'compare_left_leg_grounds.png');
plot_joints_compare_joints_episodes(jointsRL, NjointsRL, t_start, t_end, t_labels, 'Right leg joints', 'compare_right_leg_grounds.png');
plot_joints_compare_FTsensor_episodes(jointsLF_FTS, NjointsLF_FTS, t_start, t_end, t_labels, 'Left foot FTS', 'compare_left_foot_FTS_grounds.png');
plot_joints_compare_waist_episodes(jointsWA, NjointsWA, t_start, t_end, t_labels, 'Waist position', 'compare_waist_grounds.png', 'onlyPos')


end


%%%%%%%%%%%%%%%%%% UTILITIES FUNCTIONS FOR PLOTTING %%%%%%%%%%%%%%%%%%%%%%

function [FTlabel] = FTsensorLabel(i)

    if i==1
        FTlabel = 'Fx [N]';
    elseif i==2 
        FTlabel = 'Fy [N]';
    elseif i==3
        FTlabel = 'Fz [N]';
    elseif i==4
        FTlabel = 'Mx [Nm]';
    elseif i==5
        FTlabel = 'My [Nm]';
    elseif i==6
        FTlabel = 'Mz [Nm]';
    else
        FTlabel = 'impossible';
    end
end

function [Walabel] = WaistLabel(i)

    if i==1
        Walabel = 'x [m]';
    elseif i==2 
        Walabel = 'y [m]';
    elseif i==3
        Walabel = 'z [m]';
    elseif i==4
        Walabel = 'q1';
    elseif i==5
        Walabel = 'q2';
    elseif i==6
        Walabel = 'q3';
    elseif i==7
        Walabel = 'q4';
    else
        Walabel = 'impossible';
    end
end

function [joints,Njoints] = load_joints_data (fullFileName)
    joints = load(fullFileName);
    [nsamples,dim]=size(joints);
    Njoints=dim-2;
end

function plot_joints(joints, Njoints, name, filename)
   
    %iter_data = joints(:,1);  %not used
    %time = joints(:,2);       %not used
    for i=1:Njoints
        j{i}=joints(:,i+2);
    end
   
    figure;
    for i=1:Njoints
        subplot(Njoints,1,i);
        plot(j{i},'r'); 
        ylabel(strcat('j',num2str(i-1),' [deg]'));
        if i==1
            title(name);
        end
        xlabel(strcat('mean = ',num2str(mean(j{i})),'std = ',num2str(std(j{i}))))
    end
    
    saveas(gcf,filename,'png');

end

function plot_FTsensor(joints, Njoints, name, filename)
   
    %iter_data = joints(:,1);  %not used
    %time = joints(:,2);       %not used
    for i=1:Njoints
        j{i}=joints(:,i+2);
    end
   
    figure;
    for i=1:Njoints
        subplot(Njoints,1,i);
        plot(j{i},'r'); 
        ylabel(FTsensorLabel(i));
        if i==1
            title(name);
        end
        xlabel(strcat('mean = ',num2str(mean(j{i})),'std = ',num2str(std(j{i}))))
    end
    
    saveas(gcf,filename,'png');

end

function plot_waist(joints, Njoints, name, filename, onlyPos)
   
    if onlyPos == 'onlyPos'
        NjointsTrue = 3;
    else
        NjointsTrue = Njoints;
    end
    
    %iter_data = joints(:,1);  %not used
    %time = joints(:,2);       %not used
    for i=1:NjointsTrue
        j{i}=joints(:,i+2);
    end
   
    figure;
    for i=1:NjointsTrue
        subplot(NjointsTrue,1,i);
        plot(j{i},'r'); 
        ylabel(WaistLabel(i));
        if i==1
            title(name);
        end
        xlabel(strcat('mean = ',num2str(mean(j{i})),'std = ',num2str(std(j{i}))))
    end
    
    saveas(gcf,filename,'png');

end

function plot_joints_arm(joints, Njoints, nameArm, nameHand, filenameArm, filenameHand)
   
    %iter_data = joints(:,1);  %not used
    %time = joints(:,2);       %not used
    for i=1:Njoints
        j{i}=joints(:,i+2);
    end
   
    figure;
    for i=1:7
        subplot(7,1,i);
        plot(j{i},'r'); 
        ylabel(strcat('j',num2str(i-1),' [deg]'));
        if i==1
            title(nameArm);
        end
        xlabel(strcat('mean = ',num2str(mean(j{i})),'std = ',num2str(std(j{i}))))
    end
    
    saveas(gcf,filenameArm,'png');
    
    figure;
    for i=8:Njoints
        subplot(Njoints-7,1,i-7);
        plot(j{i},'r'); 
        ylabel(strcat('j',num2str(i-1),' [deg]'));
        if i==8
            title(nameHand);
        end
        xlabel(strcat('mean = ',num2str(mean(j{i})),'std = ',num2str(std(j{i}))))
    end
    
    saveas(gcf,filenameHand,'png');


end

function plot_joints_compare_joints(jointsLL, jointsRL, Njoints, titleFig, filename)
   
    %align data in time
    %supposed ok for the moment since they start together
    
    %min lenght of the two
    eqsize=min(length(jointsLL(:,1)),length(jointsRL(:,1))); 
    
    %iter_data = joints(:,1);  %not used
    %time = joints(:,2);       %not used
    for i=1:Njoints
        jLL{i}=jointsLL(1:eqsize,i+2);
        jRL{i}=jointsRL(1:eqsize,i+2);
    end
   
    figure;
    for i=1:Njoints
        subplot(Njoints,1,i);
        plot(jLL{i},'r');
        hold;
        plot(jRL{i},'b');
        ylabel(strcat('j',num2str(i-1),' [deg]'));
        if i==1
            title(titleFig);
            legend('left leg','right leg');
        end
        error=[];
        error=jLL{i}-jRL{i};
        RMSE=sqrt(mean(error.^2));
        xlabel(strcat('mean = ',num2str(mean(error)),'  std = ',num2str(std(error)),'  RMSE = ',num2str(RMSE)))
    end
    
    saveas(gcf,filename,'png');

end

function plot_joints_compare_FTsensor(jointsLL, jointsRL, Njoints, titleFig, filename)
   
    %align data in time
    %supposed ok for the moment since they start together
    
    %min lenght of the two
    eqsize=min(length(jointsLL(:,1)),length(jointsRL(:,1))); 
    
    %iter_data = joints(:,1);  %not used
    %time = joints(:,2);       %not used
    for i=1:Njoints
        jLL{i}=jointsLL(1:eqsize,i+2);
        jRL{i}=jointsRL(1:eqsize,i+2);
    end
   
    figure;
    for i=1:Njoints
        subplot(Njoints,1,i);
        plot(jLL{i},'r');
        hold;
        plot(jRL{i},'b');
        ylabel(FTsensorLabel(i));
        if i==1
            title(titleFig);
            legend('left leg','right leg');
        end
        error=[];
        error=jLL{i}-jRL{i};
        RMSE=sqrt(mean(error.^2));
        xlabel(strcat('mean = ',num2str(mean(error)),'  std = ',num2str(std(error)),'  RMSE = ',num2str(RMSE)))
    end
    
    saveas(gcf,filename,'png');

end

function plot_joints_compare_joints_episodes(joints, Njoints, t_start, t_end, t_labels, titleFig, filename)

    Nepisodes = length(t_start);
    colors = distinguishable_colors(Nepisodes);
        
    %iter_data = joints(:,1);  %not used
    %time = joints(:,2);       %not used
    for i=1:Njoints
        j{i}=joints(:,i+2);
    end
   
    figure; 
    for i=1:Njoints
        
        subplot(Njoints,1,i);
        
        for n=1:Nepisodes 
            if(n==2)
                hold;
            end
            plot(j{i}(t_start(n):t_end(n)),'Color',colors(n,:));     
        end
        
        ylabel(strcat('j',num2str(i-1),' [deg]'));
        if i==1
            title(titleFig);
            legend(t_labels);
        end
        
        xlabel('time')
    end
    
    saveas(gcf,filename,'png');
    
end

function plot_joints_compare_FTsensor_episodes(joints, Njoints, t_start, t_end, t_labels, titleFig, filename)

    Nepisodes = length(t_start);
    colors = distinguishable_colors(Nepisodes);
        
    %iter_data = joints(:,1);  %not used
    %time = joints(:,2);       %not used
    for i=1:Njoints
        j{i}=joints(:,i+2);
    end
   
    figure; 
    for i=1:Njoints
        
        subplot(Njoints,1,i);
        
        for n=1:Nepisodes 
            if(n==2)
                hold;
            end
            plot(j{i}(t_start(n):t_end(n)),'Color',colors(n,:));     
        end
        
        ylabel(FTsensorLabel(i));
        
        if i==1
            title(titleFig);
            legend(t_labels);
        end
        
        xlabel('time')
    end
    
    saveas(gcf,filename,'png');
    
end

function plot_joints_compare_waist_episodes(joints, Njoints, t_start, t_end, t_labels, titleFig, filename, onlyPos)

 if onlyPos == 'onlyPos'
        NjointsTrue = 3;
    else
        NjointsTrue = Njoints;
 end
    
    Nepisodes = length(t_start);
    colors = distinguishable_colors(Nepisodes);
        
    %iter_data = joints(:,1);  %not used
    %time = joints(:,2);       %not used
    for i=1:NjointsTrue
        j{i}=joints(:,i+2);
    end
   
    figure; 
    for i=1:NjointsTrue
        
        subplot(NjointsTrue,1,i);
        
        for n=1:Nepisodes 
            if(n==2)
                hold;
            end
            plot(j{i}(t_start(n):t_end(n)),'Color',colors(n,:));     
        end
        
        ylabel(WaistLabel(i));
        
        if i==1
            title(titleFig);
            legend(t_labels);
        end
        
        xlabel('time')
    end
    
    saveas(gcf,filename,'png');
    
end

