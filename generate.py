import matplotlib.pyplot as plt
import numpy as np

def dLV(p,a,w,dt):
    return (a+np.dot(w,p))*p*dt

def LV(p,a,w,t,dt):
    x=p
    for ii in xrange(0,int(t/dt)):
        p=p+dLV(p,a,w,dt)
        x=np.vstack([x,p])
    return x

def run(N=10,offset=0.5,seed=6):
    np.random.seed(seed)
    w=np.random.rand(N,N)-offset
    a=np.random.rand(N)
    p=abs(np.random.rand(N))
    return LV(p,a,w,1000,0.05)
