function [Year, Mon, Day, hour, minut, sec] = produce_timestring(Year, Mon, Day, hour, minut, sec)

minut = minut+1;
if minut == 60
    minut = 0;
    hour = hour+1;
    if hour == 24
        hour = 0;
        Day = Day+1;
    end
end
