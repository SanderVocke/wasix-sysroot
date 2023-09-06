
#include <stdexcept>

void throw_it() {
    throw std::runtime_error("Ouch!");
}

int main(int argc, char** argv) {
    try {
        throw_it();
    } catch (const std::exception& e) {
        return 123;
    }
    return 0;
}