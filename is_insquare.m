function insquare = is_insquare(x, y, xmax, ymax)

insquare = true;
if x > xmax || y > ymax || x < 0 || y < 0
    insquare = false;
end