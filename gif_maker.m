clc, clear
close all
[x,y] = meshgrid(1:101,1:101);
maindir = input('输入路径：',"s");
data_name = input('输入数据名:','s');
subdir = dir(maindir);
for i = 1: length(subdir)
    if( isequal( subdir( i ).name, '.' )||...
        isequal( subdir( i ).name, '..')||...
        ~subdir( i ).isdir)               % 如果不是目录则跳过
        continue;
    end
    subdirpath = fullfile(maindir,subdir(i).name,'*.txt');
    File = dir(subdirpath);
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
        b = false;
        if exist((string(maindir)+'\'+string(subdir(i).name)+'\'+'2000v'+pic_name+'.txt'),'file')
            if b == false && pic_index < 5
                File_name  = string(2*pic_index)+'000'+data_name+pic_name+'.txt';
                b = true;
            else
                File_name = string(pic_index)+'0000'+data_name+pic_name+'.txt';
                b = false;
            end
        else
            File_name = string(pic_index)+'0000'+data_name+pic_name+'.txt';
        end
        File_path = string(maindir)+'\'+string(subdir(i).name)+'\'+string(File_name);
        gif_path = string(maindir)+'\'+string(subdir(i).name)+'\'+data_name+pic_name+'.gif';
       %if exist(gif_path,'file') == 0
            while ~exist(File_path,'file') == 0
                data = importdata(File_path);
                pcolor(x,y,data);
                axis off
                set(gcf,'unit','centimeters','position',[10 10 15 15])
                set(gca,'Position',[0 0 1 1]);
                F=getframe(gcf);
                I=frame2im(F);
                [I,map]=rgb2ind(I,256);
                if pic_index == 1
                    imwrite(I,map,gif_path,'Loopcount',inf,'DelayTime',0.2);
                else
                    imwrite(I,map,gif_path,'gif','WriteMode','append','DelayTime',0.2);
                end
                pic_path = erase(string(maindir)+'\'+string(subdir(i).name)+'\'+string(File_name),'.txt')+'.png';
                %if exist(pic_path,'file') == 0
                    saveas(gcf, erase(string(maindir)+'\'+string(subdir(i).name)+'\'+string(File_name),'.txt')+'.png');
                %end
                pic_index = pic_index + 1;
                if (b == true && pic_index < 5)
                    File_name  = string(2*pic_index)+'000'+data_name+pic_name+'.txt';
                    if pic_index == 4
                        pic_index = 0;
                        b = false;
                    end
                else
                    File_name  = string(pic_index)+'0000'+data_name+pic_name+'.txt';
                end
                File_path = string(maindir)+'\'+string(subdir(i).name)+'\'+string(File_name);
            end
        %end
    end
end