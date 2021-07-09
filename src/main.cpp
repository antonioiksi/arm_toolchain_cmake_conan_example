#define CROW_MAIN
#include "crow/crow_all.h"

#include "vg_status/vg_status.cpp"
int main()
{
    crow::SimpleApp app;

    CROW_ROUTE(app, "/")([]() {
        string res = parse_status();
        return res;
    });

    app.port(18080).multithreaded().run();
}