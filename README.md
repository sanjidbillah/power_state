
Power State is a lightweight and flexible state management library for Flutter apps. It provides a simple and easy-to-use API that helps you manage the state of your app in a clean and efficient way. With Power State, you can easily manage your app's state and update your UI in real-time.

# Usage

## Step:1 Create a PowerController
Create a controller class that extends PowerController. This controller class will hold your application's state and provide methods to manipulate it.

Here's an example CounterController class:
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

## Step:2 Store controller

Instantiate your controller class using PowerVault.put() method:

```
final CounterController controller = PowerVault.put(CounterController());
```

## Step:3 Use PowerBuilder and PowerSelector to access your state
Use PowerBuilder to listen for changes to your state and rebuild your UI. Use PowerSelector to select a specific value from your state and rebuild only when that value changes.:

```
PowerBuilder<CounterController>(
  builder: (countController) {
    return Text(countController.count.toString());
  },
),

PowerSelector<CounterController>(
  selector: () => controller.selectorValue,
  builder: (countController) {
    return Text(countController.selectorValue.toString());
  },
),

```   
## Step:4 Update your state
Update your state by calling methods on your controller and calling notifyListeners() to rebuild your UI.

```
controller.increment();
controller.update();
```

You can find a Controller that is being used by another page and redirect you to it.

```
final CounterController countController = PowerVault.find();
```  

## Deleting a controller

If you no longer need a controller, you can delete it from PowerVault using the PowerVault.delete<T>() method. Here's an example of deleting the CounterController:

```
PowerVault.delete<CounterController>();
```  

Check out the example app to see Power State in action.




