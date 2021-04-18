#include <cstdio>
#include <stdlib.h>
#include <string>
#include <iostream>  
#include <sys/stat.h>
using namespace std;
#define PATH "D:\\Data\\astrocyte_neuron\\mix"
int dir_num=0;
string dirs[5000];
int _System(const char* cmd, char* pRetMsg, int msg_len,std::string path)
{
	cout << path << endl;
	FILE* fp;
	char* p = NULL;
	int res = -1;
	if (cmd == NULL || pRetMsg == NULL || msg_len < 0)
	{
		printf("Param Error!\n");
		return -1;
	}
	if ((fp = _popen(cmd, "r")) == NULL)
	{
		printf("Popen Error!\n");
		return -2;
	}
	else
	{
		memset(pRetMsg, 0, msg_len);
		//get lastest result  
		while (fgets(pRetMsg, msg_len, fp) != NULL)
		{
			printf("Msg:%s", pRetMsg); //print all info  
			std::string msgstring = pRetMsg;
			std::string filetype = msgstring.substr(msgstring.find_last_of('.') + 1);
			filetype = filetype.substr(0, filetype.rfind("\n"));
			std::cout << filetype << std::endl;
			const char* typecpp = "cpp";

			std::string typecpp_s = typecpp;
			struct stat s;
			std::string filename = msgstring;
			filename = filename.substr(0, filename.rfind("\n"));
			filename = filename.substr((msgstring.find_last_of(' ') + 1));
			
			{
				std::string::size_type dPos = msgstring.find("<DIR>");
				std::string::size_type iPos = msgstring.find_last_of('\\') + 1;
				if (dPos != std::string::npos && filename != "." && filename != "..") {
					std::cout << "it is dir" << endl;
					string children_path = path;
					children_path += "\\";

					children_path += filename;
					
					dir_num++;
					dirs[dir_num] = children_path;
					
				    
				}
			}


			if (filetype == typecpp_s) {
				std::cout << "need to compilers" << std::endl;
				std::string::size_type iPos = msgstring.find_last_of('\\') + 1;
				std::string filename = msgstring.substr(iPos, msgstring.length() - iPos);
				filename = filename.substr(0, filename.rfind("\n"));
				filename = filename.substr((msgstring.find_last_of(' ') + 1));
				string filenameWithouType = filename.substr(0, filename.find(".cpp"));
				std::cout << filename << std::endl;
				std::string cmdline = "d: && cd ";
				cmdline += path;
				cmdline += " && g++ ";
				cmdline += filename;
				cmdline += " -o ";
				cmdline += filenameWithouType;
				const char* cmd = cmdline.c_str();
				system(cmd);
			}


		}

		if ((res = _pclose(fp)) == -1)
		{
			printf("close popenerror!\n");
			return -3;
		}
		pRetMsg[strlen(pRetMsg) - 1] = '\0';
		return 0;
	}
}

int main()
{
	//test cmd  
	dir_num++;
	dirs[dir_num] = PATH;
	int i = 1;
	while ( dirs[i] !="") {
		std::string cmd_s = "d: &&cd ";
		cmd_s += dirs[i];
	
		cmd_s += "&&dir";
		const char* cmd = cmd_s.c_str();
		char a8Result[50000] = { 0 };
		int ret = 0;
		ret = _System(cmd, a8Result, sizeof(a8Result), dirs[i]);
		i++;
	}
	printf("\n");
	getchar();
	return 0;
}
