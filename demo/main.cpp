#include <print.hpp>
#include <iostream>
#include <fstream>
#include <cstdlib>

int main(int argc, char* argv[]) {
    const char* log_path = std::getenv("LOG_PATH");
    if (log_path == nullptr) {
        std::cerr << "undefined environment variable: LOG_PATH" << std::endl;
        return 1;
    }
    std::string text;
    while (std::cin >> text) {
        std::ofstream out{log_path, std::ios_base::app};
        print(text, out);
        out << std::endl;
    }
}
