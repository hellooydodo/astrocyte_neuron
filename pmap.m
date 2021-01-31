clc, clear
Path = input('输入路径：',"s");
File = dir(fullfile(Path,"*.txt"));
pattern = ".*0v.*";
[x,y] = meshgrid(1:101,1:101);
for i = 1:length(File)
    File_name  = File(i).name;
    name = regexp(File(i).name,pattern);
    if ~isempty(name)
        data = importdata(string(Path)+'\'+string(File_name));
        pcolor(x,y,data);
        saveas(gcf,erase(string(Path)+'\'+string(File_name),'.txt')+'.png');
    end
end