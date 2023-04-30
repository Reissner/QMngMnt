#!/bin/sh -

dir=/opt/google/chrome/extensions
declare -A array
array[jabref]=bifehkofibaamoeaopjglfkddgkijdlh
array[markdown]=ckkdlimhmcjmikdlpkmbgfkaikojcbjk
array[googleDocs]=ghbmnnjooekpmoecnnnilnnbdlolhkhi
array[seAutoRefresh]=globgafddkdlnalejlkcpaefakkhkdoa
array[vDownloader]=eooikgjpbiiaebbbnjbcnmgggekfnhfj
array[webSecurity]=jdacdjpphmjekpfghmgfmniodedbdpih
array[zoomScheduler]=kgjfgplpablkjnlkjmjdecgdpfankdle

for i in "${!array[@]}"
do
  echo "install extension  : $i with id: ${array[$i]}"
cp ./chromeExtId.json $dir/${array[$i]}
done
