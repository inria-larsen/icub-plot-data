% analyze_FTS(datadumper_path)
% 
% Analyze the data of the FTS sensors of iCub, dumped by datadumper. 
% Data should be recorded as data.log in the folders created automatically
% by the dataDumper, named as leftArmFTS, rightArmFTS, etc. This
% function only needs the path where you saved the dataDumper data; it
% automatically generates the plots and saves them as PNG.
%
% example of use:
% analyze_FTS('/home/icub/data')
% analyze_FTS('/Volumes/NO NAME/data_debug_FTS') 
%
% author: Serena Ivaldi - serena.ivaldi@inria.fr
% Copyright: Cecill Licence



function analyze_FTS(datadumper_path)
% example: datadumper_path='/Volumes/NO NAME/data_debug_FTS';

[FTS_LA, FTS_RA, FTS_LL, FTS_RL] = load_FTS_data (datadumper_path);
plot_FTS(FTS_LA, 'left arm FTS','left_arm_FTS.png')
plot_FTS(FTS_RA, 'right arm FTS','right_arm_FTS.png')
plot_FTS(FTS_LL, 'left leg FTS','left_leg_FTS.png')
plot_FTS(FTS_RL, 'right leg FTS','right_leg_FTS.png')

end


function [FTS_LA, FTS_RA, FTS_LL, FTS_RL] = load_FTS_data (datadumper_path)
    FTS_LA = load(strcat(datadumper_path,'/leftArmFTS/data.log'));
    FTS_RA = load(strcat(datadumper_path,'/rightArmFTS/data.log'));
    FTS_LL = load(strcat(datadumper_path,'/leftLegFTS/data.log'));
    FTS_RL = load(strcat(datadumper_path,'/rightLegFTS/data.log'));
end


function plot_FTS(FTS, name, filename)
   
    %iter_data = FTS(:,1);  %not used
    %time = FTS(:,2);       %not used
    fx=FTS(:,3);
    fy=FTS(:,4);
    fz=FTS(:,5);
    mx=FTS(:,6);
    my=FTS(:,7);
    mz=FTS(:,8);
    

    figure;
    subplot(2,1,1);
    plot(fx,'r'); hold;
    plot(fy,'g');
    plot(fz,'b');
    ylabel('force [N]');
    title(name);
    xlabel(strcat('mean = ',num2str(mean(fx)),'; ', num2str(mean(fy)),'; ', num2str(mean(fz))))
    legend('fx','fy','fz');

    subplot(2,1,2);
    plot(mx,'r'); hold;
    plot(my,'g');
    plot(mz,'b');
    ylabel('moment [Nm]');
    xlabel(strcat('mean = ',num2str(mean(mx)),'; ', num2str(mean(my)),'; ', num2str(mean(mz))))
    legend('mx','my','mz');
    
    saveas(gcf,filename,'png');

end
