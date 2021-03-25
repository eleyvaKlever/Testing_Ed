all: tx

tx: rf4463.o tx.o
	$(CXX) $(CXXFLAGS) $(LDFLAGS) $+ -o $@ -lwiringPi
	
clean:
	$(RM) *.o tx 