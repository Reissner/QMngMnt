
#!/bin/sh -
# run as user 

#INSTALLER=Miniconda3-latest-Linux-x86_64.sh

if ! test -d ~/SysAdmin ;
then
  mkdir ~/SysAdmin
fi

cd ~/SysAdmin

pwd
# this ensures only that some miniconda installer is present, 
# There is no update, except the old installer is removed manualy, 
# but this is not necessary either, because conda is updated later anyway. 
if ! test -f ./Miniconda3-latest-Linux-x86_64.sh ; 
then
  echo 'getting installer'
  wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
else
  echo 'found installer; if you want new, please manually delete'
fi

# check against sha in https://docs.conda.io/en/latest/miniconda.html
sha256sum Miniconda3-latest-Linux-x86_64.sh

if test -d ~/SysAdmin/MiniConda ; 
then
  # update
  echo 'starting update'
  sh Miniconda3-latest-Linux-x86_64.sh -b -u -p ~/SysAdmin/MiniConda
else
  # install new 
  echo 'starting new installation'
  sh Miniconda3-latest-Linux-x86_64.sh -b    -p ~/SysAdmin/MiniConda
fi

conda config --set auto_activate_base false

# update with installer and with conda itself sometimes work one against the other 
conda update conda -y

