#!/bin/sh

# GPlusAlbum:
# Download Google Plus albums from the command line
#
# Copyright © 2015 RÁCZ András <torzsmokus@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case $1 in
https://plus.google.com/photos/*)
	if which wget
	then
		wget --header="Cookie: $2" -O album.html "$1"
		grep '"https://lh..googleusercontent.com/.*",\[' album.html | sed 's%,"\(https://lh..googleusercontent.com/.*\)",\[".*%\1=w0-h0%' >images 
		wget -c -i images --content-disposition
		rm album.html images
	else
		echo This tool uses wget but you don’t seem to have it ☹ 
		exit 2
	fi
	;;
*)
	cat <<-EOM
		GPlusAlbum:
		Download Google Plus albums from the command line
		Copyright © 2015 RÁCZ András <torzsmokus@gmail.com>
		
		Usage: $0 URL [cookies]
		
		Arguments:
		
		url     -- the URL of the album. Examples: (↩ means the string continues)
		             Public or private album:
		               https://plus.google.com/photos/104097544829614561249/↩
		                 albums/5657903497559822497
		             Private album, shared via link (note the 'authkey' at the end):
		               https://plus.google.com/photos/104097544829614561249/↩
		                 albums/5657903503669526433?authkey=COCavvC1-piwYA
		cookies -- For a private album without a 'sharable' link, you need to 
		             provide the cookies you got from plus.google.com after 
		             signing in. e.g. "NID=67=pbiRG7SiPn…:SG=1:S=FJmBF1idMPB9C1GK"
	EOM
	exit 1
	;;
esac

