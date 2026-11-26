#include "cpucounters.h"
#include "version.h"

#include <iostream>

int main() {
    const auto model = pcm::PCM::getCPUBrandString();
    if (model.empty()) return 1;
    std::cout << "PCM " << PCM_VERSION << " CPU " << model << '\n';
}