iperf_server_script = 'iperf -s -B %s -u -p %d -i 1'
start_client_skeleton = "iperf -c %s -p %d -u -t %d -b %dm -f m"
node = "planetlab1.tlm.unavarra.es"
target = "152.66.127.81"
port = 5200
bandwidth = 20 # MBitps

new_measure = lib.ParalellMeasure()
start = 0
duration = 5 # duration of the measure in secundum

sub_measure = lib.Measure(target, None, "mptcp")
# Add timed remote command for iperf server starting with timeout
sub_measure.setScript("iperf_server_"+node, iperf_server_script %\ 
(target, port), duration+2)
# Add submeasure to the measure with timeout
new_measure.addMeasure(sub_measure, start, duration+3)

sub_measure = lib.Measure(node, target)
sub_measure.setScript("iperf_client_"+node, start_client_skeleton%\
(target, port, duration, bandwidth))
new_measure.addMeasure(sub_measure, start+1)

new_measure.startMeasure() # Start measure
new_measure.join() # Wait for measure to end
data = new_measure.getData()
lib.save_one_measure(data, db=True)