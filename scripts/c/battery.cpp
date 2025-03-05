#include <fstream>
#include <string>
#include <unistd.h>

using namespace std;

bool check_status(){
    string status;
    ifstream file("/sys/class/power_supply/BAT0/status");
    getline(file, status);

    file.close();

    if(status == "Discharging") {
        return true;
    } else {
        return false;
    }
}

int check_battery(){
    string capacity;
    int bat;
    ifstream file("/sys/class/power_supply/BAT0/capacity");
    getline(file, capacity);

    file.close();

    bat = stoi(capacity);
    return bat;
}

int main() {
    while(true){
        int x = check_battery();
        if(x>=99 && !(check_status())) {
            system("dunstify -r 3000 'Battery Full' -h int:value:100 -h string:hlcolor:#95c7ae");
        }
        if(x<=30 && check_status()) {
            system("dunstify -r 3000 'Fill me up daddy ;('");
        }
        if(x<5 && check_status()) {
            system("dunstify -r 3000 'Suspending system in 30s'");
            sleep(30);
            system("systemctl suspend");
        }
        sleep(60);
    }

    return 0;
}
