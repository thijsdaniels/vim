import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/settings_model.dart';

class Icons8Icon extends StatelessWidget {
  final String slug;
  final Icons8Style? style;
  final double size;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  const Icons8Icon(
    this.slug, {
    super.key,
    this.style,
    this.size = 44,
    this.errorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    if (style != null) {
      return _resolver(style!)();
    } else {
      return Consumer<SettingsModel>(
        builder: (context, settingsModel, _) {
          return _resolver(settingsModel.iconStyle)();
        },
      );
    }
  }

  Image Function() _resolver(Icons8Style style) {
    switch (style) {
      case Icons8Style.arcade:
      case Icons8Style.stickers:
        return () => _asset(style);
      default:
        return () => _network(style);
    }
  }

  Image _asset(Icons8Style style) {
    return Image(
      image: AssetImage(_path(slug, style)),
      width: size,
      height: size,
      errorBuilder: errorBuilder ??
          (context, exception, trace) => SizedBox(
                width: size,
                height: size,
              ),
    );
  }

  Image _network(Icons8Style style) {
    return Image.network(
      _url(slug, style),
      width: size,
      height: size,
      errorBuilder: errorBuilder ??
          (context, exception, trace) => SizedBox(
                width: size,
                height: size,
              ),
    );
  }

  String _path(String slug, Icons8Style style) {
    switch (style) {
      case Icons8Style.arcade:
        return 'assets/images/icons8/arcade/icons8-$slug-100.png';
      case Icons8Style.color:
        return 'assets/images/icons8/color/icons8-$slug-100.png';
      case Icons8Style.colorGlass:
        return 'assets/images/icons8/color-glass/icons8-$slug-100.png';
      case Icons8Style.dusk:
        return 'assets/images/icons8/dusk/icons8-$slug-100.png';
      case Icons8Style.fluency:
        return 'assets/images/icons8/fluency/icons8-$slug-100.png';
      case Icons8Style.pulsarColor:
        return 'assets/images/icons8/pulsar-color/icons8-$slug-100.png';
      case Icons8Style.stickers:
        return 'assets/images/icons8/stickers/icons8-$slug-100.png';
    }
  }

  String _url(String slug, Icons8Style style) {
    switch (style) {
      case Icons8Style.arcade:
        return 'https://img.icons8.com/arcade/100/null/$slug.png';
      case Icons8Style.color:
        return 'https://img.icons8.com/color/100/null/$slug.png';
      case Icons8Style.colorGlass:
        return 'https://img.icons8.com/color-glass/100/null/$slug.png';
      case Icons8Style.dusk:
        return 'https://img.icons8.com/dusk/100/null/$slug.png';
      case Icons8Style.fluency:
        return 'https://img.icons8.com/fluency/100/null/$slug.png';
      case Icons8Style.pulsarColor:
        return 'https://img.icons8.com/pulsar-color/100/null/$slug.png';
      case Icons8Style.stickers:
        return 'https://img.icons8.com/stickers/100/null/$slug.png';
    }
  }
}

enum Icons8Style {
  arcade,
  color,
  colorGlass,
  dusk, // AKA "Cute Color"
  fluency, // AKA "Windows 11 Color"
  pulsarColor,
  stickers,
}

// TODO: Turn into Enum.
const icons8Slugs = [
  'alcohol',
  'almond',
  'apple-jam',
  'apple',
  'apricot',
  'artichoke',
  'asian-street-food',
  'asparagus',
  'avocado',
  'bacon',
  'bagel',
  'baguette',
  'banana-split',
  'banana',
  'barbecue',
  'barley',
  'basil',
  'beef',
  'beer-bottle',
  'beer-can',
  'beer-glass',
  'beer-keg',
  'beer-mug',
  'beer',
  'beet',
  'bento',
  'berry-jam',
  'birthday-cake',
  'biscuits',
  'bitten-ice-pop',
  'blueberry',
  'bottle-of-water',
  'brazil-nut',
  'bread-loaf',
  'bread',
  'brezel',
  'brigadeiro',
  'broccoli',
  'bubble-tea',
  'butter',
  'cabbage',
  'cactus',
  'cake',
  'candy',
  'carrot',
  'cashew',
  'cauliflower',
  'celery',
  'cereal',
  'champagne-bottle',
  'champagne',
  'cheese',
  'cheeseburger',
  'cherry',
  'chili-pepper',
  'chinese-fried-rice',
  'chinese-noodle',
  'chocolate-bar',
  'chupa-chups',
  'cinnamon-roll',
  'cinnamon-sticks',
  'citrus',
  'cocktail-shot',
  'cocktail',
  'coconut-cocktail',
  'coconut-milk',
  'coconut',
  'coffee-beans',
  'coffee-capsule',
  'coffee-cup',
  'coffee-pot',
  'coffee-to-go',
  'coffee',
  'cola',
  'cookie',
  'cookies',
  'corn',
  'cotton-candy',
  'crab',
  'croissant',
  'cucumber',
  'cup-with-straw',
  'cupcake',
  'cutted-melon',
  'cutted-watermelon',
  'dessert',
  'dim-sum',
  'dolmades',
  'doughnut',
  'dragon-fruit',
  'dressed-fish',
  'durian',
  'egg-basket',
  'eggplant',
  'eggs',
  'energy-drink',
  'fish-fillet',
  'fish-food',
  'flax-seeds',
  'flour-of-rye',
  'flour',
  'fondue',
  'food-and-wine',
  'french-fries',
  'french-press',
  'fried-chicken',
  'fruit-bag',
  'fry',
  'garlic',
  'ginger',
  'gingerbread-house',
  'glass-of-whiskey',
  'goji',
  'grains-of-rice',
  'grapes',
  'greek-salad',
  'green-tea',
  'grocery-bag',
  'grocery-shelf',
  'group-of-fruits',
  'group-of-vegetables',
  'guacamole',
  'guinness-beer',
  'half-orange',
  'hamburger',
  'hamper',
  'hazelnut',
  'honey',
  'hot-chocolate-with-marshmallows',
  'hot-chocolate',
  'hot-dog',
  'ice-cream-cone',
  'ice-cream-sundae',
  'ingredients-for-cooking',
  'ingredients',
  'jam',
  'jamon',
  'jelly',
  'kebab',
  'ketchup',
  'kiwi',
  'kohlrabi',
  'korean-rice-cake',
  'leek',
  'lemonade',
  'lentil',
  'lettuce',
  'lime',
  'liquor-shelf',
  'macaron',
  'mango',
  'mate',
  'mayonnaise',
  'meat',
  'melon',
  'melting-ice-cream',
  'merry-pie',
  'milk-bottle',
  'milk-carton',
  'milk',
  'milkshake',
  'mint',
  'moka-pot',
  'moonshine-jug',
  'mulled-wine',
  'mushroom',
  'mushrooms',
  'mustard',
  'naan',
  'nachos',
  'nonya-kueh',
  'noodles',
  'nut',
  'nutshell',
  'oat-milk',
  'octopus',
  'olive-oil',
  'olive',
  'omlette',
  'onion',
  'orange-juice',
  'orange-soda',
  'orange',
  'paella',
  'pancake-stack',
  'papaya',
  'paprika',
  'parsley',
  'pastel-de-nata',
  'peach',
  'peanuts',
  'pear',
  'peas',
  'pelmen',
  'pie',
  'pineapple',
  'pint',
  'pizza-five-eighths',
  'pizza',
  'plastic-bottle',
  'plastic-food-container',
  'plum',
  'pomegranate',
  'popcorn',
  'porridge',
  'potato-chips',
  'potato',
  'poultry-leg',
  'prawn',
  'pretzel',
  'pumpkin',
  'quesadilla',
  'rack-of-lamb',
  'radish',
  'raspberry',
  'real-food-for-meals',
  'refreshments',
  'rice-bowl',
  'rolled-oats',
  'salad',
  'salami-pizza',
  'salami',
  'salmon-sushi',
  'salt-shaker',
  'salt',
  'samosa',
  'sandwich-with-fried-egg',
  'sandwich',
  'sauce',
  'sausage',
  'sausages',
  'seafood',
  'sesame',
  'shellfish',
  'shrimp-and-lobster',
  'slice-of-watermelon',
  'soda-bottle',
  'soda-can',
  'soda-water',
  'soda',
  'soup-plate',
  'soursop',
  'soy-sauce',
  'soy',
  'spaghetti',
  'spam-can',
  'sparkling-water',
  'spice',
  'spinach',
  'spoon-of-sugar',
  'sport-bottle',
  'squash',
  'steak',
  'strawberry',
  'street-food',
  'sugar-cube',
  'sugar-cubes',
  'sugar',
  'sugarcane',
  'sunny-side-up-eggs',
  'sushi',
  'sweet-potato',
  'sweetener',
  'taco',
  'take-away-food',
  'takeaway-hot-drink',
  'tangelo',
  'tapas',
  'tea',
  'thanksgiving',
  'the-toast',
  'thyme',
  'tin-can',
  'toast',
  'tomato',
  'topping',
  'vegetables-bag',
  'vodka-shot',
  'vodka',
  'watermelon',
  'wheat',
  'whipped-cream',
  'whiskey',
  'white-beans',
  'white-wine',
  'whole-fish',
  'whole-melon',
  'wine-and-grapes',
  'wine-bar',
  'wine-bottle',
  'wine-glass',
  'wine',
  'wooden-beer-keg',
  'worcestershire-sauce',
  'wrap',
  'yogurt',
  'zucchini',
];
