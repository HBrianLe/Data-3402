#!/home/brian/anaconda3/bin/python
import sys,zipfile,os,shutil,time,wget,re
from pathlib import Path
from multiprocessing import Process, Queue, Pool
from datetime import date, timedelta

if __name__ == "__main__":
    ip1 = sys.argv[1]
    ip2 = sys.argv[2]
    ip3 = sys.argv[3]
    ip4 = sys.argv[4]
    ip5 = sys.argv[5]
    ip6 = sys.argv[6]
    ip7 = sys.argv[7]
    



    print('\n Downloading Lahman Zip \n')                                          #print statement
        
    R =  Path('./Lahman')                                                          #make path
    if R.exists() is False:                                                        #check if path does not exist
        os.makedirs('Lahman')                                                      #Make path if not
    os.chdir("./Lahman")                                                           #go to the new path
    try: 
        wget.download('http://seanlahman.com/files/database/baseballdatabank-master_2018-03-28.zip', 'lahman.zip')#download the zipfile
        zipfile.ZipFile('lahman.zip').extractall('.')                              #Unzip file
        os.remove('lahman.zip')                                                    #remove file from system 
    except:
        pass
    os.chdir('..')      
    
    
    
    
    
    print(' \n Downloading Player CSV \n')                                                      #print statment
        
    p = 'https://www.retrosheet.org/retroID.htm'                                                #URL download
    wget.download(p, 'player.csv')                                                              #download link

    with open('player.csv', encoding='cp1252') as f:                                            #Open file
        lines = f.readlines()                                                                   #read lines of file
    r = "(\w+,\w+,\w+,\w+/\S+)"                                                                 #regex lines
    match = re.finditer(r,str(lines))                                                           #search to match in the file
        
    print(' \n Parsing Player CSV \n')
        
    with open("players.csv", "w") as f1:                                                        #make new player file
        f1.write('ID'+','+'Last'+','+'First'+','+'Play_debut'+','+'Mgr_debut'+','+'Coach_debut'+','+'Ump_debut'+"\n")
        for m in match:
            f1.write(m.group(1) + '\n')                                                         #write the group to file
    os.remove('player.csv')                                                                     #remove file
    
    print('\n Downloading Retrosheets zips \n ')                                                
    R =  Path('./Retrosheets/Roster')                                                           #make path
    if R.exists() is False:                                                                     #check if exist
        os.makedirs('Retrosheets/Roster')                                                       #Make path if needed
    T =  Path('./Retrosheets/Team')
    if T.exists() is False:
        os.makedirs('Retrosheets/Team')
    E =  Path('./Retrosheets/Events')
    if E.exists() is False:
        os.makedirs('Retrosheets/Events')
    try:   
        shutil.move('players.csv', './Retrosheets')                                             #move the player file to retrosheets folder
    except:
        pass

    for i in range(1900,2020):                                                                  #Range of year
        try: 
            year = i                                                                            #set year to the loop
            p = 'https://www.retrosheet.org/events/' + str(year) + 'eve.zip'                    #URL maker
            wget.download(p)                                                                    #download Zip
            print('\n Downloading Regular Season: ' + str(year) )                               #print statment
            zipfile.ZipFile(str(year) + 'eve.zip').extractall('.')                              #unzip
            for file in os.listdir("./"):                                                       #get the files in this section
                try:
                
                    if file.endswith(".ROS"):
                        shutil.move(file, R)
                    elif file.endswith(str(year)):
                        shutil.move(file, T)
                    elif file.endswith(".EVN"):
                        shutil.move(file, E)
                    elif file.endswith(".EVA"):
                        os.remove(file)
                    elif file.endswith("EVN"):
                        os.remove(file)
                    elif file.endswith("EDA"):
                        os.remove(file)
                    elif file.endswith("EDN"):
                        os.remove(file)
                    elif file.endswith("zip"):
                        os.remove(file)
                except:
                    os.remove(file)
        except:
            pass

    for i in range(1900,2020):
        try: 
            year = i
            p = 'https://www.retrosheet.org/events/' + str(year) + 'post.zip'
            wget.download(p)
            print('\n Downloading Playoffs: ' + str(year) )
            zipfile.ZipFile(str(year) + 'post.zip').extractall('.')
            for file in os.listdir("./"):
                try:

                    if file.endswith(".EVE"):
                        shutil.move(file, E)
                    elif file.endswith(str(year)):
                        os.remove(file)
                    elif file.endswith("ROS"):
                        os.remove(file)
                    elif file.endswith("zip"):
                        os.remove(file)
                except:
                    os.remove(file)
        except:
            pass

        def get_GIDs(q):
                '''
                Function to get GameIDs and Random Game Numbers
                Input: Queue of dates of a range
                Output: Queue and dictionary of the GameIDs and Random Numbers, List of all directories with Game Numbers, 
                Note: Make sure the function of this directory is located in the 
                '''

                day = q.get()                                                                                              #Get the first item in the Queue    
                All_urls = []                                                                                              #Start a list of all the Searchable URLs 
                while (day != 'Done'):
                    All_urls.append('./MLB_Gameday_Data/year_' + str(day[0:4]) + '/month_'+ str(day[5:7]) + '/day_' + str(day[8:10])) #making the URLs with string slicing. Append it to the list                            
                    day = q.get()                                                                                          #Get the next queue item for the while loop
                ID_dic = {}                                                                                                #make a dictionary 
                GID_queue = Queue()                                                                                        #make a new queue for the GIDs to be placed in

                r = '(\w+)/\S\S(\w+_[0-9]{4}_[0-9]{2}_[0-9]{2}_\w+_\w+_[0-9])'                                             #this is the Regex code for the GIDs. first group is for the random numbers , second group is for the GIDs
                for i in range(0,len(All_urls)):                                                                           #for loop for the length of the URLs. We read the index file in each folder
                    with open(All_urls[i] + '/index.html', 'r') as f:
                        try:                                                                                               #we try to read if there is a file and match the regex 
                            lines = f.readlines()
                            matches = re.finditer(r,str(lines))                                                            #for any matches we will match them in the groupings
                            for m in matches:
                                GID_queue.put(m.group(2))                                                                  #For each match, we will queue the GIDs
                                ID_dic[m.group(1)] = m.group(2)                                                            #Create a dictionary with Random Numbers Keys and GIDs Values
                        except:
                            pass
                GID_Search(ID_dic, GID_queue, All_urls)                                                                    #Call the new function because we are using local variables 



        def GID_Search(Dict, GID, url):
                '''
                Function to check GIDs and Random Numbers to match them. 
                Input: Dictionary of game values and GIDs, a queue of GIDs , a list of URls that are searchable
                Output: create new directories of the GIDs and move them to the new Directory called MLB_GIDs in the Main project folder

                '''
                home_dir = os.getcwd()                                                                                     #takes the home Directory that is set for the project to be created in
                MLB_GIDs =  Path('./MLB_GIDs')                                                                             #Checks if MLB_GIDs Directory is existing, if not, create the path
                if MLB_GIDs.exists() is False:
                    os.makedirs('./MLB_GIDs')
                Move_file = home_dir + '/MLB_GIDs'
                GID.put('Done')                                                                                            #adds done to the then of the queue to know when to stop
                GameID = GID.get()
                urlNumber = 0
                while (GameID != 'Done' and urlNumber < len(url)):                                                         #when both the queue is not done and the URLs are not all gone though do this function below

                    os.chdir(home_dir)                                                                                     #go to the home dir
                    os.chdir(url[urlNumber])                                                                               #go to the Directory that is to be searched
                    list_dir = os.listdir()                                                                                #get a list of items in the directory 
                    GameID = GID.get()
                    urlNumber += 1                                                                                         #update the URL
                    try:                                                                                                   #try if there are items in the directory listed
                        for i in list_dir:                                                                                 #for each item in the directory, add it to the list but only if it is not the index.html file in each directory
                            Game_numbers = []
                            if i != 'index.html':
                                Game_numbers.append(i)

                            for i in Game_numbers:                                                                         #for each item in that list without the index.html file
                                File_name = Dict.get(i)                                                                    #search that item in the directory keys to get a value and set that to the variable File_name
                                
                                try:                                                                                       #try function here is to try to create and move files, if the game already exist then you do not have to do anything but if not create and move
                                    GID_path =  Path('./MLB_GIDs/' + str(File_name))                                       #Make a path URL
                                    if GID_path.exists() is False:                                                         #check if it exist and if not make it 
                                        os.makedirs(Move_file+ '/' + str(File_name))
                                    os.chdir('./' + i )                                                                    #go into the Random numbers folder that contains 2 xml files
                                    xml_files = os.listdir()                                                               #get a list of that directory items
                                    for i in xml_files:                                                                    #for each item in that directory, move it to the new directory that was created
                                        shutil.copyfile(i, Move_file + '/' + str(File_name) + '/' + str(i))                #used the copy file function to move
                                        
                                    os.chdir('..')                                                                         #go back one directory to get back to the go the the next random number in the file
                                except:
                                    pass                                                                                   #if the file already exist then pass on the function


                    except:
                        pass                                                                                               #if there are no files in the directory, pass


        def run_action(year1,month1,day1,year2,month2,day2,threads):                                                      #run_action is a function that will be called to run all the MLB_GIDs part 1 of the project
                Daysqueue = Queue()                                                                                        #create a queues for dates to be inserted into

                
                start = date(year1,month1,day1)                                                                            #using userinput, create an start date
                today = date(year2,month2,day2)                                                                            #using userinput, create an end date
                day = start                                                                                                #change of variable
                while(day <= today):
                    Daysqueue.put(day.isoformat())                                                                         #place the date into the queue, this is in isoformat , so it is a string. This is because the format is used to strip for the URLs above
                    day += timedelta(1)                                                                                    #to the next day in the timeline
                Daysqueue.put('Done')                                                                                      #place done at the end of the queue

                num_threads = threads                                                                                      #create threads based on the userinput
                thrds = []
                for i in range(num_threads):                                                                               #do the multitreading based the queues and pass function as args
                    p = Process(target = get_GIDs, args=[Daysqueue])
                    thrds.append(p)                                                                                              
                    p.start()                                                                                              #start the function, wait for threads to finish
                for p in thrds:
                    p.join
                
    run_action(int(ip1),int(ip2),int(ip3),int(ip4),int(ip5),int(ip6),int(ip7))                                             #call of the function to run
        
