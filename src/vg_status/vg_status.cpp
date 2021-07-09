#include <iostream>
#include <iterator>
#include <string>
#include <sstream>
#include <regex>
#include <array>

using namespace std;

string execCommand(const string cmd, int& out_exitStatus)
{
    out_exitStatus = 0;
    auto pPipe = ::popen(cmd.c_str(), "r");
    if(pPipe == nullptr)
    {
        throw runtime_error("Cannot open pipe");
    }
    array<char, 256> buffer;
    string result;
    while(not feof(pPipe))
    {
        auto bytes = fread(buffer.data(), 1, buffer.size(), pPipe);
        result.append(buffer.data(), bytes);
    }
    auto rc = ::pclose(pPipe);
    if(WIFEXITED(rc))
    {
        out_exitStatus = WEXITSTATUS(rc);
    }
    return result;
}


static string parse_status()
{
    stringstream buffer;

//    exec("/root/status > status.log");
    // string cmd = "cat /root/status";
    string cmd = "cat status";
    // string cmd = "/root/status";
    int result;
    string text = execCommand(cmd, result);
    if(result > 0)
        throw result;
        
//    cout << "Execution: " << cmd << endl << text << endl << endl << endl;

    regex server_regex("[*]{4} {1}([ a-z_]+) server\\b status\\b:\\s+[PID: ]+([0-9]+)([\\s.\\w:]+)");

    auto servers_begin =
            sregex_iterator(text.begin(), text.end(), server_regex);
    auto servers_end = sregex_iterator();

    for (sregex_iterator i = servers_begin; i != servers_end; ++i) {
        smatch match = *i;
        string match_str = match.str();
//        cout << "  " << match_str << '\n';

        string server = match.str(1);
        string pid = match.str(2);
        string info = match.str(3);
//        cout << "Server: " << server << '\n';
//        cout << "PID: " << pid << '\n';
//        cout << "Info: " << info << '\n';

        if(server != "ntpd server") {
            regex info_regex("[ \\s\\t]+\\bListening at\\b +([0-9\\.:]+)[\\s ]+\\bConnected clients\\b:([.\\s0-9:]+)\\b([0-9]+) total\\b");
            auto infos_begin =
                    sregex_iterator(info.begin(), info.end(), info_regex);
            auto infos_end = sregex_iterator();
            for (sregex_iterator i = infos_begin; i != infos_end; ++i) {
                smatch match = *i;

                string listening = match.str(1);
                string listening_ip(""), listening_port("");
                string clients = match.str(2);
                string total = match.str(3);

                size_t found = listening.find(":");
                if (found!=string::npos) {
                    listening_ip = listening.substr(0, found);
                    listening_port = listening.substr(found + 1, listening.length());
                }
                else {
                    listening_ip = listening;
                }


//                cout << "Listening at: " << listening << '\n';
//                cout << "   listening_ip: " << listening_ip << '\n';
//                cout << "   listening_port: " << listening_port << '\n';
//                cout << "Connected clients: " << clients << '\n';
//                cout << "Total clients: " << total << '\n';

//                node_directory_size_bytes{directory="/var/log"} 29843470
//                cout << "vg_status{server=\"" << server << "\"} " << total << endl;
                buffer << "vg_status{server=\"" << server << "\", ip=\"" << listening_ip << "\", port=\"" << listening_port << "\"} "  << "1" << endl;

                regex clients_regex("[\\s ]+([0-9\\.]+):([0-9]+)");
                auto clients_begin =
                        sregex_iterator(clients.begin(), clients.end(), clients_regex);
                auto clients_end = sregex_iterator();
                for (sregex_iterator i = clients_begin; i != clients_end; ++i) {
                    smatch match = *i;
                    string IP = match.str(1);
                    string PORT = match.str(2);
//                    cout << "IP: " << match.str(1) << " ";
//                    cout << "PORT: " << match.str(2) << '\n';
                    buffer << "vg_status_client{server=\"" << server << "\", ip=\"" << IP << "\", port=\"" << PORT << "\"} "  << "1" << endl;
                }
            }
        } else {
//            string clients = info;
//            regex clients_regex("\\s +\\bActive UDP socket on\\b ([abcdef0-9\\.:]+):([0-9]+)");
//            auto clients_begin =
//                    sregex_iterator(clients.begin(), clients.end(), clients_regex);
//            auto clients_end = sregex_iterator();
//            for (sregex_iterator i = clients_begin; i != clients_end; ++i) {
//                smatch match = *i;
//                cout << "IP: " << match.str(1) << " ";
//                cout << "PORT: " << match.str(2) << '\n';
//            }
        }
    }
    cout << buffer.str();
    return buffer.str();
}


