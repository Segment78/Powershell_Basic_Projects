<# 
  Scripters : K Baguio
              C Logan
              C Sanders
              B Wargo

  Variables
        -$City = City
        -$Country = Country
        -$c = Celcius Switch
        -$UTCTime = Establishes DateTime object for use in converting Posix time to standard
        -$ADays = Days adjusted to account for accessing daily data correctly
        -$LL = Latitude/Longitude
        -$URI = Raw Darksky URL
        -$PLL = Processed Lat/Long object
        -$URElement = Weather request URI
        -$Data = Processed JSON file
        -$Item = variable call to establish correct day during "ForEach" and "If" loops        
#>
#Create Function
function get-Weather {
#Define Function as a Cmdlet
                     [CmdletBinding()]
#Establish mandatory and non-mandatory input parameters (establishing $c as a switch)
                      Param(
                            [Parameter(Mandatory=$true)]
                            [string] $City,
                            [Parameter(Mandatory=$true)]
                            [string] $Country,
                            [Parameter(Mandatory=$true)]
                            [string] $Days,
                            [Parameter(Mandatory=$false)]
                            [Switch] $c                            
                            )
Write-Host "Powered by Dark Sky"
#Establish variable for days adjusted to account for accessing daily data correctly
                      $Adays = (0..($Days-1))     
#Establish Unix base time
                      $UtcTime = Get-Date -Date "1970-01-01 00:00:00Z"
#Establish URI to request location conversion to Lat/Long
                      $LL = "https://api.opencagedata.com/geocode/v1/json?q=$City,+$Country+&key=ae9b3a8b237f430ba2a522cc7487d2cc"
#Assign URL and individual certificate to $URI
                      $URI = "https://api.darksky.net/forecast/d11277a2738722f6b4b730b1304eced5/"
#Obtain LAT/LONG object from website
                      $PLL = Invoke-RestMethod -URI $LL | select -ExpandProperty results | select -ExpandProperty geometry -first 1 
#Create weather request URI from Raw URI/Key and LAT/LONG outputs
                      $URElement = $URI + $PLL."lat" + "," + $PLL."lng"
#Pull Data from Darksky, convert-from .json to usable object and assign to $Data
                      $Data = Invoke-RestMethod -Uri $URElement
#Start loop to translate Posix time and convert Farenheit to Celcius if required    
                      Foreach($item in $ADays){ 
                                              $Data.daily.data[$item].time = $UtcTime.AddSeconds($Data.daily.data[$item].time)
                                              $Data.daily.data[$item].sunriseTime = Get-Date -Date $UtcTime.AddSeconds($Data.daily.data[$item].sunriseTime) -Format "hh:mm tt"
                                              $Data.daily.data[$item].sunsetTime = Get-Date -Date $UtcTime.AddSeconds($Data.daily.data[$item].sunsetTime) -Format "hh:mm tt"
                                              $Data.daily.data[$item].precipIntensityMaxTime = Get-Date -Date $UtcTime.AddSeconds($Data.daily.data[$item].precipIntensityMaxTime) -Format "hh:mm tt"
                                              $Data.daily.data[$item].temperatureHighTime = Get-Date -Date $UtcTime.AddSeconds($Data.daily.data[$item].temperatureHighTime) -Format "hh:mm tt"
                                              $Data.daily.data[$item].temperatureLowTime = Get-Date -Date $UtcTime.AddSeconds($Data.daily.data[$item].temperatureLowTime) -Format "hh:mm tt"
                                              $Data.daily.data[$item].apparentTemperatureHighTime = Get-Date -Date $UtcTime.AddSeconds($Data.daily.data[$item].apparentTemperatureHighTime) -Format "hh:mm tt"
                                              $Data.daily.data[$item].apparentTemperatureLowTime = Get-Date -Date $UtcTime.AddSeconds($Data.daily.data[$item].apparentTemperatureLowTime) -Format "hh:mm tt"
                                              $Data.daily.data[$item].windGustTime = Get-Date -Date $UtcTime.AddSeconds($Data.daily.data[$item].windGustTime) -Format "hh:mm tt"
                                              $Data.daily.data[$item].uvIndexTime = Get-Date -Date $UtcTime.AddSeconds($Data.daily.data[$item].uvIndexTime) -Format "hh:mm tt"
                                              $Data.daily.data[$item].temperatureMinTime  = Get-Date -Date $UtcTime.AddSeconds($Data.daily.data[$item].temperatureMinTime) -Format "hh:mm tt"
                                              $Data.daily.data[$item].temperatureMaxTime = Get-Date -Date $UtcTime.AddSeconds($Data.daily.data[$item].temperatureMaxTime) -Format "hh:mm tt"
                                              $Data.daily.data[$item].apparentTemperatureMinTime = Get-Date -Date $UtcTime.AddSeconds($Data.daily.data[$item].apparentTemperatureMinTime) -Format "hh:mm tt"
                                              $Data.daily.data[$item].apparentTemperatureMaxTime = Get-Date -Date $UtcTime.AddSeconds($Data.daily.data[$item].apparentTemperatureMaxTime) -Format "hh:mm tt"
#Celcius Translation
                                              if($c.IsPresent){
                                                              $Data.daily.data[$item].temperatureHigh = ([math]::Round((($Data.daily.data[$item].temperatureHigh -32)/1.8),2))
                                                              $Data.daily.data[$item].temperaturelow = [math]::Round((($Data.daily.data[$item].temperaturelow -32)/1.8),2)
                                                              $Data.daily.data[$item].apparentTemperatureHigh = [math]::Round((($Data.daily.data[$item].apparentTemperatureHigh -32)/1.8),2)
                                                              $Data.daily.data[$item].apparentTemperatureLow = [math]::Round((($Data.daily.data[$item].apparentTemperatureLow -32)/1.8),2)
                                                              $Data.daily.data[$item].temperatureMin = [math]::Round((($Data.daily.data[$item].temperatureMin -32)/1.8),2)
                                                              $Data.daily.data[$item].temperatureMax = [math]::Round((($Data.daily.data[$item].temperatureMax -32)/1.8),2)
                                                              $Data.daily.data[$item].apparentTemperatureMin = [math]::Round((($Data.daily.data[$item].apparentTemperatureMin -32)/1.8),2)
                                                              $Data.daily.data[$item].apparentTemperatureMax = [math]::Round((($Data.daily.data[$item].apparentTemperatureMax -32)/1.8),2)
                                                              }
                                              }
#Establish output properties
                        Return $data.daily.data[$Adays] | Select-Object time,temperaturehigh, temperaturehightime, temperaturelow,temperaturelowtime, precipprobability, preciptype
}