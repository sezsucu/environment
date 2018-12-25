# finds out how many times each shell is being used

BEGIN {
    FS=":"
}
{
    shells[$7]++
}
END {
    for(i in shells) {
        print i ": " shells[i] " (" shells[i]/NR ")"
    }
}
