def file_grades
  file = File.open('notas.csv', 'r')
  content = file.readlines
  file.close
  content
end

def file_average
  file = File.open('Promedios.csv', 'r')
  content = file.readlines
  file.close
  content
end

def menu
  puts 'Ingrese 1 para generar archivos con los promedios de cada alumno'
  puts 'Ingrese 2 para conocer las inasistencias'
  puts 'Ingrese 3 para saber quienes aprobaron'
  puts 'Ingrese 4 para salir'
end

def average(archi)
  lines = archi.map(&:chomp)
  fil = File.open('Promedios.csv', 'w')
  lines.each do |value|
    student = value.split(',')
    sum = 0
    student.each do |i|
      sum += i.to_i if i.to_i.is_a? Integer
    end
    fil.puts "#{student[0]}: #{sum.to_f/(student.length - 1)}"   
  end
  fil.close
  puts 'Archivos generados correctamente'
end

def inasistants(archi)
  puts 'Las inasistencias por alumno son:'
  lines = archi.map(&:chomp)
  sum = 0
  lines.each do |value|
    inasistant = value.split(',')
    sum += inasistant.count('A')
    puts "#{inasistant[0]}:#{inasistant.count('A')}"
  end
  puts "Con un total de: #{sum}"
end

def aproved(archi, min = 5)
  lines = archi.map(&:chomp)
  puts 'Los alumnos aprobados son:'
  lines.each do |valor|
    averages = valor.split(': ')
    puts "#{averages[0]} con promedio: #{averages[1]}" if averages[1].to_f >= min
  end
end

loop do |option|
  menu
  option = gets.chomp
  case option.to_i
  when 1
    if File.file?('notas.csv')
      average(file_grades)
    else
      puts "el archivo 'notas.csv' no esta en el directorio del proyecto"
    end
  when 2
    inasistants(file_grades)
  when 3
    if File.file?('Promedios.csv')
      puts 'favor ingrese la nota minima para aprobar'
      mini = gets.chomp
      if mini.to_i > 0 && mini.to_i <= 10
        aproved(file_average, mini.to_i)
      else
        puts 'La nota minima debe estar entre 1 y 10 para determinar los aprobados'
      end
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
