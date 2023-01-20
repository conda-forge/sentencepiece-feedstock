project(cf_dummy LANGUAGES CXX)
cmake_minimum_required(VERSION 3.12)
find_package(sentencepiece REQUIRED)

add_executable(test_me test_me.cxx)
target_link_libraries(test_me sentencepiece sentencepiece_train)
