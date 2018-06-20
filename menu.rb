def archivo_notas
  file = File.open('notas.csv', 'r')
  archivos = file.readlines
  file.close
  archivos
end

def archivo_promedios
  file = File.open('Promedios.csv', 'r')
  archivos = file.readlines
  file.close
  archivos
end

def menu
  puts 'Ingrese 1 para generar archivos con los promedios de cada alumno'
  puts 'Ingrese 2 para conocer las inasistencias'
  puts 'Ingrese 3 para saber quienes aprobaron (promedio mayor a 5)'
  puts 'Ingrese 4 para salir'
end

#Consultar si el archivo debe tener el nombre de los alumnos y dentro el promedio de cada uno
=begin
def promedios(archi)
  lines = archi.map(&:chomp)
  lines.each do |value|
    student = value.split(',')
    sum = 0
    for i in 1..5 do
      sum += student[i].to_i if student[i].to_i.is_a? Integer
    end
    fil = File.open("#{student[0]}.csv", 'w')
    fil.puts "Promedio: #{sum.to_f / (student.length - 1)}"
    fil.close
  end
  puts 'Archivos generados correctamente'
end
=end

#o generar un archillo llamado promedios con los resultados de cada uno dentro

def promedios(archi)
  lines = archi.map(&:chomp)
  fil = File.open("Promedios.csv", 'w')
  lines.each do |value|
    student = value.split(',')
    sum = 0
    for i in 1..5 do
      sum += student[i].to_i if student[i].to_i.is_a? Integer
    end
    fil.puts "#{student[0]}: #{sum.to_f / (student.length - 1)}"
    
  end
  fil.close
  puts 'Archivos generados correctamente'
end

def inasistencias(archi)
  puts 'Las inasistencias por alumno son:'
  lines = archi.map(&:chomp)
  suma = 0
  lines.each do |value|
    inasistant = value.split(',')
    suma += inasistant.count('A')
    puts "#{inasistant[0]}:#{inasistant.count('A')}"
  end
  puts "Con un total de: #{suma}"
end

def aprobados(archi, min)
  lines = archi.map(&:chomp)
  puts 'Los alumnos aprobados son:'
  lines.each do |valor|
    promedios = valor.split(' ')
    puts "#{promedios[0]} con promedio: #{promedios[1]}" if promedios[1].to_f >= min
  end
end

loop do |option|
  menu
  option = gets.chomp
  case option.to_i
  when 1
    promedios(archivo_notas)
  when 2
    inasistencias(archivo_notas)
  when 3
    if File.file?('Promedios.csv')
      aprobados(archivo_promedios, 5)
    else
      puts 'Debe calcular el promedio primero seleccionando la opcion 1'
    end
  when 4
    break
  else
    puts 'La opcion ingresada no es valida favor reintentar'
  end
  break if option == 4
end
