# This is project is aimed at building fluent-bit for QNX7.1

This project is created in Ubuntu 20.04 LTS, it is still in process!

Several tools are required:

- QNX SDP7.1
- cmake
- make 


## How to build

1. Activate QNX7.1 SDP

2. Run command "make all" to build the project, the executable and configure files will be found in the bin folder


## How to run 

1. Copy fluent-bit, fluent-bit.conf, fluent-bit-receiver.conf and sys.log into one folder in QNX

2. Run command "./fluent-bit -c ./fluent-bit.conf" to start a sender process

3. Run command "./fluent-bit -c ./fluent-bit-receiver.conf" to start a receiver process

4. Add log to the sys.log file by running "echo test_message >> sys.log"

You should see sender sendout the message and receiver receives it.


## Known issue

- Receiver crashes with memory check failure
