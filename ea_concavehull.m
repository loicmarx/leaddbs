function k=ea_concavehull(XYZ,thresh)
% This function tries to convert the convexhull generated by Qhull into a
% concave hull. Equally, output is in format k [n x 3] which defines n
% triangles as rows in XYZ. If the function finds a triangle that has 2
% sides whose midpoints are further away than thresh from another point in
% the pointcloud, it deletes the triangle and substitutes it with three new
% triangles that are defined by the nearest points in the datacloud to the
% old two midpoints.
%
% You can choose to use this option or to use the convhull routine in
% ea_prefs.m
% __________________________________________________________________________________
% Copyright (C) 2014 Charite University Medicine Berlin, Movement Disorders Unit
% Andreas Horn


k=convhulln(XYZ);
lines=genlines(k);

used=unique(k(:));
ix=1:size(XYZ,1);
remnants=XYZ(~ismember(ix,used),:);
backmap=find(~ismember(ix,used));

midpoints=zeros(size(lines,1),3); % midpoint of line of each triangle. ? line, xyz
midpoints(:,:)=XYZ(lines(:,1),:)+(XYZ(lines(:,2),:)-XYZ(lines(:,1),:))/2; %AB - a

maxd=inf;
cnt=1;

csearch=KDTreeSearcher(remnants);
[IDX,D]=knnsearch(csearch,midpoints);

while any(D>thresh)
    found=0;
    
    line=find(D==max(D(:)));
    line=line(1); % use only first entry of max.
    
    
    beta=backmap(IDX(line)); % new point to be inserted.
    
    A=lines(line,1);
    B=lines(line,2);
    
    
    
    
    
    
    % determine which triangles use line AB
    
    check=(k==A)+(k==B);
    tix=sum(check,2)==2;
    tris=k(tix,:);
    

    
    
    CD=tris(~(ismember(tris,A)+ismember(tris,B)));
    nut1=[B,CD(1),beta];
    nut2=[B,CD(2),beta];
    nut3=[A,CD(1),beta];
    nut4=[A,CD(2),beta];
    nuts=[nut1;nut2;nut3;nut4];
 
    
    k(tix,:)=[]; % delete two old triangles.
    k=[k;nuts]; % replace with 4 new triangles.
    
    lines=genlines(k); % regenerate lines from triangles
    
    
    
 
    
    % regenerate midpoints
    midpoints=zeros(size(lines,1),3); % midpoint of line of each triangle. ? line, xyz
    midpoints(:,:)=XYZ(lines(:,1),:)+(XYZ(lines(:,2),:)-XYZ(lines(:,1),:))/2; %AB - a
    
    % regenerate remnants
    used=unique(k(:));
    
    remnants=XYZ(~ismember(ix,used),:);
    csearch=KDTreeSearcher(remnants);
    backmap=find(~ismember(ix,used));
    
    
    [IDX,D]=knnsearch(csearch,midpoints);
    if max(D)>maxd
        cnt=cnt+1;
        if cnt>5
            disp('Concave hull not improving, exiting.');
            break
        end
    end
    maxd=max(D);
    %disp(['Max D = ',num2str(maxd),'.']);
    
    
    
end



function lines=genlines(k)

lines=zeros(size(k,1)*3,2);
cnt=1;
for tri=1:size(k,1)
    lines(cnt,:)=[k(tri,1),k(tri,2)];
    cnt=cnt+1;
    lines(cnt,:)=[k(tri,2),k(tri,3)];
    cnt=cnt+1;
    lines(cnt,:)=[k(tri,3),k(tri,1)];
    cnt=cnt+1;
end
lines=sort(lines,2);
lines=unique(lines,'rows');