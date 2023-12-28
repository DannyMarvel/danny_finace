
// Card(
//                     child: Row(
//                   children: [
//                     Column(
//                       children: [
//                         Container(
//                           height: 200,
//                           child: Text(
//                             tx.title,
//                             style: TextStyle(color: Colors.orange),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                       ],
//                     ),
//                     Container(
//                       //Note the container grows with the inputed contents
//                       padding: EdgeInsets.all(10),
//                       margin: EdgeInsets.symmetric(
//                         vertical: 15,
//                         horizontal: 20,
//                       ),
//                       //Container takes only one child widget
//                       //While Row or Column takes in unlimited child widgets
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Theme.of(context).primaryColor,
//                           width: 2,
//                         ),
//                       ),
//                       child: Text(
//                         '\$' + tx.amount.toStringAsFixed(2),
//                         //toStringAsFixed rounds it up to two decimal place
//                         //We can concartinate strings together by adding'A:' +
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20,
//                           color: Theme.of(context).primaryColor,
//                         ),
//                       ),
//                     ),
//                     //You can convert a double(integer) to a string
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           tx.title,
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           DateFormat(tx.date.toIso8601String())
//                               .format(tx.date), //tx.date.toString(),
//                           style: TextStyle(
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 )
//                 );