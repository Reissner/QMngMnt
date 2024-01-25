#!/bin/sh -

# run as root 

dir=/opt/google/chrome/extensions
#dir=/usr/share/google-chrome/extensions/
declare -A exts
# jabref browser extension 
exts[jabref]=bifehkofibaamoeaopjglfkddgkijdlh
# BibItNow 0.908
exts[BibItNow]=bmnfikjlonhkoojjfddnlbinkkapmldg

# https://github.com/simov/markdown-viewer
exts[markdown]=ckkdlimhmcjmikdlpkmbgfkaikojcbjk

exts[googleDocs]=ghbmnnjooekpmoecnnnilnnbdlolhkhi

exts[seAutoRefresh]=globgafddkdlnalejlkcpaefakkhkdoa
# Auto Refresh Plus | Page Monitor 7.5.0
exts[seAutoRefreshB]=hgeljhfekpckiiplhkigfehkdpldcggm

# VideoDowloader 2.5 videosaverpro.com
exts[vDownloaderB]=ihackilhcefdlfoehlhlamloflhofcme
exts[vDownloader]=eooikgjpbiiaebbbnjbcnmgggekfnhfj

# AVG online security www.avg.com
exts[avgSecurity]=nbmoafcmbajniiapeidgficgifbfmjfo
exts[webSecurity]=jdacdjpphmjekpfghmgfmniodedbdpih

# zoom scheduler 1.8.16 
exts[zoomScheduler]=kgjfgplpablkjnlkjmjdecgdpfankdle

# React Developer Tools
exts[reactDevTools]=fmkadmapgofadopljbjfkapdkoienihi

for i in "${!exts[@]}"
do
  echo "install extension  : $i with id: ${exts[$i]}"
  cp ./chromeExtId.json $dir/${exts[$i]}
done
