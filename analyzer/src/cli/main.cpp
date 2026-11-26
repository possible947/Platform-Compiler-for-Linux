#include "session/session.h"

#include <exception>
#include <iostream>
#include <string>

int main(int argc, char **argv) {
    try {
        if (argc == 2 && std::string(argv[1]) == "probe") return analyzer::probe();
        if (argc == 2 && std::string(argv[1]) == "clock") return analyzer::clock_snapshot();
        if (argc == 6 && std::string(argv[1]) == "record" &&
            std::string(argv[2]) == "--config" && std::string(argv[4]) == "--output")
            return analyzer::record(argv[3], argv[5]);
        std::cerr << "Usage: analyzer probe | analyzer clock | analyzer record --config FILE --output NEW_DIRECTORY\n";
        return 1;
    } catch (const std::exception &error) {
        std::cerr << "analyzer: " << error.what() << '\n';
        return 1;
    }
}