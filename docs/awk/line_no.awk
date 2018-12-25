BEGIN {
    i = 0
}
{
    i++
    print i ": " $0
    # print NR ": " $0
}

