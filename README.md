Universal Diagnostic Data Collector (uddc)
Formerly 'getlogs'

See https://wiki.proofpoint.com/wiki/display/LRNPPS/Universal+Diagnostic+Data+Collector for additional information.

Usage: uddc <OPTIONS>

Collect diagnostic data.

Example: uddc.sh --get admin --output admin.tgz

Miscellaneous Options:
  -h, --help                Display this help text.
  -v, --version             Display version information.
  -s, --show                Display valid keywords.
  -q, --quiet               Suppress excess output to screen.
  --selfdestruct            Delete all files in UDDC directory except
                            for the output.

File Options:
  -k, --keyfile <file>      Load keyword data from <file>. Default is
                            /opt/proofpoint/uddc/uddc.dat
  -p, --path <path>         Save output in <path>. Default output
                            path is /opt/proofpoint/uddc
  -o, --output <file>       Package data in <file>. File extension
                            should be either tgz or tar.gz or there
                            may be difficulty unpacking it. Default is
                            uddc_<HOST>_<KEY>_<TIME>.tgz
  -t, --temp <path>         Use <path> as temp directory. Default is
                            /opt/proofpoint/tmp

Data Collection Options:
  -g, --get <keyword>       Collect diagnostic data for <keyword>. The
                            keyword should represent what type of issue
                            you need diagnostic data for, such as filter,
                            sendmail, admin, fr, hft, alerts, av, etc.
                            Default keyword is always
  --test                    Test mode. Displays a list of files that
                            would be collected. Does not actually create
                            an output file.
  --nocfgs                  Skip collecting configuration data.
  --nocmds                  Skip collecting command output.
  --nologs                  Skip collecting logs.
  --nourls                  Skip collecting URL output.
  --notalways               Skip collecting the default data. Only
                            collect keyword specific data.

Default Valid Keywords as of revision 210910.01 of uddc.dat:

acl                 ad                  add-in
addin               admin               adqueue             agent
alerts              aliases             apache              api
apiservice          audit               auth                authentication
av                  background          cloud               cloudquarantine
cloudservices       cloudsync           cluster             cmdprocessor
config              configcenter        cqs                 cron
cvs                 cvtd                da                  database
db                  dbmsgqueue          deploy              digest
digitalassets       disks               dns                 drives
emails              emfw                encrypt             encryption
enduser             engines             euweb               events
f-secure            filter              fr                  fsecure
git                 groups              hardware            hdd
heartbeat           hft                 honeypoint          httpd
imports             iproutes            iptables            ipv4
ipv6                jobs                kernel              ldap
licenses            log                 logdb               logging
login               logrotate           logs                logutils
lvm                 mailflow            maillog             mariadb
mcafee              megacli             mis                 modsec
monitor             mtadb               mtools              mysql
named               network             ntp                 os
passwords           patch               pe                  performance
permissions         plinx               plug-in             plugin
procmail            pwinfos             qexpire             quarantine
queue               queued              raid                regcomp
regulation          rename              replication         reporting
reports             routes              rpm                 rsyslog
saml                sar                 secureshare         security
sel                 selinux             sendmail            sensors
services            share               smartsearch         smtp
snmp                spam                sr                  ssh
sshd                ssl                 status              sudo
sync                syncbox             system              systemwatch
tap                 template            timing              tomcat
ud                  udev                update              upgrade
useradm             users               usersync            watchdog
yum


Installation:

The easiest method is to download a copy of the gzipped tar (.tgz) file,
upload to '/opt/proofpoint/' and uncompress. This should create the
'/opt/proofpoint/uddc/' directory. This should contain 5 files:
'example.dat', 'uddc', 'uddc.dat', 'uddc.sh', and 'README'. The
output file will also be placed in this directory by default.

The 'uddc.sh' script is the front-end for the UDDC. It can technically be
run from anywhere as long as 'uddc' is in the same directory but it is
recommended that everything remains in '/opt/proofpoint/uddc/' to minimize
any confusion.

If you need to download a new copy of the keywords data file (uddc.dat) but
don't need a new copy of the rest of the package you can download a copy from
the wiki. It should be placed in '/opt/proofpoint/uddc/' to overwrite the
one already in there. If you need to check the revision for the data file run
'head -1 uddc.dat' from the commandline.

The keyword data files are written in a format to allow for custom keyword
files as well as easy expansion to the current files should the need arise.
The keyword data files need to be in the following format:

keyword1,keyword2,keyword3,::type::/path/to/file(s) or command or url

Currently cfg, cmd, log, and url are the only valid types, anything else in
the type will be ignored. See 'example.dat' for additional examples.

See 'uddc -h' or 'uddc.sh --help' for additional information.

