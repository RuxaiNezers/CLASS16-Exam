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

def promedios(archi)
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

def aprobados(archi, min = 5)
  lines = archi.map(&:chomp)
  puts 'Los alumnos aprobados son:'
  lines.each do |valor|
    promedios = valor.split(': ')
    puts "#{promedios[0]} con promedio: #{promedios[1]}" if promedios[1].to_f >= min
  end
end

loop do |option|
  menu
  option = gets.chomp
  case option.to_i
  when 1
    if File.file?('notas.csv')
      promedios(archivo_notas)
    else
      puts "el archivo 'notas.csv' no esta en el directorio del proyecto"
    end
  when 2
    inasistencias(archivo_notas)
  when 3
    if File.file?('Promedios.csv')
      puts 'favor ingrese la nota minima para aprobar'
      minimo = gets.chomp
      if minimo.to_i > 0 && minimo.to_i <= 10
        aprobados(archivo_promedios, minimo.to_i)
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
