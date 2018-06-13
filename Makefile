.PHONY: all images rozofs-base rozofs-exportd rozofs-storaged \
	rozofs-rozofsmount rozofs-allinone start-cluster mount-cluster add-client \
	stop-cluster

all: stop-cluster images start-cluster

images: rozofs-base rozofs-exportd rozofs-storaged rozofs-rozofsmount

rozofs-base:
	docker build -t "kvaps/rozofs-base" rozofs-base/
	
rozofs-exportd:
	docker build -t "kvaps/rozofs-exportd" rozofs-exportd/
	
rozofs-storaged:
	docker build -t "kvaps/rozofs-storaged" rozofs-storaged/

rozofs-rozofsmount:
	docker build -t "kvaps/rozofs-rozofsmount" rozofs-rozofsmount/
	
rozofs-allinone:
	docker build -t "kvaps/rozofs-allinone" rozofs-allinone/
	
start-cluster:
	./start_cluster.sh

mount-cluster:
	./mount_cluster.sh /mnt/rozofs

add-client:
	./add_client.sh

stop-cluster:
	./stop_cluster.sh
