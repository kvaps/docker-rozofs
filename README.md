
# Docker-RozoFS

This is a [Docker](http://docker.io) project to bring up a
[RozoFS](https://github.com/rozofs/rozofs) cluster in Kubernetes.


### What is RozoFS?

RozoFS is a scale-out distributed file system providing high performance and
high availability since it relies on an
[erasure code](http://en.wikipedia.org/wiki/Erasure_code) based on the
[Mojette transform](https://hal.archives-ouvertes.fr/hal-00267621/document).
User data is projected into several chunks and distributed across storage
devices. While data can be retrieved even if several pieces are unavailable,
chunks are meaningless alone. Erasure coding brings the same protection as
plain replication but reduces the amount of stored data by two.

### Prerequisites: Install rpcind

Assume that we running cluster on nodes with systemd installed.

Make sure that your nodes have `rpcbind.service` it will be [handled] from initContainer, each time before rozofs container start.

[handled]: https://github.com/kvaps/docker-rozofs/blob/master/rozofs.yaml#L26

If your systems have no systemd, you can change this behavior anytime.

### Launch daemons

By default the daemonset configured directories:

* `/data/local/config/rozofs` - configs
* `/data/local/data/rozofs` - data
* `/mnt` - mounts

If you want to use other location download yaml, and override it.

Apply rozofs daemonset:

```bash
kubectl apply -f https://github.com/kvaps/docker-rozofs/blob/master/rozofs.yaml
```

This action will run rozofs container on each node in your cluster

### Configuring cluster

Connect to one container:

```bash
kubectl exec -ti rozofs-c69hg bash
```

Follow the [instructions on RozoFS website] to deploy cluster.

[instructions on RozoFS website]: http://rozofs.github.io/rozofs/develop/ConfiguringRozoFSWithRozoCLI.html

**Example:**

```bash
# Create volume
rozo volume expand node{1,2,3,4} -E node1

# Create export
rozo export create 1 -E node1

# Check export
rozo export get -E node1

# Create mount
rozo mount create -i 1 -E node1

# Check nodes
rozo node list -E node1
```
