
Route_list=[]
grid_list=[]
dict={}
dict_cell={}
str_1='NSEW'
dict_pos={'A':0,'B':1,'C':2,'D':3,'E':4,'F':5,'G':6,'H':7}

def Grid(pos, cmd):
	row=dict_pos[pos[0]]
	column=int(pos[1])
	ans_row,ans_col=None,None
	for x in range(0,8):
		for y in range(0,8):
			dict={}
			for z in str_1:
				if row==x and column==y :
					if cmd==z:
						dict[z]=1
						ans_row,ans_col=x,y	
						#print ans_row,ans_col
					elif cmd==None and z=='N':
						dict[z]=1
						ans_row,ans_col=x,y	
					else:
						dict[z]=0
				else:
					dict[z]=0
			
			x=repr(x)
			y=repr(y)
			dict_cell[x+y]=dict
			x=int(x)
	#import pdb;pdb.set_trace()		
	grid_list.append(dict_cell)
	
	return ans_row,ans_col

def Initialize(pos,cmd=None):
	row,col=Grid(pos,cmd)
	row=[k for k, v in dict_pos.iteritems() if v == int(row)][0]
	if not isinstance(col,str):
		col=repr(col)
	print row+col
	Route_list.append(row+col)
	return row+col	

#initialize('A0')

def Row_Column_New(pos,direc):
	#import pdb;pdb.set_trace()
	if direc=='N':
	#import pdb;pdb.set_trace()
		column=int(pos[1])
		if dict_pos[pos[0]] !=0:
			row=dict_pos[pos[0]]-1
		else:
			row=dict_pos[pos[0]]+7
	
	elif direc=='S':
		column=int(pos[1])
		if dict_pos[pos[0]]!=7:
			row=dict_pos[pos[0]]+1
		else:
			row=dict_pos[pos[0]]-7

	elif direc=='E':
		if int(pos[1])!=7:
			column=int(pos[1])+1
		else:
			column=int(pos[1])-7
		row=dict_pos[pos[0]]

	elif direc=='W':
		if int(pos[1])!=0:
			column=	int(pos[1])-1
		else:
			column= int(pos[1])+7
		row=dict_pos[pos[0]]

	return repr(row),repr(column)



def Move_Arrow(pos):
	row=repr(dict_pos[pos[0]])
	column=pos[1]
	for x in grid_list:
		data_dict=x[row+column]		
	#import pdb;pdb.set_trace()
	for direc,val in data_dict.iteritems():
		if val==1:		
			row_move,column_move=Row_Column_New(pos,direc)
			row_move=[k for k, v in dict_pos.iteritems() if v == int(row_move)][0]
			return Initialize(row_move+column_move,direc)
	


def Left_Right_Arrow(pos,st):
	#import pdb;pdb.set_trace()
	row=repr(dict_pos[pos[0]])
	column=pos[1]
	for x in grid_list:
		data_dict=x[row+column]
	for direc,val in data_dict.iteritems():
		if st=='L' and val==1:	
			if direc =='N':	
				return Initialize(pos,'W')
			elif direc == 'E':
				return Initialize(pos,'N')
			elif direc == 'S':
				return initialize(pos,'E')
			elif direc == 'W':
				return Initialize(pos,'S')
		elif st=='R' and val==1:
			if direc =='N':	
				return Initialize(pos,'E')
			elif direc == 'E':
				return Initialize(pos,'S')
			elif direc == 'S':
				return Initialize(pos,'W')
			elif direc == 'W':
				return Initialize(pos,'N')
								
def Action_string(pos,string):
	
	pos=Initialize(pos)
	for st in string:
		#import pdb;pdb.set_trace()
		if st =='M':
			pos=Move_Arrow(pos)
		elif st =='L' or st == 'R':
			Left_Right_Arrow(pos,st)
				
Action_string('B2','MRMLMRMRMRMMMMMMMLRRR')
Coloured_Cell_List=['A0','A1','A2','A3','A4','A5','A6','A7',
		    'B0','C0','D0','E0','F0','G0','H0','H1',
		    'H2','H3','H4','H5','H6','H7','B7','C7','D7','E7','G7','H7']
#import pdb;pdb.set_trace()
for route in Route_list:
	if route in Coloured_Cell_List:
		Lost=True
if Lost:
	print "LOST"
else:
	print "WON"
