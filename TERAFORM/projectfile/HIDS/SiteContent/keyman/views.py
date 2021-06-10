from django.shortcuts import render
from django.http import HttpResponse
from .models import KeyMap
from datetime import datetime, timedelta
import hashlib
from paramiko import client, AutoAddPolicy
from django.views.decorators.csrf import csrf_exempt
from time import sleep

def exe_comm(command):
  sClient = client.SSHClient()
  sClient.set_missing_host_key_policy(AutoAddPolicy())
  sClient.load_system_host_keys()
  # USM
  # sClient.connect('172.31.39.21', username='root', password='JG2mv438UeaeK8KU')
  # sensor
  sClient.connect('172.31.39.200', username='root', password='R394nzm39UQejVGH')
  stdin, stdout, stderr = sClient.exec_command(command)
  return stdout

@csrf_exempt
def index(request, hash):
    #check hash value
    ip = request.POST.get('ip', '')
    hostname = request.POST.get('hostname', '')
    reg = request.POST.get('region', '')
    #return HttpResponse(ip+" "+hostname+" "+reg)
    msgTime = datetime.now()
    Keynonce = msgTime.strftime('%y%m%d%H%M') + "iesf"
    Keynonce2 = (msgTime - timedelta(minutes=1)).strftime('%y%m%d%H%M') + "iesf"
    Keynonce3 = (msgTime - timedelta(minutes=2)).strftime('%y%m%d%H%M') + "iesf"
    Keynonce4 = (msgTime - timedelta(minutes=3)).strftime('%y%m%d%H%M') + "iesf"
    Keynonce5 = (msgTime - timedelta(minutes=4)).strftime('%y%m%d%H%M') + "iesf"
    Harray = [ hashlib.sha512(Keynonce.encode('utf-8')).hexdigest()[0:40], 
            hashlib.sha512(Keynonce2.encode('utf-8')).hexdigest()[0:40],
            hashlib.sha512(Keynonce3.encode('utf-8')).hexdigest()[0:40],
            hashlib.sha512(Keynonce4.encode('utf-8')).hexdigest()[0:40],
            hashlib.sha512(Keynonce5.encode('utf-8')).hexdigest()[0:40], ]
    if hash in Harray:
        if KeyMap.objects.filter(hostname=hostname, Region=reg).exists():
            #if find key in local DB
            returnKey = KeyMap.objects.get(hostname=hostname, Region=reg).key
        else:
            #request new key if not in DB and save it into local DB
            exe_comm("cd /tmp; echo "+ip+","+hostname+" > "+hostname+".tmp; /var/ossec/bin/manage_agents -f"+hostname+".tmp;")
            #await manage_agents complete append host to client.key and extract key
            sleep(1)
            newKey = exe_comm("/var/ossec/bin/manage_agents -e `/var/ossec/bin/manage_agents -l | grep -oP '(?<=ID:\ )[0-9]+(?=\,\ Name:\ "+hostname+")'`")
            # force ossec manager reload key list to accept new host
            exe_comm("sudo /var/ossec/bin/ossec-control restart")
            returnKey = newKey.readlines()[2][:-1]
            # store new host info in database
            newHost = KeyMap(hostname=hostname, Region=reg, key=returnKey)
            newHost.save()
        return HttpResponse(returnKey)
    return HttpResponse("ERROR")

def connectTest(request):
    return HttpResponse("Connection Success")
