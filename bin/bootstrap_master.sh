curl -o bootstrap-salt.sh -L https://bootstrap.saltstack.com
# Bootstrap Salt Master
sudo bash bootstrap-salt.sh -M
# Update Master config. 
sudo bash -c "cat > /etc/salt/master.d/fileserver_backend.conf <<- _EOF1_
fileserver_backend:
  - roots
  - git
_EOF1_
"
sudo bash -c "cat > /etc/salt/master.d/gitfs_remotes.conf <<- _EOF1_
gitfs_remotes:
  - https://github.com/zentrung/swapfile-formula.git
_EOF1_
"
sudo bash -c "cat > /etc/salt/master.d/log_level.conf <<- _EOF1_
log_level: info
_EOF1_
"
sudo systemctl restart salt-master
# Update Minion config.
sudo bash -c "cat > /etc/salt//minion.d/master.conf <<- _EOF1_
master: `hostname`
_EOF1_
"
sudo bash -c "cat > /etc/salt/minion.d/log_level.conf <<- _EOF1_
log_level: info
_EOF1_
"
sudo systemctl restart salt-minion
# Accept key
sudo salt-key -a `hostname`

cd /tmp
git clone git@github.com:zentrung/myss.git
sudo mv ~/myss /opt/
sudo ln -s /opt/myss/salt /srv/
sudo ln -s /opt/myss/pillar /srv/

