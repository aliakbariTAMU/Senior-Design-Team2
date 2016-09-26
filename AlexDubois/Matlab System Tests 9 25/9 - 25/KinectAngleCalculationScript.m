filename1 = 'spinebaseT1.txt';
filename2 = 'spinemidT1.txt';
delimiterIn = ' ';
headerlinesIn = 0;
spinebaseData = importdata(filename1, delimiterIn, headerlinesIn);
spinemidData = importdata(filename2, delimiterIn, headerlinesIn);

time = spinebaseData.data(:,1);
time = time - time(1);
time = time./1000;

pnts_base(:,1) = str2double(spinebaseData.textdata(:,1));          %base points
pnts_base(:,2) = str2double(spinebaseData.textdata(:,2));
pnts_base(:,3) = str2double(spinebaseData.textdata(:,3));

pnts_upper(:,1) = str2double(spinemidData.textdata(:,1));         %upper points
pnts_upper(:,2) = str2double(spinemidData.textdata(:,2));
pnts_upper(:,3) = str2double(spinemidData.textdata(:,3));

kinect_yunit = ([0 1 0]);            %create z unit vector

kinect_pntpnt = pnts_upper - pnts_base;      %point to point vector

iterator_a=1;
kinect_length = size(kinect_pntpnt);
l = kinect_length(1,1);
while iterator_a<l
kinect_pnt_norm = kinect_pntpnt(iterator_a,:)./norm(kinect_pntpnt(iterator_a,:));
iterator_a = iterator_a+1;
theta(iterator_a,:) = acos(dot(kinect_pnt_norm,kinect_yunit));
end
alpha = (pi/2)-theta;
alpha_deg = alpha.*(180/pi);
plot(time,alpha_deg)