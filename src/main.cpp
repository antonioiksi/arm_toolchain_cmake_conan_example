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


    // CROW_ROUTE(app, "/upload")([](const crow::request& req){
    //     crow::multipart::message x(req);

    //     std::string fileName;
    //     std::string fileExt;
    //     if (x.parts[0].headers[0].params.size() != 0)
    //     {
    //         std::string fnf(getFileNameFull(x.parts[0].headers[0].params));
    //         unsigned long found (fnf.find('.'));
    //         if (found == std::string::npos)
    //             return std::string("can't find ext");
    //         fileName = std::string(fnf.substr(0, found));
    //         fileExt = std::string(fnf.substr(found+1));
    //     }

    //     mkdir("files", 0777);

    //     std::string saveFilePath = "files/" + fileName + '.' + fileExt;
    //     std::ofstream saveFile;
    //     saveFile.open(saveFilePath);
    //     saveFile << x.parts[0].body;
    //     saveFile.close();
    //     return req.body;
    // });


    app.port(18080).multithreaded().run();
    return 0;
}