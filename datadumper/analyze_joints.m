% analyze_joints(datadumper_path)
% 
% Analyze the data of joints of iCub, dumped by datadumper. 
% Data should be recorded as data.log in the folders created automatically
% by the dataDumper, named as leftArm, rightLeg, etc. This
% function needs the path where you saved the dataDumper data.
% It automatically generates the plots and saves them as PNG.
%
% example of use:
% analyze_joints('/home/icub/data')
% analyze_joints('/Volumes/NO NAME/data_debug') 
%
% author: Serena Ivaldi - serena.ivaldi@inria.fr
% Copyright: Cecill Licence



function analyze_joints(datadumper_path)
% example: datadumper_path='/Volumes/NO NAME/data_debug_FTS';

fullFileName=strcat(datadumper_path,'/head/data.log');
if exist(fullFileName, 'file')
    [joints,Njoints] = load_joints_data (fullFileName);
    plot_joints(joints, Njoints, 'heads','head_joints.png')
else
    disp('not found head data')
end

fullFileName=strcat(datadumper_path,'/torso/data.log');
if exist(fullFileName, 'file')
    [joints,Njoints] = load_joints_data (fullFileName);
    plot_joints(joints, Njoints, 'torso','torso_joints.png')
else
    disp('not found torso data')
end


fullFileName=strcat(datadumper_path,'/leftArm/data.log');
if exist(fullFileName, 'file')
    [joints,Njoints] = load_joints_data (fullFileName);
    plot_joints(joints, Njoints, 'left arm','left_arm_joints.png')
else
    disp('not found left arm data')
end

fullFileName=strcat(datadumper_path,'/rightArm/data.log');
if exist(fullFileName, 'file')
    [joints,Njoints] = load_joints_data (fullFileName);
    plot_joints(joints, Njoints, 'right arm','right_arm_joints.png')
else
    disp('not found right arm data')
end

fullFileName=strcat(datadumper_path,'/leftLeg/data.log');
if exist(fullFileName, 'file')
    [joints,Njoints] = load_joints_data (fullFileName);
    plot_joints(joints, Njoints, 'left leg','left_leg_joints.png')
else
    disp('not found left leg data')
end

fullFileName=strcat(datadumper_path,'/rightLeg/data.log');
if exist(fullFileName, 'file')
    [joints,Njoints] = load_joints_data (fullFileName);
    plot_joints(joints, Njoints, 'right leg','right_leg_joints.png')
else
    disp('not found right leg data')
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
