awk --file `dirname $0`/customhelps.awk --source '{
setoption("acl NET_LOCAL src", "130.207.168.0/24 172.26.79.0/24")
setoption("cache_mem", "256 MB")
setoptionparameter("cache_dir", 3, "10000")  # 10GB
setoptionparameter("cache_dir", 1, "aufs")
print
}'

