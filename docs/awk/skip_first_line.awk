BEGIN {
    getline;
    print "Skipped first line: |" $0 "|"
    print "Now processing the rest"
}
{ print $0 }

