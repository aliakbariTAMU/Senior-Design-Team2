clc;
clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%  VICON  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
filename = 'Ben_Johnston Cal 11.csv';
V_Data = xlsread(filename, 'A12:N1568');

pnts_shoulder(:,1) = V_Data(:,12);           %base points
pnts_shoulder(:,2) = V_Data(:,13);
pnts_shoulder(:,3) = V_Data(:,14);

pnts_upper(:,1) = V_Data(:,9);          %upper points
pnts_upper(:,2) = V_Data(:,10);
pnts_upper(:,3) = V_Data(:,11);

% y_zunit = ([0 -1 0]);

Vic_frames = V_Data(:,1);


v_pntpnt = pnts_shoulder - pnts_upper;      %point to point vector
z_zunit = ([0 0 1]);           %create z unit vector
y_zunit = v_pntpnt(1,:)./norm(v_pntpnt(1,:)); 
iterator_a=1;
v_length = size(v_pntpnt);
l = v_length(1,1);
while iterator_a<l
v_pnt_norm = v_pntpnt(iterator_a,:)./norm(v_pntpnt(iterator_a,:));
iterator_a = iterator_a+1;
v_sag_vect(iterator_a,:) = cross(v_pnt_norm, z_zunit);
arg_check(iterator_a,:) = dot(v_pnt_norm, y_zunit);
theta(iterator_a,:) = acos(dot(v_pnt_norm,y_zunit));
phi(iterator_a,:) = acos(dot(v_pnt_norm,y_zunit));
phi_check(iterator_a,:) = acos(dot(v_sag_vect(iterator_a),v_sag_vect(iterator_a-1)));
end
for i=1:length(phi)
    if v_pntpnt(i,1)>y_zunit(1)
        phi(i)=-1*(phi(i));
    end
end



phi = (pi/2)-phi;
phi_deg = abs(phi.*(180/pi));
phi_deg = phi_deg-90;

% for i=1:length(phi_deg)
%     if v_pntpnt(i,2)<-24
%         phi_deg(i)=-1*((phi_deg(i))+180);
%     end
% end

% alpha_deg = real(alpha_deg_img);
%Syncing
[Vic_pks, Vic_locs] = findpeaks(phi_deg, 'MinPeakProminence', 2);
Vic_peak_beg = Vic_locs(1);
Vic_peak_end = Vic_locs(end);

Frames_used = Vic_frames(Vic_peak_end)-Vic_frames(Vic_peak_beg);

Vic_time = (Frames_used)/100;
Vic_plot_yaxis = phi_deg(Vic_peak_beg:Vic_peak_end);
Vic_plot_xaxis = 0:Vic_time/(Frames_used):Vic_time;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  IMUs  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%NOTE:
%Need to import GyroZ and Ltime columns from Bapgui

filenameSMid = 'T11S1.txt';
filenameSBase = 'T11S2.txt';
delimiterIn = ' ';
headerlinesIn_IMU = 1;
SMid = importdata(filenameSMid, delimiterIn, headerlinesIn_IMU);
SBase = importdata(filenameSBase, delimiterIn, headerlinesIn_IMU);

%Program reports data using the z-axis of the gyroscope
%including angular position, velocity, acceleration and jerk,
%includes correction factor

%import data
gyroMid(:,1) = (SMid.data(:,4))./32.75;  
gyroMid(:,2) = (SMid.data(:,5))./32.75;  
gyroMid(:,3) = (SMid.data(:,6))./32.75;          %Gyroscope correction factor
gyroBase(:,1) = (SBase.data(:,4))./32.75;  
gyroBase(:,2) = (SBase.data(:,5))./32.75;  
gyroBase(:,3) = (SBase.data(:,6))./32.75;          %Gyroscope correction factor
LtimeMid = (SMid.data(:,10));
LtimeBase = (SBase.data(:,10));
tMid = transpose((LtimeMid-LtimeMid(1))./1000);     %relative to start time, ms to s
tBase = transpose((LtimeBase-LtimeBase(1))./1000);



%*******low pass filter*****
x_filter = designfilt('lowpassiir','FilterOrder',3,...
            'PassbandFrequency',10e3,'PassbandRipple',0.5,...
            'SampleRate',200e3);
gyroMid = filtfilt(x_filter,gyroMid);
gyroBase = filtfilt(x_filter,gyroBase);


%best fit code
%t3(:,1) = transpose(t);
%t3(:,2) = transpose(t);
%t3(:,3) = transpose(t);
%p1 = polyfit(t3,gyro,1);
%c_velocity = transpose(polyval(p1,t));      %best fit line of velocity data


%kinect corrections
%IMU_coeff = polyfit(transpose(IMU_plot_x),IMU_plot_func,1);
%IMU_bestfit = transpose(polyval(IMU_coeff,IMU_plot_x));

