
( 
	wget -P latest-zip -- https://code.onedev.io/onedev/server/~site/onedev-latest.zip && 
	(cd -- latest-zip && unzip onedev-latest.zip) && 
	: ) & 
( 
	wget -P latest-tgz -- https://code.onedev.io/onedev/server/~site/onedev-latest.tar.gz && 
	(cd -- latest-tgz && tar --file onedev-latest.tar.gz --extract --ungzip --verbose) && 
	: ) & 
( 
	wget -P version-zip -- https://code.onedev.io/~downloads/projects/160/builds/7358/artifacts/onedev-15.0.7.zip && 
	(cd -- version-zip && unzip onedev-15.0.7.zip) && 
	: ) & 
( 
	wget -P version-tgz -- https://code.onedev.io/~downloads/projects/160/builds/7358/artifacts/onedev-15.0.7.tar.gz && 
	(cd -- version-tgz && tar --file onedev-15.0.7.tar.gz --extract --ungzip --verbose) && 
	: ) & 

wait

( cd latest-zip/onedev-latest && find -- . -type f -name '*' | xargs b3sum ) | cat > chksums-latest-zip.b3sum & 
( cd latest-tgz/onedev-latest && find -- . -type f -name '*' | xargs b3sum ) | cat > chksums-latest-tgz.b3sum & 
( cd version-zip/onedev-15.0.7 && find -- . -type f -name '*' | xargs b3sum ) | cat > chksums-version-zip.b3sum & 
( cd version-tgz/onedev-15.0.7 && find -- . -type f -name '*' | xargs b3sum ) | cat > chksums-version-tgz.b3sum & 

wait

diff --report-identical-files --rcs -- 	chksums-version-zip.b3sum	chksums-version-tgz.b3sum	#: compare tgz/zip for version
diff --report-identical-files --rcs -- 	chksums-latest-zip.b3sum	chksums-latest-tgz.b3sum	#: compare tgz/zip for latest
diff --report-identical-files --rcs -- 	chksums-version-tgz.b3sum	chksums-latest-tgz.b3sum	#: compare version/latest for tgz
diff --report-identical-files --rcs -- 	chksums-version-zip.b3sum	chksums-latest-zip.b3sum	#: compare version/latest for zip
