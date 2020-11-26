#配列
arr = []

try:
    file = open("./bookscan_list_20201005_org.html")

    lines = file.readlines()
    for line in lines:
        pos_s = line.strip().find('title=')
        if pos_s != -1:
            pos_e = line.strip().find('"', pos_s+7)
            arr.append(line.strip()[pos_s+7:pos_e])
            
except Exception as e:
    print(e)
finally:
    file.close()

arr.sort()
arr2 = list(set(arr))

try:
    str_ = '\n'.join(arr2)
    with open("./list_bookTitle.txt", 'wt') as f:
        f.write(str_)
except Exception as e:
    print(e)
finally:
    f.close()