%mean_kinect = mean(Kin_plot_func);
%mean_kinect_line = ones([length(Kin_plot_func),1]);
%mean_kinect_line = mean_kinect_line .* mean_kinect;

%IMU_fusion = IMU_bestfit.*(-1);
%IMU_fusion = IMU_fusion + mean_kinect;
%IMU_corrected_func = IMU_plot_func + IMU_fusion;
%mean_IMU_line = ones([length(IMU_plot_func),1]).*mean_kinect;



%differentiation and integration
accelerationMid = diff(gyroMid);             % vel to accel 
accelerationMid = [0,[1 3];accelerationMid];
jerkMid = diff(accelerationMid);             %accel to jerk
jerkMid = [0,[1 3];jerkMid];
positionMid = trapz(tMid,gyroMid);
distanceMid = cumtrapz(tMid,gyroMid);     % vel to distance
distanceMid(:,2) = distanceMid(:,2) + 90;

accelerationBase = diff(gyroBase);             % vel to accel 
accelerationBase = [0,[1 3];accelerationBase];
jerkBase = diff(accelerationBase);             %accel to jerk
jerkBase = [0,[1 3];jerkBase];
positionBase = trapz(tBase,gyroBase);
distanceBase = cumtrapz(tBase,gyroBase);     % vel to distance
distanceBase(:,2) = distanceBase(:,2) + 90;

[SMid_pks , SMid_locs] = findpeaks(distanceMid(:,1), 'MinPeakProminence', 2);

% plot(tMid, distanceMid(:,2), tMid(SMid_locs), SMid_pks, 'or');

IMU_str2end_frame = SMid_locs(end)-SMid_locs(1);
IMU_str2end_time = tMid(SMid_locs(end))-tMid(SMid_locs(1));
IMU_timesteps = IMU_str2end_time/IMU_str2end_frame;

IMU_prev_time = IMU_str2end_time;
IMU_prev_frms = 2/IMU_timesteps;

SMid_y_axis = distanceMid(:,1);

SMid_peak_beg = SMid_locs(1);
SMid_peak_end = SMid_locs(end);

% 
% Frames_used = Vic_frames(Vic_peak_end)-Vic_frames(Vic_peak_beg);
% 
SMid_time = IMU_prev_time;
SMid_plot_yaxis = SMid_y_axis(SMid_peak_beg:SMid_peak_end);
SMid_plot_xaxis = 0:SMid_time/(SMid_peak_end-SMid_peak_beg):SMid_time;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  KINECT  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

filename1_Kin = 'spineshoulderT11.txt';
filename2_Kin = 'spinemidT11.txt';
delimiterIn = ' ';
headerlinesIn_Kin = 0;
spineShoulderData = importdata(filename1_Kin, delimiterIn, headerlinesIn_Kin);
spinemidData = importdata(filename2_Kin, delimiterIn, headerlinesIn_Kin);

time = spineShoulderData.data(:,1);
time = time - time(1);
time = transpose(time./1000);

pnts_shoulder_Kin(:,1) = str2double(spineShoulderData.textdata(:,1));          %base points
pnts_shoulder_Kin(:,2) = str2double(spinemidData.textdata(:,2));
pnts_shoulder_Kin(:,3) = str2double(spineShoulderData.textdata(:,3));

pnts_upper_Kin(:,1) = str2double(spinemidData.textdata(:,1));         %upper points
pnts_upper_Kin(:,2) = str2double(spinemidData.textdata(:,2));
pnts_upper_Kin(:,3) = str2double(spinemidData.textdata(:,3));

kinect_xunit = ([1 0 0]);            %create z unit vector

kinect_pntpnt = pnts_shoulder_Kin - pnts_upper_Kin;      %point to point vector

iterator_a=1;
kinect_length = size(kinect_pntpnt);
l = kinect_length(1,1);
while iterator_a<l
kinect_pnt_norm = kinect_pntpnt(iterator_a,:)./norm(kinect_pntpnt(iterator_a,:));
iterator_a = iterator_a+1;
theta_Kin(iterator_a,:) = acos(dot(kinect_pnt_norm,kinect_xunit));
end
alpha_Kin = (pi/2)-theta_Kin;
alpha_deg_Kin = alpha_Kin.*(180/pi);

kin_filter = designfilt('lowpassiir','FilterOrder',3,...
            'PassbandFrequency',15e3,'PassbandRipple',0.5,...
            'SampleRate',200e3);

alpha_deg_Kin_filt = filtfilt(kin_filter, alpha_deg_Kin);

[Kin_pks , Kin_locs] = findpeaks(alpha_deg_Kin_filt, 'MinPeakProminence', 2);

Kin_Frames=Kin_locs(end)-Kin_locs(1);
Kin_time_diff = time(Kin_locs(end))-time(Kin_locs(1));
Kin_time_step = Kin_time_diff/Kin_Frames;
Kin_added_time = round(2/.0333);



