{
    for(i=1; i <= NF; i++)
        words[$i]++
}
END {
    for(i in words)
        printf "%20s: %d\n", i, words[i]
}
