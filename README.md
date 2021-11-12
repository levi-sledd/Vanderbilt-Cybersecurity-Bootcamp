# Vanderbilt-Cybersecurity-Bootcamp
Repository for projects developed during the Vanderbilt Cybersecurity Bootcamp, Fall 2021
## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

Network Diagram (Images/Network_Diagram.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the Ansible directory may be used to install only certain pieces of it, such as Filebeat.

- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the Dang Vulnerable Web Application.

Load balancing ensures that the application will be highly robust, protecting the availability of a web application by providing redundancy.  If one web server is down but the other is up, the load balancer can route traffic to the running server.  If both are up, then the load balancer can route traffic so that both servers get a roughly equal share of requests, thus doubling the computational power needed for a denial-of-service attack.

The advantage of a jump box is that there is a single point where an administrator with the right credentials (the SSH key) can access the network.  This ensures that the attack surface of the network is at a minimum, and that administrator access to the network is hidden from the internet at large.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the server and system files.
- Filebeat logs changes in system files and sends these logs to the ELK stack.
- Metricbeat records traffic on the servers, CPU usage, memory usage, and disk space.

The configuration details of each machine may be found below.

| Name          |    Function    | Public IP     | Private IP | Operating System |
|---------------|----------------|---------------|------------|------------------|
| Jump Box      | Gateway        | 20.69.153.69  | 10.0.0.4   | Linux            |
| Web 1         | Web Server     | None          | 10.0.0.7   | Linux            |
| Web 2         | Web Server     | None          | 10.0.0.8   | Linux            |
| Load Balancer | Load Balancer  | 20.112.29.219 |            |                  |
| ELK VM        | ELK Stack Host | 13.64.193.159 | 10.1.0.4   | Linux            |

### Access Policies

To minimize the attack surface area of the network, access to the network from the Internet is severely limited.

The Jump Box is the gateway to the network.  Technically, the Jump Box is exposed to the Internet, but in a limited way.  The only connections the Jump Box accepts are SSH connections from 24.119.136.198 to port 22.  Administrator access to any other machine on the network can only be achieved by an SSH connection *from* the Jump Box.  Therefore the Jump Box serves as the single, secure point of access to the network.

The web servers do not have a public IP address and are not exposed to the Internet.

The Load Balancer and ELK VM each have a limited exposure to the Internet for testing purposes.  The Load Balancer accepts HTTP requests to port 80 from one allowed IP address, namely 24.119.136.198, and forwards this traffic to port 80 of either Web 1 or Web 2. The ELK VM hosts the Kibana app on port 5601.  It accepts only HTTP requests from 24.119.136.198 to port 5601.

In essence, the network is an *almost* self-contained testing environment where the "Internet" is represented by the host with IP 24.119.136.198.

A summary of the access policies in place can be found in the table below.

|     Name         | Publicly Accessible | Allowed IP Addresses |
|------------------|---------------------|----------------------|
| Jump Box         | Yes                 |   24.119.136.198     |
| Web 1            | No                  |   10.0.0.4           |
| Web 2            | No                  |   10.0.0.4           |
| Load Balancer    | Yes                 |   24.119.136.198     |
| ELK VM           | Yes                 |   24.119.136.198     |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually.  The advantage of automating tasks like VM container configuration is that it is much easier to scale: configuring the same software on 10,000 machines wouldn't take much longer than on two. 

The install-elk.yml playbook implements the following tasks:
- Installs docker
- Installs pip3 
- Increases virtual memory
- Installs and configures an ELK container
- Enables docker on startup

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

['docker ps' Output](Images/docker_ps_output.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web 1 (IP 10.0.0.7)
- Web 2 (IP 10.0.0.8)

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat collects information on the histories of files, logging which files have changed and when.  It then sends these logs to Elasticsearch.  In this case it is being used to monitor the Apache server and MySQL logs generated by the DVWA.
-Metricbeat collects data on machine metrics, e.g. uptime, CPU load, etc.  It then forwards this information to Elasticsearch, at which point it can be visualized with Kibana.

### Using the Playbook
In order to use the install-elk.yml playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the install-elk.yml file to etc/ansible.
- Update the hosts file to include the [elk] group, which should include the IP address of the ELK VM.
- Run the playbook, and navigate to http://(ELK VM's Public IP address):5601/app/kibana to check that the installation worked as expected.

_TODO: Answer the following questions to fill in the blanks:_
- The playbook for installing the ELK stack is install-elk.yml
- To make Ansible run the playbook on a specific machine, first collect the IP addresses of all the machines you would like to install the same software on.  Create a new group in the hosts file, and list the IP addresses belonging to that group each on a separate line under the group name.  In the case of installing the ELK stack, the group is [elk] and consists of one machine.  The line "hosts: elk" in the install-elk.yml playbook specifies that the ELK stack should be installed on all machines whose IP addresses are listed under the [elk] group in the hosts file.  Similarly, to specify that filebeat should be installed on the webservers group, the line hosts: webservers is included in the install-filebeat.yml playbook.
- To check that the ELK server is running, navigate to http://(ELK VM's Public IP address):5601/app/kibana
