#include <string>
#include <unistd.h>
#include <cstdlib>

using namespace std;

string rem_num(string str, bool alpha) {
    string str2;

    for( unsigned int i=0; i<=str.length(); i++ ) {
        if(alpha) {
            if(isalnum(str[i])) {
                str2 += str[i];
            }
        } else {
            if( !(isalpha(str[i])) ) {
                str2 += str[i];
            }
        }
    }

    return str2;
}

string read(string datatype) {
    string cmd;
    bool alpha;
    FILE *fp;
    char output[40];
    string str;

    if(datatype == "disk") {
        cmd = "lsblk -f | awk '/swap/ {printf $1}'";
        alpha = true;
    } else if(datatype == "swap") {
        cmd = "lsblk -f | awk '/SWAP/ {printf $1}'";
        alpha = true;
    } else {
        cmd = "free -h | awk '/Mem/ {printf $3}'";
        alpha = false;
    }

    fp = popen(cmd.c_str(), "r");

    while( fgets(output, sizeof(output), fp) != NULL ) {
        str += rem_num(output, alpha);
    }

    pclose(fp);
    return str;

}

int main() {
    int maxmem = 5;

    while(true) {
        string swapdisk = read("swap");
        string disk = read("disk");
        double memory = stod(read("mem"));
        string cmd;

        if( swapdisk.length() == 0 && memory >= maxmem) {
            cmd = "sudo swapon /dev/"+disk;
        } else if( swapdisk.length() > 0 && memory < maxmem ) {
            cmd = "sudo swapoff /dev/"+disk;
        }

        system(cmd.c_str());
        sleep(1);
    }

    return 0;
}
