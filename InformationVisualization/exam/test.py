import pypsa
import numpy as np
import random

n_buses = 12

network = pypsa.Network()

for i in range(n_buses):
    network.add("Bus","My bus {}".format(i),
                v_nom=220)

for i in range(n_buses-1):
    network.add("Line","My line {}".format(i),
                bus0="My bus {}".format(i),
                bus1="My bus {}".format((i+1)%n_buses),
                x=0.1,
                r=0.01)

#print(network.buses)
#print(network.lines)


network.add("Generator","My gen",
            bus="My bus 0",
            p_set=400,
            control="PQ")

# network.add("Load","My load",
#             bus="My bus 1",
#             p_set=100)

n_loads=n_buses-1
for i in range(n_loads):
    network.add("Load","My load {}".format(i),
                bus="My bus {}".format(i),
                p_set=random.randint(90,99))


result=[]
for i in range(10):
    network.loads.p_set= 100+random.randint(-50,50)
    network.loads.q_set= 100+random.randint(-50,50)

    #print (network.loads)
    network.pf()
    result.append(network.buses_t.v_mag_pu)

for i in result:
    print (i['My bus 4']['now'])


