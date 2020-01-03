from oct2py import octave
import json

x=np.array(1,2,3,4)

def newNode(name,parent):
    output={
    "name": name,
    "parent": parent,
    "children":[]
    }
    return output

# def newNode(id,group):
#     return {"id":id,"group":group}
# def newLink(source,target,value):
#     return {"source":source,"target":target,"value":value}

branch=octave.eval('branchCreator')
subs=branch['string']['building']['subst'].tolist()
subs=[str(i.replace('0','')) for i in subs]
_subs=list(dict.fromkeys(subs))
conc=branch['string']['building']['conc'].tolist()

# MV=newNode('MV',"null")
# for s in _subs:
#     childList=[]
#     a=str(s)
#     for c in conc:
#         if c.startswith(s):
#             childList.append(newNode(c,s))
#     substation=newNode(a,'MV')
#     substation['children']=childList
#     MV['children'].append(substation)
# print MV

MV=newNode('MV',"null")
for s in _subs:
    childList=[]
    a=str(s)
    for i in range(len(subs)):
        #print conc[i]
        #print subs[i]
        if s==subs[i]:
            childList.append(newNode(conc[i],s))
    substation=newNode(a,'MV')
    substation['children']=childList
    MV['children'].append(substation)

json.dump(MV,open('jsonDatatree.json','w'))

# jsonData={"nodes":[],"links":[]}
# jsonData['nodes'].append(newNode('MV',1))
# for s in _subs:
#     jsonData['nodes'].append(newNode(s,_subs.index(s)))
#     jsonData['links'].append(newLink('MV',s,2))
#     for i in range(len(subs)):
#         if s==subs[i]:
#             jsonData['nodes'].append(newNode(conc[i],_subs.index(s)))
#             jsonData['links'].append(newLink(s,conc[i],1))

#json.dump(jsonData,open('jsonData.json','w'))
