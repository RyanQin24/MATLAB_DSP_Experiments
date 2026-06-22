data = readmatrix('NewFiae.csv', 'NumHeaderLines', 2);
dt = 2e-7; 
t = data(:,1)*dt;
scl = data(:,2);
sda = data(:,3);


address_payload = zeros(1,7);
Read_Flag = true;
ACK1 = false;
data_payload = zeros(1,8);
ACK2 = false;
thresh = 3;
thresh2 = 1.5;

plot(t, scl)
hold on
plot(t, sda)
hold off


xlabel('Time (s)')
ylabel('Voltage (V)')
legend('SCL', 'SDA')
grid on

index = 1;
while (scl(index) > thresh)
    index = index + 1;
end
counter = 0;

%address parsing
while counter < 7
    if scl(index) > thresh;
        address_payload(counter + 1) = sda(index) > thresh;
        counter = counter + 1;
        while(scl(index) >= thresh);
            index = index + 1;
        end
    else
        index = index + 1;
    end
end

%R/W parsing
while (scl(index) <= thresh)
    index = index + 1;
end
Read_Flag = sda(index) > thresh;
while(scl(index) >= thresh);
    index = index + 1;
end

%ack parsing
while (scl(index) <= thresh)
    index = index + 1;
end
ACK1 = sda(index) < thresh;
while(scl(index) >= thresh2);
    index = index + 1;
end

counter = 0;

%data parsing
while counter < 8
    if scl(index) > thresh2
        data_payload(counter + 1) = sda(index) > thresh;
        counter = counter + 1;
        while(scl(index) >= thresh2);
            index = index + 1;
        end
    else
        index = index + 1;
    end
end

%ack parsing
while (scl(index) <= thresh2)
    index = index + 1;
end
ACK2 = sda(index) < thresh;