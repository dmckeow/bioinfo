### Interproscan
https://interproscan-docs.readthedocs.io/en/latest/UserDocs.html#obtaining-a-copy-of-interproscan
A path to the database for interproscan must be provided by the user via config to use it in nextflow
Get a specific version of the database for the nf-core module:
```
wget https://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/5.59-91.0/interproscan-5.59-91.0-64-bit.tar.gz
wget https://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/5.59-91.0/interproscan-5.59-91.0-64-bit.tar.gz.md5

md5sum -c https://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/5.59-91.0/interproscan-5.59-91.0-64-bit.tar.gz.md5

tar -pxvzf interproscan-5.59-91.0-64-bit.tar.gz
cd interproscan-5.59-91.0
python3 setup.py -f interproscan.properties
```
There are various issues that can arise with Interproscan...
https://interproscan-docs.readthedocs.io/en/latest/KnownIssues.html

In the end, I could not get the nf-core module to work, because there is some mismatch between conda/singularity and the stupid archaic way that interproscan must be installed
So the module included is a modifeid copy of the nf-core made to just use the local installation without any container