
A Flutter Statement solution with [dependency injection]

## Usage

Create your business logic class and place all variables, methods inside it.
```
import 'package:power_state/power_state.dart';

class CounterController extends PowerController {
  int count = 1;

  increment() {
    count++;
    notifyListeners();
  }
}
```

Instantiate your class using PowerVault.put(CounterController()) 

```
final CounterController controller = PowerVault.put(CounterController());
```

Then you can use powerBuilder widget in your UI side

```
 PowerBuilder<CounterController>(
              builder: (countController) {
                return Text(countController.count.toString());
              },
            ),
```   

// You can find a Controller that is being used by another page and redirect you to it.

```
final CounterController countController = PowerVault.find();
```  

// You can delete a Controller.

```
PowerVault.delete<CounterController>();
```  

# PowerSelector Widget
PowerSelector allows you to select a specific value listen to. Then when and only when that selected value changes, the widget that returns by the builder method of Selector will rebuild.

```
PowerSelector<CounterController>(
              <!-- It will listen selectorValue -->
              selector: () => controller.selectorValue,
              builder: (countController) {
                return Text(countController.selectorValue.toString());
              },
 ),
``` 






[dependency injection]: https://en.wikipedia.org/wiki/Dependency_injection