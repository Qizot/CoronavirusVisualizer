# CoronavirusVisualizer

*Project for 'Database systems' laboratory in AGH University of Science and Technology.*

#### Team
 * [Jakub Perżyło](https://github.com/Qizot)
 * [Sebastian Kuśnierz](https://github.com/skusnierz)
 
### About project
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

### Technology stack
 - Node.js with mongoose library to serve as our API server
 - Python Flask server exposed as proxy between data providers
 - Flutter framework for frontend application development
 
### Database
As previously mentioned, we use MongoDB document database. It was an easy choice as we operate mainly on json structures
which saves us headaches from parsing data back to jason format and above that mongoose library is straightforward 
to use and we value simplicity a lot.

Why use database as we can depend on our proxy server you might ask? Well, parsing all countries data takes much longer than
an average app user might want to spend on waiting. Moreover, we value our providers and we don't want to take more of their bandwitdh
than we actually need. Instead we just keep refreshing our database every hour in case new data might come in.

#### Architecture
In MongoDB we keep a single collection which keeps records in [given format](https://github.com/Qizot/CoronavirusVisualizer/blob/master/backend/coronavirus-visualizer-api/src/models/timeline.ts).
Our backend exposes 3 different endpoints, you can learn about all of them by inspecting our codebase.
On every request we perform particular query on database, mainly consisting of aggregate pipeline and return obtained data
back to the user.

## Frontend demo
**You can download an app [here](https://github.com/Qizot/CoronavirusVisualizer/releases/tag/v1.1) (not available on google play yet).**

<img src="https://github.com/Qizot/CoronavirusVisualizer/blob/master/virus_app.gif" height="500" width="250">
