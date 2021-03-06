filename = 'spinemid.txt';
delimiterIn = ' ';
headerlinesIn = 0;
A = importdata(filename, delimiterIn, headerlinesIn);
SpineMidX = str2double(A.textdata(:,1));
SpineMidY = str2double(A.textdata(:,2));
SpineMidZ = str2double(A.textdata(:,3));
x = 1:length(SpineMidX);
subplot(3, 1, 1), plot(SpineMidX), ylabel('Position');
subplot(3, 1, 2), plot(SpineMidY), ylabel('Position');
subplot(3, 1, 3), plot(SpineMidZ), ylabel('Position');
xlabel('Sample');