# Files
Github requires the files to be 50M in sizes only.  In order to respect that, we will use the command below to tar and split the files into 50M chunks.

```
tar -czvf - myfile | split -b 50M - myfile.tar.gz
```