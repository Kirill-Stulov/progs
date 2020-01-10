#<=============================== Готовый метод для пункта меню № 6.2 =====================================================>
# Поезд должен не просто отправляться на станцию, нужно проверять что он не находится на какой-либо еще станции
# и если находится, нужно его удалить с той станции и отправить на новую

#=begin   готовый метод перемещения поездов между станциями. Где станция @station - ключ, @number поезд - значение. Причем значение это массив и таким образом у одной станции может быть несколько поездов.  
class Check
	
	@@st_and_tr = {}                                                                                                          # @@st_and_tr переменная класса Check хранит массив всех хешей. class variable to use it within whole class, not just instances. Because there’s only one copy of a class variable shared by all instances of a class

	def move_to_st(station, number)  
		@station = station.to_sym
		@number = number
		@current_st = @@st_and_tr.detect{ |key, value| value.include?(@number)}												  # @current_st необходима, чтобы знать текущую станцию на котрой находится поезд @number, если он существует
	    
	    if @@st_and_tr.empty?                                                                                                 # 1. Если еще ничего не было записано. Если хеш @@st_and_tr еще пустой
	        @@st_and_tr[@station] = [@number]                                                                                   #  Добавляем хеш {@station => [@number]} в массив хешей @@st_and_tr. Этот способ (@@hash[@key] = [@value]) создания хеша и добавления его в массив есть в файле railway_station                         
	        puts "Первый поезд №#{@number} приехал на первую станцию #{@station}"
	    elsif @@st_and_tr.any?{|key, value| key == @station && value.include?(@number)}                                       # 2. Если в этом объекте уже есть станция @station с номером @number. Т.е при такой попытке отправить поезд на станцию на которой он уже находится - выдаем сообщение поезд уже на этой станции 
	    	puts "Поезд №#{@number} уже находится на станции #{@station}!"
	    elsif @@st_and_tr.keys.any?{|key| key == @station } && @@st_and_tr.values.any?{|val| val.include?(@number)}           # 3. Если такая станция @station отдельно существует в какой-либо из пар в массиве @@st_and_tr И номер поезда @number существует в какой-либо из пар в массиве @@st_and_tr
	        puts "Поезд №#{@number} отправляется со станции #{ @current_st[0] } на станцию #{@station}"                        
			@@st_and_tr[@current_st[0]].delete(@number) 																		# Т.к в этом случае поезд отбывает с одной станции и прибывает на другую. Удаляем его с текущей станции @current_st
			@@st_and_tr[@station] << @number                                                                                    # и добавляем поезд @number к уже существующей станции @station. 
	        puts "Поезд №#{@number} отбыл со станции #{@current_st[0]} и прибыл на станцию #{@station}"
	        p @@st_and_tr
	    elsif @@st_and_tr.keys.any?{|key| key == @station} && @@st_and_tr.values.any?{|val| val.include?(@number)} == false   # 4. Если такая станция @station отдельно существует в какой-либо из пар в массиве @@st_and_tr И номер поезда @number НЕ существует в какой-либо из пар в массиве @@st_and_tr
	    	@@st_and_tr[@station] << @number                        															#  то сразу добавляем поезд @number к уже существующей станции @station. Т.к поезд новый и нигде его еще не было.			
	    	puts "Еще один поезд под номером #{@number} приехал на станцию #{@station}"
	    	p @@st_and_tr
	    elsif @@st_and_tr.keys.any?{|key| key != @station} && @@st_and_tr.values.any?{|val| val.include?(@number)}			  # 5. Если такая станция @station отдельно НЕ существует в какой-либо из пар в массиве @@st_and_tr И номер поезда @number существует в какой-либо из пар в массиве @@st_and_tr	
	    	puts "Поезд №#{@number} отправляется со станции #{@current_st[0]} на станцию #{@station}"                           
	    	@@st_and_tr[@current_st[0]].delete(@number)                                                                         # Т.к в этом случае поезд отбывает с одной станции и прибывает на НОВУЮ. Удаляем его с текущей станции @current_st
	    	@@st_and_tr[@station] = [@number]  																					# и т.к раньше такая станция не существовала, добавляем в массив @@st_and_tr новый хеш с поездом @number и станцией @station
	    	puts "Поезд №#{@number} отбыл со станции #{@current_st[0]} и прибыл на новую станцию #{@station}"
	    	p @@st_and_tr
	    else #@@st_and_tr.keys.any?{|key| key != @station} && @@st_and_tr.values.any?{|val| val.include?(@number) == false}	  # 6. Очевидно что остался последний возможный вариант, который засунем в else, закоментил для большего понимания того, что происходит															
	    	@@st_and_tr[@station] = [@number]                                                                                   # А именно - Если такая станция @station отдельно НЕ существует в какой-либо из пар в массиве @@st_and_tr И номер поезда @number НЕ существует в какой-либо из пар в массиве @@st_and_tr
	    	puts "Новый поезд №#{@number} приехал на новую станцию #{@station}"													# то это хеш из новой станции и нового поезда! Его создаем и добавляем уже известным методом @@hash[@key] = [@value]  
	    	p @@st_and_tr
	    end
	end

end

# создаем объект
train1 = Check.new()    # если к примеру объект поезда не будет получать номер поезда от пользователя при вводе, или я ошибусь @number вместо @number
train2 = Check.new()     # будет выведено значение по умолчанию, а именно номер поезда - 10. По Сути в параметр Check.new() можно остовить пустым
train3 = Check.new()
train4 = Check.new()
train5 = Check.new()
train6 = Check.new()
train7 = Check.new()
train8 = Check.new()
train9 = Check.new()
train10 = Check.new()
train11 = Check.new()
train12 = Check.new()
train13 = Check.new()
train14 = Check.new()
train15 = Check.new()
train16 = Check.new()
train17 = Check.new()

# вызываем на объекте метод move_to_st
train1.move_to_st('b',2)    
train2.move_to_st('b',3)
train3.move_to_st('b',8)
train4.move_to_st('b',8)
train5.move_to_st('c',12)
train6.move_to_st('c',13)
train7.move_to_st('c',13)
train8.move_to_st('d',5)
train9.move_to_st('c',2)   # первая попытка добавить поезд который уже есть на станции b
train10.move_to_st('a',2)
train11.move_to_st('a',2)
train12.move_to_st('e',15)
train13.move_to_st('d',6)
train14.move_to_st('d',2)
train15.move_to_st('a',2)
train16.move_to_st('a',13)
train17.move_to_st('o',12)
train6.move_to_st('c',3)
train6.move_to_st('c',8)
train6.move_to_st('f',29)
train6.move_to_st('b',11)
train6.move_to_st('b',1)