Kin_pks_begin = Kin_locs(1);
Kin_pks_end = Kin_locs(end);

Kin_plot_time = 0:Kin_time_diff/(Kin_locs(end)-Kin_locs(1)):Kin_time_diff;
% Kin_plot_time(end+1) = 13.06;
Kin_plot_y = alpha_deg_Kin_filt(Kin_pks_begin:Kin_pks_end);
%plot(Kin_plot_time, Kin_plot_y)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Parameters  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

phi_deg_filt = filtfilt(kin_filter, phi_deg);

%%%%% First Derivative for flex (Angular Velocity)
VPosderiv = diff(phi_deg_filt);
VTimderiv = diff(Vic_frames./100);
VVel = VPosderiv./VTimderiv;

%%%%% Velocity Filter
VVelFilt = designfilt('lowpassiir','FilterOrder',3,...
            'PassbandFrequency',15e3,'PassbandRipple',0.5,...
            'SampleRate',200e3);

%%%%% Second Derivative for flex (Angular Acceleration)
VVelderiv = diff(VPosderiv);
VAcc = VVelderiv./VTimderiv(1:1555);

%%%%% Acceleration Filter
VAccFilt = designfilt('lowpassiir','FilterOrder',3,...
            'PassbandFrequency',5e3,'PassbandRipple',0.5,...
            'SampleRate',200e3);
VAcc_Filtered = filtfilt(VAccFilt,VAcc);

%%%%% Third Derivative for flex (Angular Jerk)
VAccderiv = diff(VVelderiv);
VJer = VAccderiv./VTimderiv(1:1554);

%%%%% Jerk Filter
VJerFilt = designfilt('lowpassiir','FilterOrder',3,...
            'PassbandFrequency',10e3,'PassbandRipple',0.5,...
            'SampleRate',200e3);
VJer_Filtered = filtfilt(VJerFilt,VJer);

%%%%% Plotting
subplot(4,1,1)
plot(Vic_frames./100,phi_deg_filt)
title('Vicon Parameters')
ylabel('degrees'),xlabel('Time (s)')

subplot(4,1,2)
plot(Vic_frames(1:1556)./100,VVel)
ylabel('degrees/s'),xlabel('Time (s)')

subplot(4,1,3)
plot(Vic_frames(1:1555)./100,VAcc_Filtered)
ylim([-11 11])
ylabel('degrees/s^2'),xlabel('Time (s)')

subplot (4,1,4)
plot(Vic_frames(1:1554)./100,VJer_Filtered)
ylim([-14 14])
ylabel('degrees/s^3'),xlabel('Time (s)')

%%%%% Maximums
VVel_abs = abs(VVel);
VAcc_abs = abs(VAcc(2:1549));
VJer_abs = abs(VJer(2:1548));

VVel_max = max(VVel_abs)
VAcc_max = max(VAcc_abs)
VJer_max = max(VJer_abs)
hold on


%%%%%%%%%%%%%%%%%%%%%%%%%%%  PLOTTING  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% phi_deg_filt = filtfilt(kin_filter, phi_deg);

% plot(Vic_frames./100,phi_deg_filt)%,SMid_plot_xaxis, SMid_plot_yaxis,Vic_frames./100,v_pntpnt(:,1),Vic_frames./100,v_pntpnt(:,2))

title('Sagittal Rotation')
ylabel('Angle (degrees)'),xlabel('Time (s)')

% 
% subplot(2,1,2)
% plot(Vic_frames, phi_check)

% plot(Vic_frames, v_pntpnt(:,1),Vic_frames, v_pntpnt(:,2),Vic_frames,v_pntpnt(:,3))
% hold on

% arg_check_x = 0:1:1440;
% subplot(2,1,2)
% plot(arg_check_x(),arg_check(90:1530))
% xlim([0 1440])
% xlim([0 SMid_time])
% ylabel('y'),xlabel('Time (s)')


%subplot(3,1,3)
%plot(tMid,distanceMid(:,3), tBase,distanceBase(:,3))
%ylabel('z'),xlabel('Time (s)')

SMid_plot_yaxis = resample(SMid_plot_yaxis,length(Vic_plot_yaxis),length(SMid_plot_yaxis));
SMid_plot_xaxis = resample(SMid_plot_xaxis,length(Vic_plot_xaxis),length(SMid_plot_xaxis));
Kin_plot_y = resample(Kin_plot_y,length(Vic_plot_yaxis),length(Kin_plot_y));
Kin_plot_time = resample(Kin_plot_time,length(Vic_plot_xaxis),length(Kin_plot_time));

angleRMSE_IMU = sqrt(mean((Vic_plot_yaxis - SMid_plot_yaxis).^2))
angleRMSE_Kin = sqrt(mean((Vic_plot_yaxis - Kin_plot_y).^2))