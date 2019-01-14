dofile('/software/dicomserver/Conquest-Dicom-Server/lua/test_utilities.lua')

print('To detect memory leaks, compare output on subsequent runs')
collectgarbage("collect"); print(heapinfo())

local study = MakeStudy(30, 'teststudy')

print('testing built-in SQLite')
RunTestServer('UN', 'SqLite')
local t=tickcount() dicomstore('testserver', study) print('store time: '..tickcount()-t)
CountImagesInPatient('teststudy', 30*30, 'testserver')
os.execute('dgate64.exe -wtestserver --lua:servercommand([[deleteseries:'..study[1].SeriesInstanceUID..']])')
CountImagesInPatient('teststudy', 29*30, 'testserver')

print('testing built-in DBaseIII')
RunTestServer('UN', 'DBase')
local t=tickcount() dicomstore('testserver', study) print('store time: '..tickcount()-t)
CountImagesInPatient('teststudy', 30*30, 'testserver')
os.execute('dgate64.exe -wtestserver --lua:servercommand([[deleteseries:'..study[1].SeriesInstanceUID..']])')
CountImagesInPatient('teststudy', 29*30, 'testserver')

print('testing ODBC - Assumes datasource test exists')
RunTestServer('UN', 'ODBC')
local t=tickcount() dicomstore('testserver', study) print('store time: '..tickcount()-t)
CountImagesInPatient('teststudy', 30*30, 'testserver')
os.execute('dgate64.exe -wtestserver --lua:servercommand([[deleteseries:'..study[1].SeriesInstanceUID..']])')
CountImagesInPatient('teststudy', 29*30, 'testserver')

print('testing MySQL, assumes database test exists, and user root has no password')
RunTestServer('UN', 'MySQL')
local t=tickcount() dicomstore('testserver', study) print('store time: '..tickcount()-t)
CountImagesInPatient('teststudy', 30*30, 'testserver')
os.execute('dgate64.exe -wtestserver --lua:servercommand([[deleteseries:'..study[1].SeriesInstanceUID..']])')
CountImagesInPatient('teststudy', 29*30, 'testserver')

print('testing PostGres, assumes database test exists, and user postgres has password postgres')
RunTestServer('UN', 'PostGres')
local t=tickcount() dicomstore('testserver', study) print('store time: '..tickcount()-t)
CountImagesInPatient('teststudy', 30*30, 'testserver')
os.execute('dgate64.exe -wtestserver --lua:servercommand([[deleteseries:'..study[1].SeriesInstanceUID..']])')
CountImagesInPatient('teststudy', 29*30, 'testserver')

print('testing NULL database')
RunTestServer('UN', '')
local t=tickcount() dicomstore('testserver', study) print('store time: '..tickcount()-t)
CountImagesInPatient('teststudy', 0, 'testserver')
os.execute('dgate64.exe -wtestserver --lua:servercommand([[deleteseries:'..study[1].SeriesInstanceUID..']])')
CountImagesInPatient('teststudy', 0, 'testserver')

QuitTestServer()