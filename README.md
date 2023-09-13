# Powerful workspace

A.K.A. a tricky way to have VM-like isolation where you cannot run VM

> It seems like someone considers Virtualization a deprecated technology!

# The use case

A big machine, some GPUs, and a back-to-back connection on two different NICs.

We want to run a client, and a server, softwares _traversing_ the physical link.

We don't want to give root privileges to everyone.

And we need some RDMA/DPDK support.

# The solution

Docker is used as undelying container technology.

On top of this, some tricks (with great inspiration from [pipework](https://github.com/jpetazzo/pipework) allows to assing the interfaces to each container.

So we have now two containers, each with its own NIC and a private IP on the internal network (similarly to a data-plane and control-plane infrastructure).

By embedding ssh in each container (**which is a bad practice**), users can ssh into each container and execute commands _as if_ they were separate, physical machines (or VMs).

# Security implications

- We don't do namespace isolation and userid mapping. You should consider this
- The current docker compose configuration exposes the rdmacm device, which may not be desirable in a production/multi-tenant environment.
- There is nothing that prevents a prvilege escalation due to docker/Kernel bugs. No in-depth risk analysis has been done. If you know more, feel free to get in touch!
- If the stack is created/destroyed, any ephemeral configuration of software installation is gone!
	* One should rebuild the image after a specific software has been installed.


# Use

- Build your docker image. In this case `./build.sh` will do it.
- Bring up the environment `docker compose up -d server client` or `docker-compose up -d server client` depending on your software versions.
- Assing the interfaces `sudo ./assign_interfaces.sh`
- Connect to the containers with `ssh user@172.31.199.{1,2}`
- The two containers should be able to reach each other with the IPs in `192.168.199.0/24`

# License


The code in this repository is licensed under the GNU Public License v3, see LICENSE to know more.
