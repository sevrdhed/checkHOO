require '/mnt/c/Users/stephen.heath/Ruby/checkHOO/getHoursOfOperationByID.rb'

  hash = getHoursOfOperationByID(1286)
  hoo = hash["resultSet"]["hoursOfOperationProfiles"]
  overridebranch = hoo[0]["overrideBranch"]
  if overridebranch != "None" 
  puts "Based on your hours of operation you are currently: CLOSED!"
  else

  rightnow = Time.now
  rightnowtime = rightnow.strftime( "%H%M%S" ) 
  rightnowday = rightnow.strftime( "%A" )
  case rightnowday
  when "Sunday"
  puts "It's Sunday!"
  dow = 0
  when "Monday"
  puts "It's Monday"
  dow = 1
  when "Tuesday"
  puts "It's Tuesday"
  dow = 2
  when "Wednesday"
  puts "It's Wednesday!"
  dow = 3
  when "Thursday"
  puts "It's Thursday!"
  dow = 4
  when "Friday"
    puts "It's Friday"
    dow = 5
  when "Saturday"
    puts "It's Saturday!"
    dow = 6
  else
  puts "It is no day"
  dow = 0
  end
  open = hoo[0]["days"][dow]["openTime"]
  close = hoo[0]["days"][dow]["closeTime"]
  open.delete! ":"
  close.delete! ":"
  
  if rightnowtime > open && rightnowtime < close
  
  puts "Based on your hours of operation you are currently: OPEN!"
  else
  puts "Based on your hours of operation you are currently: CLOSED!"
  end
  end