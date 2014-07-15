This service was created aug 2012 for quality control of metagenomics sequence data.

Installation:

- call make-deploy from this directory
- switch to the deployment directory and call ./start_service

To stop the service:

- switch to the deployment directory and call ./stop_service

The service is available at the port 7052. This can be changed at the top of dancer_api.pl in the bin directory.
An error log of the service is written to the file nohub.out in the deployment directory.

Command line:
- consensus.py - nucleotide histogram
- kmer-tool - kmer profile
- drisee.py - DRISEE score and profile

After installation the scripts are in /kb/deployment/bin


For questions about this service contact

Andreas Wilke - wilke@mcs.anl.gov
Tobias Paczian - paczian@mcs.anl.gov
