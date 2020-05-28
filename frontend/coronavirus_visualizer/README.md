# Corona Timeline

[![](https://img.shields.io/badge/flutter-newest-blue)](https://flutter.dev/)
[![](https://img.shields.io/badge/flutter__bloc-3.2.0-blue)](https://pub.dev/packages/flutter_bloc/versions/3.2.0)
[![](https://img.shields.io/badge/dio-3.0.9-blue)](https://pub.dev/packages/dio/versions/3.0.9)




Mobile application for displaying covid-19 cases accordingly to specific country or globally. It utilizes single backend being present in current git repository.



#### Usage
Applications has been only tested with android via connecting remote device. Using emulator represents implemented functionality correctly but might have graphic glitches related to shadows and gradients.
It's recommended to use Android Studio with necessary plugins related to flutter and run auto generated project from coronavirus_visualizer directory.

If you happen to have CLI setup just run:

`flutter run`

Application uses hard-coded backend uri which can be found [here](https://github.com/Qizot/CoronavirusVisualizer/blob/7be2e47bc80aab14b0fde7423ced31c6b3d98444/frontend/coronavirus_visualizer/lib/main.dart#L11). You might want to change it to server running localy. Application's backend is currently being hosted on a DigitalOcean's VPS. 


### UI structure
Two modes of view are available: global, country specific. Global view takes you right to the global statistics while chosing country specific one takes you to the list of all available countries. Statistics view is the same for global and country mode.

#### Home screen
Single view consisting of two modes: global timeline, countries timeline.

#### Statistics screen
The whole view consits of two 3 diagrams: two line charts representing total cases and daily rates, one pie chart showing proportions of total cases/deaths/recoveries.

Besides that there is one summary panel showing text representation of data below all diagrams.

#### Country picker screen
Single view with two tabs: one for all available countries, one for saved countries. You can either save or delete country from your saved list by swiping right on the country and pressing given icon.

