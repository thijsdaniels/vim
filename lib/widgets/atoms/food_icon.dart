import 'package:flutter/material.dart';

class FoodIcon extends StatelessWidget {
  final String slug;
  final double size;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  const FoodIcon(
    this.slug, {
    super.key,
    this.size = 44,
    this.errorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage('assets/images/food/icons8-$slug-100.png'),
      width: size,
      height: size,
      errorBuilder: errorBuilder ??
          (context, exception, trace) => SizedBox(
                width: size,
                height: size,
              ),
    );
  }
}

class FoodIconData {
  final String name;
  final String slug;
  final List<String>? keywords;

  const FoodIconData({
    required this.name,
    required this.slug,
    this.keywords,
  });
}

const foodIcons = {
  "almond-butter": FoodIconData(
    name: "Almond Butter",
    slug: "almond-butter",
  ),
  "apple-fruit": FoodIconData(
    name: "Apple",
    slug: "apple-fruit",
  ),
  "apple-jam": FoodIconData(
    name: "Apple Jam",
    slug: "apple-jam",
  ),
  "apricot": FoodIconData(
    name: "Apricot",
    slug: "apricot",
  ),
  "artichoke": FoodIconData(
    name: "Artichoke",
    slug: "artichoke",
  ),
  "asparagus": FoodIconData(
    name: "Asparagus",
    slug: "asparagus",
  ),
  "avocado": FoodIconData(
    name: "Avocado",
    slug: "avocado",
  ),
  "bacon": FoodIconData(
    name: "Bacon",
    slug: "bacon",
  ),
  "bagel": FoodIconData(
    name: "Bagel",
    slug: "bagel",
  ),
  "baguette": FoodIconData(
    name: "Baguette",
    slug: "baguette",
  ),
  "banana": FoodIconData(
    name: "Banana",
    slug: "banana",
  ),
  "banana-split": FoodIconData(
    name: "Banana Split",
    slug: "banana-split",
  ),
  "bao-bun": FoodIconData(
    name: "Bao Bun",
    slug: "bao-bun",
  ),
  "barbecue": FoodIconData(
    name: "Barbecue",
    slug: "barbecue",
  ),
  "barley": FoodIconData(
    name: "Barley",
    slug: "barley",
  ),
  "basil": FoodIconData(
    name: "Basil",
    slug: "basil",
  ),
  "beef": FoodIconData(
    name: "Grilled Steak",
    slug: "beef",
  ),
  "beer": FoodIconData(
    name: "Mug of Beer",
    slug: "beer",
  ),
  "beer-bottle": FoodIconData(
    name: "Bottle of Beer",
    slug: "beer-bottle",
  ),
  "beer-can": FoodIconData(
    name: "Can of Beer",
    slug: "beer-can",
  ),
  "beer-glass": FoodIconData(
    name: "Glass of Ale",
    slug: "beer-glass",
    keywords: ["beer"],
  ),
  "beer-keg": FoodIconData(
    name: "Keg of Beer",
    slug: "beer-keg",
  ),
  "beet": FoodIconData(
    name: "Beet",
    slug: "beet",
  ),
  "bento": FoodIconData(
    name: "Bento",
    slug: "bento",
  ),
  "berry-jam": FoodIconData(
    name: "Berry Jam",
    slug: "berry-jam",
  ),
  "birthday-cake": FoodIconData(
    name: "Birthday Cake",
    slug: "birthday-cake",
  ),
  "biscuits": FoodIconData(
    name: "Biscuits",
    slug: "biscuits",
  ),
  "black-pepper": FoodIconData(
    name: "Black Pepper",
    slug: "black-pepper",
  ),
  "black-sesame-seeds": FoodIconData(
    name: "Black Sesame Seeds",
    slug: "black-sesame-seeds",
  ),
  "blueberry": FoodIconData(
    name: "Blueberry",
    slug: "blueberry",
  ),
  "bok-choy": FoodIconData(
    name: "Bok Choy",
    slug: "bok-choy",
  ),
  "bottle-of-water": FoodIconData(
    name: "Bottle of Water",
    slug: "bottle-of-water",
  ),
  "box-of-cereal": FoodIconData(
    name: "Box of Cereal",
    slug: "box-of-cereal",
  ),
  "brazil-nut": FoodIconData(
    name: "Brazil Nut",
    slug: "brazil-nut",
  ),
  "bread": FoodIconData(
    name: "Bread",
    slug: "bread",
  ),
  "bread-crumbs": FoodIconData(
    name: "Breadcrumbs",
    slug: "bread-crumbs",
  ),
  "brigadeiro": FoodIconData(
    name: "Brigadeiro",
    slug: "brigadeiro",
  ),
  "broccoli": FoodIconData(
    name: "Broccoli",
    slug: "broccoli",
  ),
  "broccolini": FoodIconData(
    name: "Broccolini",
    slug: "broccolini",
  ),
  "burrito": FoodIconData(
    name: "Burrito",
    slug: "burrito",
  ),
  "butter": FoodIconData(
    name: "Butter",
    slug: "butter",
  ),
  "cabbage": FoodIconData(
    name: "Cabbage",
    slug: "cabbage",
  ),
  "cactus": FoodIconData(
    name: "Cactus",
    slug: "cactus",
  ),
  "cake": FoodIconData(
    name: "Cake",
    slug: "cake",
  ),
  "candy": FoodIconData(
    name: "Candy",
    slug: "candy",
  ),
  "carrot": FoodIconData(
    name: "Carrot",
    slug: "carrot",
  ),
  "cashew": FoodIconData(
    name: "Cashew",
    slug: "cashew",
  ),
  "cauliflower": FoodIconData(
    name: "Cauliflower",
    slug: "cauliflower",
  ),
  "caviar": FoodIconData(
    name: "Caviar",
    slug: "caviar",
  ),
  "celery": FoodIconData(
    name: "Celery",
    slug: "celery",
  ),
  "cereal": FoodIconData(
    name: "Cereal",
    slug: "cereal",
  ),
  "champagne": FoodIconData(
    name: "Glass of Champagne",
    slug: "champagne",
  ),
  "champagne-bottle": FoodIconData(
    name: "Bottle of Champagne",
    slug: "champagne-bottle",
  ),
  "chard": FoodIconData(
    name: "Chard",
    slug: "chard",
  ),
  "cheese": FoodIconData(
    name: "Cheese",
    slug: "cheese",
  ),
  "cheeseburger": FoodIconData(
    name: "Cheeseburger",
    slug: "cheeseburger",
  ),
  "cheesecake": FoodIconData(
    name: "Cheesecake",
    slug: "cheesecake",
  ),
  "cherry": FoodIconData(
    name: "Cherry",
    slug: "cherry",
  ),
  "cherry-cheesecake": FoodIconData(
    name: "Cherry Cheesecake",
    slug: "cherry-cheesecake",
  ),
  "chia-seeds": FoodIconData(
    name: "Chia Seeds",
    slug: "chia-seeds",
  ),
  "chicken-and-waffle": FoodIconData(
    name: "Chicken and Waffles",
    slug: "chicken-and-waffle",
  ),
  "chili-pepper": FoodIconData(
    name: "Chili Pepper",
    slug: "chili-pepper",
  ),
  "chinese-fried-rice": FoodIconData(
    name: "Wok Rice",
    slug: "chinese-fried-rice",
  ),
  "chinese-noodle": FoodIconData(
    name: "Wok Noodles",
    slug: "chinese-noodle",
  ),
  "chocolate-bar": FoodIconData(
    name: "Bar of Chocolate",
    slug: "chocolate-bar",
  ),
  "chocolate-bar-white": FoodIconData(
    name: "Bar of White Chocolate",
    slug: "chocolate-bar-white",
  ),
  "chocolate-spread": FoodIconData(
    name: "Chocolate Spread",
    slug: "chocolate-spread",
  ),
  "chupa-chups": FoodIconData(
    name: "Lollipop",
    slug: "chupa-chups",
  ),
  "cinnamon-roll": FoodIconData(
    name: "Cinnamon Bun",
    slug: "cinnamon-roll",
  ),
  "cinnamon-sticks": FoodIconData(
    name: "Cinnamon Sticks",
    slug: "cinnamon-sticks",
  ),
  "citrus": FoodIconData(
    name: "Citrus",
    slug: "citrus",
  ),
  "cloves": FoodIconData(
    name: "Cloves",
    slug: "cloves",
  ),
  "cocktail": FoodIconData(
    name: "Cocktail",
    slug: "cocktail",
  ),
  "cocktail-shot": FoodIconData(
    name: "Cocktail Shot",
    slug: "cocktail-shot",
  ),
  "coconut": FoodIconData(
    name: "Coconut",
    slug: "coconut",
  ),
  "coconut-cocktail": FoodIconData(
    name: "Coconut Cocktail",
    slug: "coconut-cocktail",
  ),
  "coconut-milk": FoodIconData(
    name: "Coconut Milk",
    slug: "coconut-milk",
  ),
  "coffee": FoodIconData(
    name: "Cup of Coffee",
    slug: "coffee",
  ),
  "coffee-beans": FoodIconData(
    name: "Coffee Beans",
    slug: "coffee-beans",
  ),
  "coffee-capsule": FoodIconData(
    name: "Coffee Capsule",
    slug: "coffee-capsule",
  ),
  "coffee-pot": FoodIconData(
    name: "Pot of Coffee",
    slug: "coffee-pot",
  ),
  "coffee-to-go": FoodIconData(
    name: "Coffee To Go",
    slug: "coffee-to-go",
  ),
  "cola": FoodIconData(
    name: "Cola",
    slug: "cola",
  ),
  "collard-greens": FoodIconData(
    name: "Collard",
    slug: "collard-greens",
  ),
  "cookie": FoodIconData(
    name: "Cookie",
    slug: "cookie",
  ),
  "cookies": FoodIconData(
    name: "Cookies",
    slug: "cookies",
  ),
  "corn": FoodIconData(
    name: "Corn",
    slug: "corn",
  ),
  "cotton-candy": FoodIconData(
    name: "Cotton Candy",
    slug: "cotton-candy",
  ),
  "crab": FoodIconData(
    name: "Crab",
    slug: "crab",
  ),
  "cracker": FoodIconData(
    name: "Cracker",
    slug: "cracker",
  ),
  "croissant": FoodIconData(
    name: "Croissant",
    slug: "croissant",
    keywords: ["crescent roll"],
  ),
  "cucumber": FoodIconData(
    name: "Cucumber",
    slug: "cucumber",
  ),
  "cup-with-straw": FoodIconData(
    name: "Glass with Straw",
    slug: "cup-with-straw",
  ),
  "cupcake": FoodIconData(
    name: "Cupcake",
    slug: "cupcake",
  ),
  "curry": FoodIconData(
    name: "Curry",
    slug: "curry",
  ),
  "cutted-melon": FoodIconData(
    name: "Sliced Melon",
    slug: "cutted-melon",
  ),
  "cutted-watermelon": FoodIconData(
    name: "Sliced Watermelon",
    slug: "cutted-watermelon",
  ),
  "date-fruit": FoodIconData(
    name: "Date",
    slug: "date-fruit",
  ),
  "dessert": FoodIconData(
    name: "Dessert",
    slug: "dessert",
  ),
  "dim-sum": FoodIconData(
    name: "Dim Sum",
    slug: "dim-sum",
  ),
  "dolmades": FoodIconData(
    name: "Dolmades",
    slug: "dolmades",
  ),
  "doughnut": FoodIconData(
    name: "Donut",
    slug: "doughnut",
  ),
  "dragon-fruit": FoodIconData(
    name: "Dragon Fruit",
    slug: "dragon-fruit",
  ),
  "dressed-fish": FoodIconData(
    name: "Dressed Fish",
    slug: "dressed-fish",
  ),
  "durian": FoodIconData(
    name: "Durian",
    slug: "durian",
  ),
  "egg-carton": FoodIconData(
    name: "Carton of Eggs",
    slug: "egg-carton",
  ),
  "eggplant": FoodIconData(
    name: "Eggplant",
    slug: "eggplant",
    keywords: ["aubergine"],
  ),
  "eggs": FoodIconData(
    name: "Eggs",
    slug: "eggs",
  ),
  "energy-drink": FoodIconData(
    name: "Energy Drink",
    slug: "energy-drink",
  ),
  "fig-fruit": FoodIconData(
    name: "Fig",
    slug: "fig-fruit",
  ),
  "finocchio": FoodIconData(
    name: "Fennel",
    slug: "finocchio",
  ),
  "firm-tofu": FoodIconData(
    name: "Firm Tofu",
    slug: "firm-tofu",
  ),
  "fish-fillet": FoodIconData(
    name: "Fillet of Fish",
    slug: "fish-fillet",
  ),
  "fish-food": FoodIconData(
    name: "Small Fish",
    slug: "fish-food",
  ),
  "flax-seeds": FoodIconData(
    name: "Flax Seeds",
    slug: "flax-seeds",
  ),
  "flour": FoodIconData(
    name: "Flour",
    slug: "flour",
  ),
  "flour-of-rye": FoodIconData(
    name: "Rye Flour",
    slug: "flour-of-rye",
  ),
  "fondue": FoodIconData(
    name: "Fondue",
    slug: "fondue",
  ),
  "french-fries": FoodIconData(
    name: "French Fries",
    slug: "french-fries",
  ),
  "french-press": FoodIconData(
    name: "French Press",
    slug: "french-press",
    keywords: ["coffee"],
  ),
  "fried-chicken": FoodIconData(
    name: "Fried Chicken",
    slug: "fried-chicken",
  ),
  "fruit-bag": FoodIconData(
    name: "Bag of Fruit",
    slug: "fruit-bag",
  ),
  "gailan": FoodIconData(
    name: "Gai Lan",
    slug: "gailan",
  ),
  "garlic": FoodIconData(
    name: "Garlic",
    slug: "garlic",
  ),
  "ginger": FoodIconData(
    name: "Ginger",
    slug: "ginger",
  ),
  "gingerbread-house": FoodIconData(
    name: "Gingerbread House",
    slug: "gingerbread-house",
  ),
  "glass-of-whiskey": FoodIconData(
    name: "Glass of Whiskey",
    slug: "glass-of-whiskey",
  ),
  "grains-of-rice": FoodIconData(
    name: "Grains of Rice",
    slug: "grains-of-rice",
  ),
  "granulated-garlic": FoodIconData(
    name: "Garlic Powder",
    slug: "granulated-garlic",
  ),
  "grapes": FoodIconData(
    name: "Grapes",
    slug: "grapes",
  ),
  "greek-salad": FoodIconData(
    name: "Greek Salad",
    slug: "greek-salad",
  ),
  "green-tea": FoodIconData(
    name: "Green Tea",
    slug: "green-tea",
  ),
  "grocery-bag": FoodIconData(
    name: "Bag of Groceries",
    slug: "grocery-bag",
  ),
  "group-of-fruits": FoodIconData(
    name: "Fruits",
    slug: "group-of-fruits",
  ),
  "group-of-vegetables": FoodIconData(
    name: "Vegetables",
    slug: "group-of-vegetables",
  ),
  "guacamole": FoodIconData(
    name: "Guacamole",
    slug: "guacamole",
  ),
  "guinness-beer": FoodIconData(
    name: "Glass of Stout",
    slug: "guinness-beer",
    keywords: ["beer"],
  ),
  "gum": FoodIconData(
    name: "Chewing Gum",
    slug: "gum",
  ),
  "gyoza": FoodIconData(
    name: "Gyoza",
    slug: "gyoza",
  ),
  "hamburger": FoodIconData(
    name: "Hamburger",
    slug: "hamburger",
  ),
  "hamper": FoodIconData(
    name: "Picnic Basket",
    slug: "hamper",
  ),
  "hazelnut": FoodIconData(
    name: "Hazelnut",
    slug: "hazelnut",
  ),
  "honey": FoodIconData(
    name: "Jar of Honey",
    slug: "honey",
  ),
  "honey-spoon": FoodIconData(
    name: "Spoon of Honey",
    slug: "honey-spoon",
  ),
  "hot-chocolate": FoodIconData(
    name: "Hot Chocolate",
    slug: "hot-chocolate",
  ),
  "hot-chocolate-with-marshmallows": FoodIconData(
    name: "Hot Chocolate with Marshmallows",
    slug: "hot-chocolate-with-marshmallows",
  ),
  "hot-dog": FoodIconData(
    name: "Hot Dog",
    slug: "hot-dog",
  ),
  "ice-cream-cone": FoodIconData(
    name: "Ice Cream Cone",
    slug: "ice-cream-cone",
  ),
  "ice-cream-sundae": FoodIconData(
    name: "Ice Cream Sundae",
    slug: "ice-cream-sundae",
  ),
  "ingredients": FoodIconData(
    name: "Basket of Groceries",
    slug: "ingredients",
  ),
  "ingredients-for-cooking": FoodIconData(
    name: "Dairy Products",
    slug: "ingredients-for-cooking",
  ),
  "iranian-kebab": FoodIconData(
    name: "Iranian Kebab",
    slug: "iranian-kebab",
  ),
  "jackfruit": FoodIconData(
    name: "Jackfruit",
    slug: "jackfruit",
  ),
  "jam": FoodIconData(
    name: "Jam",
    slug: "jam",
  ),
  "jamon": FoodIconData(
    name: "Leg of Ham",
    slug: "jamon",
  ),
  "jelly": FoodIconData(
    name: "Jelly",
    slug: "jelly",
  ),
  "kebab": FoodIconData(
    name: "Kebab",
    slug: "kebab",
  ),
  "ketchup": FoodIconData(
    name: "Ketchup",
    slug: "ketchup",
  ),
  "kiwi": FoodIconData(
    name: "Kiwi",
    slug: "kiwi",
  ),
  "kohlrabi": FoodIconData(
    name: "Kohlrabi",
    slug: "kohlrabi",
  ),
  "korean-rice-cake": FoodIconData(
    name: "Tteokbokki",
    slug: "korean-rice-cake",
  ),
  "lasagna": FoodIconData(
    name: "Lasagne",
    slug: "lasagna",
  ),
  "leek": FoodIconData(
    name: "Leek",
    slug: "leek",
  ),
  "lemonade": FoodIconData(
    name: "Lemonade",
    slug: "lemonade",
  ),
  "lentil": FoodIconData(
    name: "Lentil",
    slug: "lentil",
  ),
  "lettuce": FoodIconData(
    name: "Lettuce",
    slug: "lettuce",
  ),
  "lime": FoodIconData(
    name: "Lime",
    slug: "lime",
  ),
  "lychee": FoodIconData(
    name: "Lychee",
    slug: "lychee",
  ),
  "macaron": FoodIconData(
    name: "Macaron",
    slug: "macaron",
  ),
  "mango": FoodIconData(
    name: "Mango",
    slug: "mango",
  ),
  "mangosteen": FoodIconData(
    name: "Mangosteen",
    slug: "mangosteen",
  ),
  "maple-syrup": FoodIconData(
    name: "Maple Syrup",
    slug: "maple-syrup",
  ),
  "matcha": FoodIconData(
    name: "Matcha",
    slug: "matcha",
  ),
  "mate": FoodIconData(
    name: "Mate",
    slug: "mate",
  ),
  "mayonnaise": FoodIconData(
    name: "Mayonnaise",
    slug: "mayonnaise",
  ),
  "melon": FoodIconData(
    name: "Slice of Melon",
    slug: "melon",
  ),
  "melting-ice-cream": FoodIconData(
    name: "Popsicle",
    slug: "melting-ice-cream",
  ),
  "milk": FoodIconData(
    name: "Jug of Milk",
    slug: "milk",
  ),
  "milk-bottle": FoodIconData(
    name: "Bottle of Milk",
    slug: "milk-bottle",
  ),
  "milk-carton": FoodIconData(
    name: "Carton of Milk",
    slug: "milk-carton",
  ),
  "milkshake": FoodIconData(
    name: "Milkshake",
    slug: "milkshake",
  ),
  "mint": FoodIconData(
    name: "Mint",
    slug: "mint",
  ),
  "moka-pot": FoodIconData(
    name: "Moka Pot",
    slug: "moka-pot",
  ),
  "moonshine-jug": FoodIconData(
    name: "Jug of Moonshine",
    slug: "moonshine-jug",
  ),
  "mozzarella": FoodIconData(
    name: "Mozzarella",
    slug: "mozzarella",
  ),
  "mulled-wine": FoodIconData(
    name: "Mulled Wine",
    slug: "mulled-wine",
  ),
  "mushroom": FoodIconData(
    name: "Mushroom",
    slug: "mushroom",
  ),
  "mushrooms": FoodIconData(
    name: "Mushrooms",
    slug: "mushrooms",
  ),
  "mustard": FoodIconData(
    name: "Mustard",
    slug: "mustard",
  ),
  "naan": FoodIconData(
    name: "Naan",
    slug: "naan",
  ),
  "nachos": FoodIconData(
    name: "Nachos",
    slug: "nachos",
  ),
  "nonya-kueh": FoodIconData(
    name: "Nonya Kueh",
    slug: "nonya-kueh",
  ),
  "noodles": FoodIconData(
    name: "Bowl of Noodles",
    slug: "noodles",
  ),
  "oat-milk": FoodIconData(
    name: "Carton of Oat Milk",
    slug: "oat-milk",
  ),
  "octopus": FoodIconData(
    name: "Octopus",
    slug: "octopus",
  ),
  "olive": FoodIconData(
    name: "Olives",
    slug: "olive",
  ),
  "olive-oil": FoodIconData(
    name: "Olive Oil",
    slug: "olive-oil",
  ),
  "omlette": FoodIconData(
    name: "Omelette",
    slug: "omlette",
  ),
  "onion": FoodIconData(
    name: "Onion",
    slug: "onion",
  ),
  "orange": FoodIconData(
    name: "Orange",
    slug: "orange",
  ),
  "orange-juice": FoodIconData(
    name: "Orange Juice",
    slug: "orange-juice",
  ),
  "paella": FoodIconData(
    name: "Paella",
    slug: "paella",
  ),
  "pancake-stack": FoodIconData(
    name: "Pancakes",
    slug: "pancake-stack",
  ),
  "papaya": FoodIconData(
    name: "Papaya",
    slug: "papaya",
  ),
  "paprika": FoodIconData(
    name: "Paprika",
    slug: "paprika",
  ),
  "pastel-de-nata": FoodIconData(
    name: "Pastel de Nata",
    slug: "pastel-de-nata",
  ),
  "peach": FoodIconData(
    name: "Peach",
    slug: "peach",
  ),
  "peanut-butter": FoodIconData(
    name: "Peanut Butter",
    slug: "peanut-butter",
  ),
  "peanuts": FoodIconData(
    name: "Peanuts",
    slug: "peanuts",
  ),
  "pear": FoodIconData(
    name: "Pear",
    slug: "pear",
  ),
  "peas": FoodIconData(
    name: "Peas",
    slug: "peas",
  ),
  "pecan": FoodIconData(
    name: "Pecans",
    slug: "pecan",
  ),
  "pepitas": FoodIconData(
    name: "Pumpkin Seeds",
    slug: "pepitas",
  ),
  "pie": FoodIconData(
    name: "Pie",
    slug: "pie",
  ),
  "pineapple": FoodIconData(
    name: "Pineapple",
    slug: "pineapple",
  ),
  "pint": FoodIconData(
    name: "Glass of Lager",
    slug: "pint",
    keywords: ["beer"],
  ),
  "pistachio-sauce": FoodIconData(
    name: "Pistachio Sauce",
    slug: "pistachio-sauce",
  ),
  "pizza": FoodIconData(
    name: "Slice of Pizza",
    slug: "pizza",
  ),
  "pizza-five-eighths": FoodIconData(
    name: "Sliced Pizza",
    slug: "pizza-five-eighths",
  ),
  "plastic-food-container": FoodIconData(
    name: "Food Container",
    slug: "plastic-food-container",
  ),
  "plum": FoodIconData(
    name: "Plum",
    slug: "plum",
  ),
  "pomegranate": FoodIconData(
    name: "Pomegranate",
    slug: "pomegranate",
  ),
  "popcorn": FoodIconData(
    name: "Popcorn",
    slug: "popcorn",
  ),
  "porridge": FoodIconData(
    name: "Porridge",
    slug: "porridge",
  ),
  "potato": FoodIconData(
    name: "Potato",
    slug: "potato",
  ),
  "potato-chips": FoodIconData(
    name: "Potato Chips",
    slug: "potato-chips",
  ),
  "poultry-leg": FoodIconData(
    name: "Chicken Drumstick",
    slug: "poultry-leg",
  ),
  "prawn": FoodIconData(
    name: "Prawn",
    slug: "prawn",
  ),
  "pretzel": FoodIconData(
    name: "Pretzel",
    slug: "pretzel",
  ),
  "pumpkin": FoodIconData(
    name: "Pumpkin",
    slug: "pumpkin",
  ),
  "quesadilla": FoodIconData(
    name: "Quesadilla",
    slug: "quesadilla",
  ),
  "rack-of-lamb": FoodIconData(
    name: "Rack of Lamb",
    slug: "rack-of-lamb",
  ),
  "radish": FoodIconData(
    name: "Radish",
    slug: "radish",
  ),
  "raisins": FoodIconData(
    name: "Raisins",
    slug: "raisins",
  ),
  "rambutan": FoodIconData(
    name: "Rambutan",
    slug: "rambutan",
  ),
  "raspberry": FoodIconData(
    name: "Raspberry",
    slug: "raspberry",
  ),
  "real-food-for-meals": FoodIconData(
    name: "Meal",
    slug: "real-food-for-meals",
  ),
  "rice-bowl": FoodIconData(
    name: "Bowl of Rice",
    slug: "rice-bowl",
  ),
  "rice-vinegar": FoodIconData(
    name: "Rice Vinegar",
    slug: "rice-vinegar",
  ),
  "rolled-oats": FoodIconData(
    name: "Rolled Oats",
    slug: "rolled-oats",
  ),
  "salad": FoodIconData(
    name: "Salad",
    slug: "salad",
  ),
  "salami": FoodIconData(
    name: "Salami",
    slug: "salami",
  ),
  "salami-pizza": FoodIconData(
    name: "Salami Pizza",
    slug: "salami-pizza",
  ),
  "salmon-sushi": FoodIconData(
    name: "Salmon Sushi",
    slug: "salmon-sushi",
  ),
  "salt": FoodIconData(
    name: "Salt",
    slug: "salt",
  ),
  "salt-shaker": FoodIconData(
    name: "Salt Shaker",
    slug: "salt-shaker",
  ),
  "samosa": FoodIconData(
    name: "Samosa",
    slug: "samosa",
  ),
  "sandwich": FoodIconData(
    name: "Sandwich",
    slug: "sandwich",
  ),
  "sandwich-with-fried-egg": FoodIconData(
    name: "Egg on Toast",
    slug: "sandwich-with-fried-egg",
  ),
  "sauce": FoodIconData(
    name: "Sauce",
    slug: "sauce",
  ),
  "sausages": FoodIconData(
    name: "Sausages",
    slug: "sausages",
  ),
  "sesame": FoodIconData(
    name: "Sesame",
    slug: "sesame",
  ),
  "sesame-oil": FoodIconData(
    name: "Sesame-Oil",
    slug: "sesame-oil",
  ),
  "shellfish": FoodIconData(
    name: "Shellfish",
    slug: "shellfish",
  ),
  "shrimp-and-lobster": FoodIconData(
    name: "Seafood",
    slug: "shrimp-and-lobster",
  ),
  "silken-tofu": FoodIconData(
    name: "Silken Tofu",
    slug: "silken-tofu",
  ),
  "smoked-paprika": FoodIconData(
    name: "Paprika Powder",
    slug: "smoked-paprika",
  ),
  "soda": FoodIconData(
    name: "Soda",
    slug: "soda",
  ),
  "soda-bottle": FoodIconData(
    name: "Bottle of Soda",
    slug: "soda-bottle",
  ),
  "soda-can": FoodIconData(
    name: "Can of Soda",
    slug: "soda-can",
  ),
  "soup-plate": FoodIconData(
    name: "Soup",
    slug: "soup-plate",
  ),
  "soursop": FoodIconData(
    name: "Soursop",
    slug: "soursop",
  ),
  "souvla": FoodIconData(
    name: "Souvla",
    slug: "souvla",
  ),
  "soy": FoodIconData(
    name: "Soy",
    slug: "soy",
  ),
  "soy-sauce": FoodIconData(
    name: "Soy Sauce",
    slug: "soy-sauce",
  ),
  "spaghetti": FoodIconData(
    name: "Spaghetti",
    slug: "spaghetti",
  ),
  "spam-can": FoodIconData(
    name: "Can of Spam",
    slug: "spam-can",
  ),
  "sparkling-water": FoodIconData(
    name: "Sparkling Water",
    slug: "sparkling-water",
  ),
  "spice": FoodIconData(
    name: "Pepper Mill",
    slug: "spice",
  ),
  "spinach": FoodIconData(
    name: "Spinach",
    slug: "spinach",
  ),
  "spoon-of-sugar": FoodIconData(
    name: "Spoon of Sugar",
    slug: "spoon-of-sugar",
  ),
  "sport-bottle": FoodIconData(
    name: "Flask of Water",
    slug: "sport-bottle",
  ),
  "spring-roll": FoodIconData(
    name: "Spring Roll",
    slug: "spring-roll",
  ),
  "squash": FoodIconData(
    name: "Squash",
    slug: "squash",
  ),
  "steak": FoodIconData(
    name: "Steak",
    slug: "steak",
  ),
  "steak-hot": FoodIconData(
    name: "Spicy Steak",
    slug: "steak-hot",
  ),
  "steak-very-hot": FoodIconData(
    name: "Very Spicy Steak",
    slug: "steak-very-hot",
  ),
  "strawberry": FoodIconData(
    name: "Strawberry",
    slug: "strawberry",
  ),
  "strawberry-cheesecake": FoodIconData(
    name: "Strawberry Cheesecake",
    slug: "strawberry-cheesecake",
  ),
  "sugar": FoodIconData(
    name: "Sugar Shaker",
    slug: "sugar",
  ),
  "sugar-cube": FoodIconData(
    name: "Sugar Cube",
    slug: "sugar-cube",
  ),
  "sugar-cubes": FoodIconData(
    name: "Sugar Cubes",
    slug: "sugar-cubes",
  ),
  "sunflower-butter": FoodIconData(
    name: "Sunflower Butter",
    slug: "sunflower-butter",
  ),
  "sunflower-oil": FoodIconData(
    name: "Sunflower Oil",
    slug: "sunflower-oil",
  ),
  "sunny-side-up-eggs": FoodIconData(
    name: "Fried Egg",
    slug: "sunny-side-up-eggs",
  ),
  "sushi": FoodIconData(
    name: "Sushi",
    slug: "sushi",
  ),
  "sweet-potato": FoodIconData(
    name: "Sweet Potato",
    slug: "sweet-potato",
  ),
  "sweetener": FoodIconData(
    name: "Sweetener",
    slug: "sweetener",
  ),
  "sweets": FoodIconData(
    name: "Sweets",
    slug: "sweets",
  ),
  "taco": FoodIconData(
    name: "Taco",
    slug: "taco",
  ),
  "take-away-food": FoodIconData(
    name: "Bag of Food",
    slug: "take-away-food",
  ),
  "tangelo": FoodIconData(
    name: "Tangelo",
    slug: "tangelo",
  ),
  "tapas": FoodIconData(
    name: "Tapas",
    slug: "tapas",
  ),
  "tea": FoodIconData(
    name: "Cup of Tea",
    slug: "tea",
  ),
  "tempeh": FoodIconData(
    name: "Tempeh",
    slug: "tempeh",
  ),
  "thanksgiving": FoodIconData(
    name: "Turkey",
    slug: "thanksgiving",
  ),
  "tin-can": FoodIconData(
    name: "Tin Can",
    slug: "tin-can",
  ),
  "toast": FoodIconData(
    name: "Toast",
    slug: "toast",
  ),
  "tomato": FoodIconData(
    name: "Tomato",
    slug: "tomato",
  ),
  "topping": FoodIconData(
    name: "Topping",
    slug: "topping",
  ),
  "truffle": FoodIconData(
    name: "Truffle",
    slug: "truffle",
  ),
  "tuna-steak": FoodIconData(
    name: "Tuna Steak",
    slug: "tuna-steak",
    keywords: ["fish"],
  ),
  "turmeric": FoodIconData(
    name: "Turmeric",
    slug: "turmeric",
  ),
  "vegetable-bouillion-paste": FoodIconData(
    name: "Bouillion",
    slug: "vegetable-bouillion-paste",
  ),
  "vegetables-bag": FoodIconData(
    name: "Bag of Vegetables",
    slug: "vegetables-bag",
  ),
  "vodka": FoodIconData(
    name: "Bottle of Vodka",
    slug: "vodka",
  ),
  "vodka-shot": FoodIconData(
    name: "Shot of Vodka",
    slug: "vodka-shot",
  ),
  "watermelon": FoodIconData(
    name: "Slice of Watermelon",
    slug: "watermelon",
  ),
  "wheat": FoodIconData(
    name: "Wheat",
    slug: "wheat",
  ),
  "whipped-cream": FoodIconData(
    name: "Whipped Cream",
    slug: "whipped-cream",
  ),
  "white-beans": FoodIconData(
    name: "White Beans",
    slug: "white-beans",
  ),
  "white-sesame-seeds": FoodIconData(
    name: "Sesame Seeds",
    slug: "white-sesame-seeds",
  ),
  "white-wine": FoodIconData(
    name: "Glass of White Wine",
    slug: "white-wine",
  ),
  "whole-fish": FoodIconData(
    name: "Fish",
    slug: "whole-fish",
  ),
  "whole-melon": FoodIconData(
    name: "Melon",
    slug: "whole-melon",
  ),
  "whole-watermelon": FoodIconData(
    name: "Watermelon",
    slug: "whole-watermelon",
  ),
  "wine": FoodIconData(
    name: "Bottle of Red Wine",
    slug: "wine",
  ),
  "wine-glass": FoodIconData(
    name: "Glass of Red Wine",
    slug: "wine-glass",
  ),
  "wooden-beer-keg": FoodIconData(
    name: "Barrel",
    slug: "wooden-beer-keg",
  ),
  "worcestershire-sauce": FoodIconData(
    name: "Worcestershire Sauce",
    slug: "worcestershire-sauce",
  ),
  "wrap": FoodIconData(
    name: "Wrap",
    slug: "wrap",
  ),
  "yogurt": FoodIconData(
    name: "Yogurt",
    slug: "yogurt",
    keywords: ["yoghurt"],
  ),
  "you-choy": FoodIconData(
    name: "Yu Choy",
    slug: "you-choy",
  ),
  "zucchini": FoodIconData(
    name: "Zucchini",
    slug: "zucchini",
    keywords: ["courgette"],
  ),
};
