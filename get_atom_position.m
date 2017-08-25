function [atom_in, numatom] = get_atom_position(xmax, ymax, A0, theta, xindent, yindent)
% atom position
xnum = floor(3*xmax / (A0*sqrt(3))) + 1;
ynum = floor(3*ymax / (A0*(0.75))) + 1;
atom = zeros(xnum*ynum, 2);
dist1 = A0*sqrt(3);

% generate atoms distribution larger than xmax*ymax rectangular, for rotation
for i = 0: ynum-1
    for j = 1: xnum
       % x coordinate
        if i == 0 
           atom(j+i*xnum, 1) = dist1*0.5 + (j-1)*dist1;
           atom(j+i*xnum, 2) = 0;
           continue
        else
          if mod(i, 4) == 1
             atom(j+i*xnum, 1) = (j-1)*dist1;
          end
          if mod(i, 4) == 2 
             atom(j+i*xnum, 1) = atom(j+(i-1)*xnum, 1);
          end
          if mod(i, 4) == 3 
             atom(j+i*xnum, 1) = atom(j, 1);
          end
          if mod(i, 4) == 0 
             atom(j+i*xnum, 1) = atom(j+(i-1)*xnum, 1);
          end          
        end
        % y coordinate
          if mod(i, 2) == 1
             atom(j+i*xnum, 2) = atom(j+(i-1)*xnum, 2) + 0.5*A0; 
          else
             atom(j+i*xnum, 2) = atom(j+(i-1)*xnum, 2) + A0;
          end
    end
end


down = ymax - mod(ymax, 2*A0);
left = xmax - mod(xmax, sqrt(3)*A0);
for i = 0: ynum-1
    for j = 1: xnum
        atom(j+i*xnum, 1) = atom(j+i*xnum, 1) - left;
        atom(j+i*xnum, 2) = atom(j+i*xnum, 2) - down;
    end
end
% rotation
ref = [dist1; 0.5*A0]; % rotational ref point
rotation = [cos(theta), -sin(theta); sin(theta), cos(theta)];
temp = zeros(2,1);
for i = 0: ynum-1
    for j = 1: xnum
        temp(1,1) = atom(j+i*xnum, 1);
        temp(2,1) = atom(j+i*xnum, 2);
        temp = rotation*(temp-ref) + ref;
        atom(j+i*xnum, 1) = temp(1,1);
        atom(j+i*xnum, 2) = temp(2,1);
    end
end
% indentation
for i = 0: ynum-1 
    for j = 1: xnum
        atom(j+i*xnum, 1) = atom(j+i*xnum, 1) + xindent;
        atom(j+i*xnum, 2) = atom(j+i*xnum, 2) + yindent;
    end
end

numatom = 0;
for i = 0: ynum-1
    for j = 1: xnum
        if is_insquare(atom(j+i*xnum, 1), atom(j+i*xnum, 2), xmax, ymax)
            numatom = numatom + 1;
            atom_in(numatom, 1) = atom(j+i*xnum, 1);
            atom_in(numatom, 2) = atom(j+i*xnum, 2);
        end
    end        
end


