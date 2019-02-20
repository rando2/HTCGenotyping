import csv

with open('reffile.sizes', 'rb') as csvfile:
    lengthsheet = csv.reader(csvfile, delimiter='\t')
    used = []
    rem = []
    byname = {}
    for l in lengthsheet:
        sc, leng = l[:3]
        byname[sc]=int(leng)
        rem.append(sc)

record = open("int-length.txt","w")
i=1
intct=1

while i <= 3154:
    if rem[i-1] == 0: #if this has been used, skip
        i +=1
        continue
    
    scname = "scaffold" + str(i)
    out =  scname + '\n' #prep outfile
    currentlen = byname[scname] #how long are we starting with?
    c = 1
    while currentlen < intsize and i + c + 1 <= 3155:
        if currentlen + byname["scaffold" + str(int(i+c))] <= intsize:
            if rem[i+c-1] != 0:
                currentlen += byname["scaffold" + str(int(i+c))]
                rem[i+c-1] = 0
                used.append("scaffold" + str(int(i+c)))
                out += "scaffold" + str(int(i+c)) + "\n"
        c +=1
                
    rem[i-1] = 0
    used.append(scname)

    record.write(str(intct) + '\t' + str(currentlen) + '\t' + out.replace('\n',';') + '\n')

    outfile = open('./intervals/int' + str(intct) + '.list', 'w')
    outfile.write(out)
    outfile.close()
    intct +=1

record.close()
print len(used)
