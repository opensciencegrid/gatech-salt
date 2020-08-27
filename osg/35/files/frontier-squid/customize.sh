awk --file `dirname $0`/customhelps.awk --source '{
setoption("acl NET_LOCAL src", "128.61.254.0/24 130.207.168.0/24 172.27.0.0/16 172.26.79.0/24")
setoption("cache_mem", "256 MB")
setoptionparameter("cache_dir", 3, "10000")  # 10GB
setoptionparameter("cache_dir", 1, "aufs")
print
}'

