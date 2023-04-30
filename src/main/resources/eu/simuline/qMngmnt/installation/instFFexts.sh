#!/bin/sh -

wget -nc https://addons.mozilla.org/firefox/downloads/file/3987191/wot_safe_browsing_tool-20220804.0wot.xpi
wget -nc https://addons.mozilla.org/firefox/downloads/file/4040817/video_downloadhelper-7.6.6.xpi
wget -nc https://addons.mozilla.org/firefox/downloads/file/4080833/adblock_plus-3.16.2.xpi
wget -nc https://addons.mozilla.org/firefox/downloads/file/3898690/jabref-2.5.xpi

find . -name "*.xpi" -exec firefox {} \;

# The user still has to acknowledge manually twice and close the browser also manually 
# for each extension. 
# Then the script returns. 
