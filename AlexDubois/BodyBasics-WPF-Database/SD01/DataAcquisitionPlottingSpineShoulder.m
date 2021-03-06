filename = 'spineshoulder.txt';
delimiterIn = ' ';
headerlinesIn = 0;
A = importdata(filename, delimiterIn, headerlinesIn);
SpineShoulderX = str2double(A.textdata(:,1));
SpineShoulderY = str2double(A.textdata(:,2));
SpineShoulderZ = str2double(A.textdata(:,3));
x = 1:length(SpineShoulderX);
subplot(3, 1, 1), plot(SpineShoulderX), ylabel('Position');
subplot(3, 1, 2), plot(SpineShoulderY), ylabel('Position');
subplot(3, 1, 3), plot(SpineShoulderZ), ylabel('Position');
xlabel('Sample');