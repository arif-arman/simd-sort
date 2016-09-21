.SUFFIXES:
.PHONY: all clean

FLAGS=-std=c++11 -mavx512f -mbmi2 -Wall -pedantic -Wextra
DEPS_SORT=partition.cpp avx512-partition.cpp avx512-bmi2-partition.cpp avx512-popcnt-partition.cpp quicksort.cpp
ALL=test speed

all: $(ALL)

test: test.cpp input_data.cpp $(DEPS_SORT)
	$(CXX) $(FLAGS) -fsanitize=address test.cpp -o $@

speed: speed.cpp input_data.cpp gettime.cpp $(DEPS_SORT)
	$(CXX) $(FLAGS) -O3 -DNDEBUG speed.cpp -o $@

run: test
	sde -cnl -- ./$^

clean:
	rm -f $(ALL)
