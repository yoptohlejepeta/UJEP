from random import randint

x = 'x'
o = 'o'
field = [['P', x, o, o],
         [o, x, o, o],
         [o, x, o, o],
         [o, x, x, x]]

class Model:
    def __init__(self, x, y, klon_cislo):
        self.x = x
        self.y = y
        self.klon_cislo = klon_cislo
    
    def pozice(self):
        return [self.x, self.y]
    
    def pozice_str(self):
        return str(self.x) + str(self.y)
    
    def pohyb_doprava(self):
        self.x = self.x + 1
    
    def pohyb_doleva(self):
        self.x = self.x - 1
    
    def pohyb_dolu(self):
        self.y = self.y + 1
    
    def pohyb_nahoru(self):
        self.y = self.y - 1


pandula = Model(0,0,1)
pohyby = {}
# moznosti = [pandula.pohyb_doprava, pandula.pohyb_doleva, pandula.pohyb_dolu, pandula.pohyb_nahoru]

while pandula.pozice() != [len(field) - 1,len(field[0]) - 1]:
    xy1 = pandula.pozice()
    xy_str = pandula.pozice_str()
    
    if pohyby.get(xy_str) == None:
        pohyb = randint(0,1)
    else:
        pohyb = pohyby.get(xy_str)
    if pohyb == 0:
        pandula.pohyb_doprava()
    else:
        pandula.pohyb_dolu()
    xy2 = pandula.pozice()
    try:
        if field[xy2[1]][xy2[0]] != x:
            field[xy2[1]][xy2[0]] = 'P'
            for i in field:
                print(i)
            print('-------------------')
            pandula = Model(0,0,pandula.klon_cislo+1)
            print(f'ITERACE Č. {pandula.klon_cislo}')
            field = [[x, x, o, o],[o, x, o, o],[o, x, o, o],[o, x, x, x]]
        else:
            field[xy2[1]][xy2[0]] = 'P'
            pohyby[xy_str] = pohyb
            for i in field:
                print(i)
            print('-------------------')
    except:
        pandula = Model(0,0,pandula.klon_cislo+1)
        field = [[x, x, o, o],[o, x, o, o],[o, x, o, o],[o, x, x, x]]
print(f'KLON Č. {pandula.klon_cislo} TO DOKÁZAL!')