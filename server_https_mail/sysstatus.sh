#!/bin/bash
# cron : * * * * * sysstatus.sh 
html_top="<!DOCTYPE html>
<html>
<head>
<meta name=\"robots\" content=\"noindex\">
<link rel=\"shortcut icon\" type=\"image/png\" href=\"poro-sad.png\" />
<title>Status</title>
</head>
<body>
 <table>
"


html_bot='</table></body></html>'

html_name='status.html'
html_location='/usr/share/nginx/html2/'$html_name
status='<tr><th>'$(date)'</th></tr>'

function systemctl_get_status {
    status=$status'<tr><th>'$1' : '$(systemctl is-active $1)'</th></tr>'
}

systemctl_get_status 'opendkim'
systemctl_get_status 'postfix'
systemctl_get_status 'nginx'
systemctl_get_status 'hangupsbot'
systemctl_get_status 'openvpn-server@openvpn.service'

html_file=$html_top$status$html_bot

echo $html_file > $html_location
