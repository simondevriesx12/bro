# Load the core cluster support.
@load ./main

@if ( Cluster::node != "" )

# Give the node being started up it's peer name.
redef peer_description = Cluster::node;

# Add a cluster prefix.
@prefixes += cluster

# Make this a controllable node since all cluster nodes are inherently 
# controllable.
@load frameworks/control/controllee

## If this script isn't found anywhere, the cluster bombs out.
## Loading the cluster framework requires that a script by this name exists
## somewhere in the BROPATH.  The only thing in the file should be the
## cluster definition in the :bro:id:`Cluster::nodes` variable.
@load cluster-layout

@if ( Cluster::node in Cluster::nodes )

@load ./setup-connections

# Don't start the listening process until we're a bit more sure that the
# cluster framework is actually being enabled.
@load frameworks/communication/listen-clear

## Set the port that this node is supposed to listen on.
redef Communication::listen_port_clear = Cluster::nodes[Cluster::node]$p;

@if ( Cluster::nodes[Cluster::node]$node_type == Cluster::MANAGER )
@load ./nodes/manager
@endif

@if ( Cluster::nodes[Cluster::node]$node_type == Cluster::PROXY )
@load ./nodes/proxy
@endif

@if ( Cluster::nodes[Cluster::node]$node_type == Cluster::WORKER )
@load ./nodes/worker
@endif

@endif
@endif