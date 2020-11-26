import sys

#再帰関数の上限突破。1万10回に。
sys.setrecursionlimit(10010)

cnt = 0

path = "/root"

def strgen(cnt):
    if cnt == 500:
        return "{id:501, name:'last', path:501 }," 

    cnt += 1
    s =  str(cnt).ljust(200,'あ')
    return "{id:" + str(cnt) + ",name:'" + s + "',path:" + str(cnt) + ",children:[" + strgen(cnt) + "] },"


s = strgen(cnt)
try:
    with open("./generated.txt", 'wt') as f:
        f.write(s)
except Exception as e:
    print(e)
finally:
    f.close()

print("おわり")

