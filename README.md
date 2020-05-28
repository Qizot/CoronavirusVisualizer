# CoronavirusVisualizer :skull:

*Project for 'Database systems' laboratory in AGH University of Science and Technology.*

## Team  :punch:
 * [Jakub Perżyło](https://github.com/Qizot)
 * [Sebastian Kuśnierz](https://github.com/skusnierz)
 
## About project :question:
The main goal was to get take on new database which in our case happened to be MongoDB. 
Our personal goal was rather to create Android application which would enable looking up information about 
Corona virus's timeline cases around the world by taking advantage of our backend system.

We decided to obtain virus's data from two public APIs which then we parse into unified format and save in our database.

***APIs we use are:***
 - [The virus tracker](https://thevirustracker.com/api) which is a simple 
 REST api with daily updates of new cases/deaths/recoveries, unfortunately it is quite often down 
 which caused lot of problems recently
 
 - [Covid19 graphql](https://covid19-graphql.now.sh) a public Graphql api which gathers it's data from one public 
 github repostitory that is being updated on daily basis, it turned out to be more reliable but this time 
 we can only depend on data 
 from previous day so it's far from real time
Due to small differences we decided to save data up to previous day so as both API could be used exchangeably (graphql's delay)

*We've exposed python's Flask server to work as a proxy between our APIs 
so that it can be extended with other providers more easily.*

## Technology stack :computer: 
 - Node.js with mongoose library to serve as our API server, you can find more information about backend at the following [link](https://github.com/Qizot/CoronavirusVisualizer/tree/master/backend),
 - Python Flask server exposed as proxy between data providers,
 - Flutter framework for frontend application development, you can find more information about frontend at the following [link](https://github.com/Qizot/CoronavirusVisualizer/tree/master/frontend/coronavirus_visualizer).
 


## Frontend demo :iphone:
**You can download an app [here](https://github.com/Qizot/CoronavirusVisualizer/releases/tag/v1.1) (not available on google play yet).**

<img src="https://github.com/Qizot/CoronavirusVisualizer/blob/master/virus_app.gif" height="500" width="250">
