file = File.open("notas.csv", "r")
archivo = file.read
file.close

def menu
	puts "Ingrese 1 para generar archivos con los promedios de cada alumno"
	puts "Ingrese 2 "
	puts "Ingrese 3 "
	puts "Ingrese 4 para salir"
end

def promedios(content) #Consultar si el archivo debe tener el nombre de los alumnos y dentro el promedio
  lines = content.split("\n")
  lines.each do |value|
    student = value.split(',')
      sum = 0
      for i in 1..5 do
        if student[i].to_i.is_a? Integer
          sum+=student[i].to_i	
        end
      end
      fil = File.open("#{student[0]}.csv", "w")
      fil.puts "Promedio: #{sum.to_f / ((student.length)-1)}"
      fil.close
  end
  puts "Archivos generados correctamente"
end

def inasistencias(content)

end

loop do |option|
	menu
	option = gets.chomp
	case option.to_i
	when 1
		promedios(archivo)
	when 2
		inasistencias(archivo)
	when 3

	when 4 
		break
	else
		"La opcion ingresada no es valida favor reintentar"
	end
	break if option == 4
end