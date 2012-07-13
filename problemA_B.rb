$dict_pos={'A'=>0,'B'=>1,'C'=>2,'D'=>3,'E'=>4,'F'=>5,'G'=>6,'H'=>7}
$route_list=[]
def Grid(pos,cmd)
	
	str_1='NSEW'
	$grid_list=[]
	dict_cell={}
	row=$dict_pos[pos[0]]
	column=Integer(pos[1])
	ans_row,ans_col=nil,nil
	for x in 0..7
		for y in 0..7
			dict={}
			if x==row and y==column
				str_1.split("").each do |z|
				
					if cmd == z
						dict[z]=1
						ans_row,ans_col=x,y
					elsif cmd==nil and z=='N'
						dict[z]=1
						ans_row,ans_col=x,y	
					else
						dict[z]=0
					end
				end
			else
				str_1.split("").each do |z|
					dict[z]=0
				end
			end
			x,y=x.to_s,y.to_s
			dict_cell[x+y]=dict
			x,y=Integer(x),Integer(y)
		end
	end
	$grid_list << dict_cell
	return ans_row,ans_col	
end

def Initialize(pos,cmd = nil)
	
	temp=[]
	row,col=Grid(pos,cmd)
	for k,v in $dict_pos do
		if v==Integer(row)
			temp << k
		end
	end
	row=temp[0]
	col=col.to_s
#	puts row+col
	$route_list << row+col
	return row+col	
end



def Row_Column_New(pos,direc)
	if direc=='N'
		column=Integer(pos[1])
		unless $dict_pos[pos[0]] ==0
			row=$dict_pos[pos[0]]-1
		else
			row=$dict_pos[pos[0]]+7
			
		end

	elsif direc =='S'
		column=Integer(pos[1])
		unless $dict_pos[pos[0]]==7
			row=$dict_pos[pos[0]]+1
		else
			row=$dict_pos[pos[0]]-7	 
		end

	elsif direc=='E'
		
		unless Integer(pos[1])==7
			
			column=Integer(pos[1])+1
		else
			column=Integer(pos[1])-7
		end
		row=$dict_pos[pos[0]]

	elsif direc=='W'
		unless Integer(pos[1])==0
			column=	Integer(pos[1])-1
		else
			column= Integer(pos[1])+7
		end
		row=$dict_pos[pos[0]]
	end

	return row.to_s,column.to_s	
end

def Move_Arrow(pos)
	
	data_dict={}
	temp=[]
	row=$dict_pos[pos[0]].to_s
	column=pos[1].to_s
	for x in $grid_list
		data_dict=x[row+column]
	end

	for direc,val in data_dict do
		
		if val ==1
			row_move,column_move=Row_Column_New(pos,direc)

			for k,v in $dict_pos do
				if v==Integer(row_move)
					temp << k

				end
			end
			row_move=temp[0]
			return Initialize(row_move+column_move,direc)
		end	
	end
	
end

def Left_Right_Arrow(pos,st)
	data_dict={}
	temp=[]
	row=$dict_pos[pos[0]].to_s
	column=pos[1].to_s
	for x in $grid_list
		data_dict=x[row+column]
	end
	for direc,val in data_dict do 
		if st=='L' and val==1	
			if direc =='N'	
				return Initialize(pos,'W')
			elsif direc == 'E'
				return Initialize(pos,'N')
			elsif direc == 'S'
				return Initialize(pos,'E')
			elsif direc == 'W'
				return Initialize(pos,'S')
			end
		elsif st=='R' and val==1
			if direc =='N'	
				return Initialize(pos,'E')
			elsif direc == 'E'
				return Initialize(pos,'S')
			elsif direc == 'S'
				return Initialize(pos,'W')
			elsif direc == 'W'
				return Initialize(pos,'N')
			end
		end
	end
end

def Action_string(pos,string)
	$pos_global=Initialize(pos)
	for st in string.split("")
		if  st == 'M'
			$pos_global=Move_Arrow($pos_global)
		elsif st =='L' or st == 'R'
			Left_Right_Arrow($pos_global,st)
		end
	
	end 	
end

#Action_string('A0','MLMLMMLMMMLMLMRLRLRMM')
#Action_string(ARGV[0],ARGV[1])



def raw_input(promt="")
	print promt
	gets
end

def Action_push(game)
	print "Welcome to Game  #{game} \n" 
	start_position=raw_input("Enter the start position :")
	string=raw_input("Enter the action string :")
		
	Action_string(start_position[0..(start_position.length-2)],string[0..(string.length-2)])
end

def start(option)
	
	if option[0..(option.length-2)] == 'A'
		Action_push("A")
		puts $route_list[$route_list.length-1]		
	elsif option[0..(option.length-2)] == 'B'
		Action_push("B")
		coloured_cell_list=['A0','A1','A2','A3','A4','A5','A6','A7',
		'B0','C0','D0','E0','F0','G0','H0','H1',
		'H2','H3','H4','H5','H6','H7','B7','C7','D7','E7','G7','F7']
		for route in $route_list
			for coloured_cell in coloured_cell_list
				if route == coloured_cell 
					lost=true
				end
			end
		end

		if lost
			puts "LOST"
		else
			puts "WON"
		end

	end	
end


if __FILE__ == $0
game=raw_input("Enter the Game you want to Play (A or B):")
start(game)
end


