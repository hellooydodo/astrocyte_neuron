clc, clear
close all
[x,y] = meshgrid(1:101,1:101);
maindir = input('输入路径：',"s");
subdir = dir(maindir);
for i = 1: length(subdir)
    if( isequal( subdir( i ).name, '.' )||...
        isequal( subdir( i ).name, '..')||...
        ~subdir( i ).isdir)               % 如果不是目录则跳过
        continue;
    end
    subdirpath = fullfile(maindir,subdir(i).name,'*.txt');
    File = dir(subdirpath);
    %pic_num = (length(File) - 3)/3;
    figure(1);
    drawnow;
    if ~isempty(File) 
        nname = File(1).name;
        [keyword_l,keyword_r] = regexp(nname,"AMPA.*");
        if isempty(keyword_l) || isempty(keyword_r)
            [keyword_l,keyword_r] = regexp(nname,"GABA.*");
        end
        pic_name = erase(string(nname(keyword_l:keyword_r)),'.txt');
        pic_index = 1;%记录图像编号
        File_name  = string(pic_index)+'0000v'+pic_name+'.txt';
        File_path = string(maindir)+'\'+string(subdir(i).name)+'\'+string(File_name);
        gif_path = string(maindir)+'\'+string(subdir(i).name)+'\'+pic_name+'.gif';
        while ~exist(File_path,'file') == 0
            data = importdata(File_path);
            pcolor(x,y,data);
            F=getframe(gcf);
            I=frame2im(F);
            [I,map]=rgb2ind(I,256);
            if pic_index == 1
                imwrite(I,map,gif_path,'Loopcount',inf,'DelayTime',0.2);
            else
                imwrite(I,map,gif_path,'gif','WriteMode','append','DelayTime',0.2);
            end
            pic_path = erase(string(maindir)+'\'+string(subdir(i).name)+'\'+string(File_name),'.txt')+'.png';
            if exist(pic_path,'file') == 0
             saveas(gcf, erase(string(maindir)+'\'+string(subdir(i).name)+'\'+string(File_name),'.txt')+'.png');
            end
            pic_index = pic_index + 1;
            File_name  = string(pic_index)+'0000v'+pic_name+'.txt';
            File_path = string(maindir)+'\'+string(subdir(i).name)+'\'+string(File_name);
        end
    end
end