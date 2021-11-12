# Vanderbilt-Cybersecurity-Bootcamp
Repository for projects developed during the Vanderbilt Cybersecurity Bootcamp, Fall 2021
## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

Network Diagram (Images/Network_Diagram.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the Ansible directory may be used to install only certain pieces of it, such as Filebeat.

  - install-elk.yml

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting access to the network.
Load balancers protect the availability of a web application by providing redundancy and increasing the difficulty of a denial of service attack.  If one web server is down but the other is up, the load balancer can route traffic to the running server.  If both are up, then the load balancer can route traffic so that both servers get a roughly equal share of requests.

The advantage of a jump box is that there is a single point where an administrator with the right credentials (the SSH key) can access the network.  This ensures that the attack surface of the network is at a minimum, and that administrator (or root) access to the network is hidden from the internet at large.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the server and system files.
- Filebeat logs changes in system files and sends these logs to the ELK stack.
- Metricbeat records traffic on the servers, CPU usage, memory usage, and disk space.

The configuration details of each machine may be found below.
_Note: Use the [Markdown Table Generator](http://www.tablesgenerator.com/markdown_tables) to add/remove values from the table_.

| Name     |    Function    | IP Address | Operating System |
|----------|----------------|------------|------------------|
| Jump Box |  Gateway       | 10.0.0.4   | Linux            |
| Web 1    | Web Server     | 10.0.0.7   | Linux            |
| Web 2    | Web Server     | 10.0.0.8   | Linux            |
| ELK VM   | ELK Stack Host | 10.1.0.4   | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the load balancer and the Jump Box accept connections from the Internet.  Access to each of these machines is only allowed from the IP address 24.119.136.198.  In addition, the load balancer only accepts HTTP requests over port 80, while the Jump Box only accepts SSH connections over port 22.

Machines within the network, including the ELK VM, can only be accessed by the Jump Box, which has a private IP of 10.0.0.4.

A summary of the access policies in place can be found in the table below.

|     Name         | Publicly Accessible | Allowed IP Addresses |
|------------------|---------------------|----------------------|
| Jump Box         | Yes                 |   24.119.136.198     |
| Web 1            | No                  |   10.0.0.4           |
| Web 2            | No                  |   10.0.0.4           |
| Load Balancer    | Yes                 |   24.119.136.198     |
| ELK VM           | No                  |   10.0.0.4           |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually.  The advantage of automating tasks like VM container configuration is that it is much easier to scale: configuring the same software on 10,000 machines wouldn't take much longer than on two. 

The playbook implements the following tasks:
- Installs docker
- Installs pip3 
- Increases virtual memory
- Installs and configures an ELK container
- Enables docker on startup

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![TODO: Update the path with the name of your screenshot of docker ps output](Images/docker_ps_output.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web 1 (IP 10.0.0.7)
- Web 2 (IP 10.0.0.8)

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat collects information on the histories of files, logging which files have changed and when.  In this case it is being used to monitor the Apache server and MySQL logs generated by the DVWA.  It then sends these logs to Elasticsearch.
-Metricbeat collects data on machine metrics, e.g. uptime, CPU load, etc.  It then forwards this information to Elasticsearch, at which point it can be visualized with Kibana.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the install-elk.yml file to etc/ansible.
- Update the hosts file to include the [elk] group, which should include the IP address of the ELK VM.
- Run the playbook, and navigate to http://(ELK VM's Public IP address):5601/app/kibana to check that the installation worked as expected.

_TODO: Answer the following questions to fill in the blanks:_
- The playbook for installing the ELK stack is install-elk.yml
- To make Ansible run the playbook on a specific machine, first collect the IP addresses of all the machines you would like to install the same software on.  Create a new group in the hosts file, and list the IP addresses belonging to that group each on a separate line under the group name.  In the case of installing the ELK stack, the group is [elk] and consists of one machine.  The line "hosts: elk" in the install-elk.yml playbook specifies that the ELK stack should be installed on all machines whose IP addresses are listed under the [elk] group in the hosts file.  Similarly, to specify that filebeat should be installed on the webservers group, the line hosts: webservers is included in the install-filebeat.yml playbook.
- To check that the ELK server is running, navigate to http://(ELK VM's Public IP address):5601/app/kibana
