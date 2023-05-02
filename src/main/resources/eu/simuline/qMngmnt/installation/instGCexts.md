<!-- markdownlint-disable no-trailing-spaces -->
<!-- markdownlint-disable no-inline-html -->

# Installing and installed Extensions for Google Chrome 

The technique to install extensions to Google Chrome is published 
for various cases e.g. [Linux](https://developer.chrome.com/docs/extensions/mv3/external_extensions/#preference-linux). 

We restrict ourselves to Linux and to extensions in the 
[web store](https://chrome.google.com/webstore/category/extensions?hl=de) 
which is also available under the URL `chrome://extensions/` in the menu. 

The first thing to do is to install the extension manually from the web store. 
With the URL `chrome://extensions/` each installed extension may be found and in particular its ID, 
as an example `aaabbbcccdddeeefff`. 
Of course, if it shall be checked that the installation by script works fine, 
one has to remove that extension again. 
The problem is, that by doing so, the extension is blacklisted and installation by script is blocked. 
Unblocking is just by installing and uninstalling again. 

Then, as we only install extensions from the web store, 
one has to create a [JSON file](./chromeExtId.json) with the following content 

```[json]
{
  "external_update_url": "https://clients2.google.com/service/update2/crx"
}
```

The name of that file is derived from the ID of the extension, i.e. `aaabbbcccdddeeefff.json`. 

Then this file must be saved in either of the two locations 

- `/opt/google/chrome/extensions/`
- `/usr/share/google-chrome/extensions/`

In addition, it must be world readable. 
All this is done 
in a separate installation script [instGCexts.sh](./instGCexts.sh). 


