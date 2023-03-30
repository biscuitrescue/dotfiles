#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

void read(char datatype[10]) {
    char data[100];

    if(datatype == "disk") {
        char cmd[50] = "lsblk -f | awk '/swap/ {printf $1}'";
        bool alpha = true;
    } else if(datatype == "swap") {
        char cmd[50] = "lsblk -f | awk '/SWAP {printf $1}'";
        bool alpha = true;
    } else {
        char cmd[50] = "free -h | awk '/Mem {printf $3}'";
        bool alpha = false;
    }

    FILE *fp;
    char output[40];

    fp = popen(cmd, "r");

    while( fgets(output, sizeof(output), fp) != NULL ) {
        printf("%s", output);
    }

    pclose(fp);
}

int main() {
    read("swap");
    /* FILE *fp; */
    /* char output[40]; */

    /* fp = popen("ip a", "r"); */

    /* while( fgets(output, sizeof(output), fp) != NULL) { */
    /*     printf("%s", output); */
    /* } */

    /* pclose(fp); */

    return 0;
}
