BEGIN {
    i = 0
}
{ i++ }
END {
    print i
    # print NR
}
