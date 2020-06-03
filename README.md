# docker-intel-gpu-telegraf

<img width=150px height=150px src="https://github.com/brianmiller/docker-templates/raw/master/intel-gpu-telegraf/intel_telegraf.png"></img>

This is a simple container designed to poll utilization data from the integrated GPU in Intel CPUs and send the data to InfluxDB via Telegraf.   I'm using the i9-9900k CPU and the GPU is piped to my Plex container, also running on the Unraid server.

This container requires that /dev/dri (the GPU) is piped to the container.  This is automatically set if you are using the Unraid template as mentioned below.

Ultimately the goal was to display GPU utilization for my Unraid server via Grafana: 
<img src=https://github.com/brianmiller/docker-intel-gpu-telegraf/raw/master/grafana_screenshot.png></img>

<br>

#### Attributes: *Except for the influx_password, all variables are required to be set before starting the container.*
##### `telegraf_hostname`: This fills the hostname variable under [agent] in Telegraf's config.  
##### `influx_url`: This fills the [urls] array under [[outputs.influxdb]] in Telegraf's config.
##### `influx_db`: This fills the database variable under [[outputs.influxdb]] in Telegraf's config.
##### `influx_passsword`: This fills the password variable under [[outputs.influxdb]] in Telegraf's config. This is optional, leave it blank if no password is used to connect to your influx database.
##### `influx_skip_db_creation`: This fills the skip_database_creation variable under [[outputs.influxdb]] in Telegraf's config.

<br>

#### For Unraid users:
Just add my repository: "**https://github.com/brianmiller/docker-templates**" to your repo list in Unraid (bottom on the Docker tab.) The container will show up in your list as "*intel-gpu-telegraf*":

<br>

#### For docker direct users: <br>
 ##### Download the container
`docker pull theoriginalbrian/intel-gpu-telegraf`
 ##### Start the container
`docker run --rm -ti --privileged=true --device /dev/dri:/dev/dri --ip ipaddressforthiscontainer --network interfacetobindto --env telegraf_hostname="myhostname" --env influx_url="http://myinfluxdb:port" --env influx_db="myinfluxdb" --env influx_password="" --env influx_skip_db_creation="false"  theoriginalbrian/intel-gpu-telegraf`
##### The actual command I use to start the container in my environment, when I'm not using Unraid.
`docker run --rm -ti --privileged=true --device /dev/dri:/dev/dri --ip 2.2.20.29 --network br0 --env telegraf_hostname="cerebrum" --env influx_url="http://37648-influxdb1.phospher.com:8086" --env influx_db="telegraf" --env influx_password="" --env influx_skip_db_creation="false"  theoriginalbrian/intel-gpu-telegraf`



