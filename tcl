# Create a simulator object
set ns [new Simulator]

# Open the output files for tracing
set tracefile [open out.tr w]
$ns trace-all $tracefile

# Open the NAM trace file
set namfile [open out.nam w]
$ns namtrace-all $namfile

# Define the network nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]

# Create duplex links between the nodes
$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail

# Create a TCP agent and attach it to node n0
set tcp [new Agent/TCP]
$ns attach-agent $n0 $tcp

# Create a TCP sink agent and attach it to node n2
set sink [new Agent/TCPSink]
$ns attach-agent $n2 $sink

# Connect the TCP agent and the TCP sink
$ns connect $tcp $sink

# Create an FTP application and attach it to the TCP agent
set ftp [new Application/FTP]
$ftp attach-agent $tcp

# Start FTP traffic at time 0.5 seconds
$ns at 0.5 "$ftp start"

# Stop the simulation at 5 seconds
$ns at 5.0 "finish"

# Define the finish procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam out.nam &
    exit 0
}

# Run the simulation
$ns run

Run the Script: ns simple_tcp.tcl
and nam out.nam

Tcl Script for a Simple Network Topology with UDP Connections
# Create a simulator object
set ns [new Simulator]

# Open the output files for tracing
set tracefile [open out.tr w]
$ns trace-all $tracefile

# Open the NAM trace file
set namfile [open out.nam w]
$ns namtrace-all $namfile

# Define the network nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]

# Create duplex links between the nodes
$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail

# Create a UDP agent and attach it to node n0
set udp [new Agent/UDP]
$ns attach-agent $n0 $udp

# Create a Null agent (UDP sink) and attach it to node n2
set null [new Agent/Null]
$ns attach-agent $n2 $null

# Connect the UDP agent to the sink
$ns connect $udp $null

# Create a CBR (Constant Bit Rate) traffic source and attach it to the UDP agent
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$cbr set packetSize_ 512
$cbr set rate_ 0.5Mb

# Start CBR traffic at time 0.5 seconds
$ns at 0.5 "$cbr start"

# Stop the simulation at 5 seconds
$ns at 5.0 "finish"

# Define the finish procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam out.nam &
    exit 0
}

# Run the simulation
$ns run
