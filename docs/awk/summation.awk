# awk -f summation.awk ../data/numbers.txt
BEGIN {
    sum=0
}
{
    sum+=$1
}
END {
    print "Result: " sum
}
