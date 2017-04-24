var functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

//Initial function call:
exports.checkChallenges = functions.https.onRequest((req, res) => {

  //create database ref
  var dbRef = admin.database().ref('/challenges');

  //get all of the challenges in the databaseRef
  dbRef.once("value").then(function(snapshot) {

    const challengeDict = snapshot.val();
    for (var item in challengeDict) {
      //for each challenge get the time and check if it's less than currnet date
      const challengeObj = challengeDict[item]
      let epochDate = challengeObj.endDate
      console.log('epoch date is ' + epochDate);
      let d = new Date(0); // The 0 there is the key, which sets the date to the epoch
      d.setUTCSeconds(epochDate);
      let endDate = d;
      let timeNow = new Date();
      console.log('time now is ' + timeNow);
      console.log('time of challenge is '+ endDate);
      if (timeNow > endDate) {
        //move challenge to oldChallenges
        var dictRef = admin.database().ref('/oldChallenges/'+item);
        dictRef.set(challengeObj).then(snapshot => {
        });

        //Check if there is a team for the challenge, if so remove it under the team "challenges" and add to "oldChallenges"
        let team = challengeObj['team'];
        if (team == 'no team') {
        } else {
          admin.database().ref('/teams/'+ team + '/challenges/'+  item).set(null).then(snapshot => {});
          admin.database().ref('/teams/'+ team + '/oldChallenges/'+item).set(true).then(snapshot => {});
        }

        //Get the users that are participating in the challenge 
        let users = challengeObj['users'];
        var items = Object.keys(users).map(function(key) {
          return {
            userId: key, 
            total: users[key]
          };
        });

        //sort users by value
        items.sort(function(first, second) {
          return second.total - first.total;
        });

        //if number of users is greater than 3 get the top three, then get the total number of 
        //gold/silver/bronze for the respective user and add 1 to their total
        var topThree = items.slice(0, 3);
        var ranks = ['gold', 'silver', 'bronze']
        let p = new Promise(function(resolve) { resolve()})
        topThree.reduce(function(promise, player, i){
          return promise.then(function(){
            return giveTrophies(item, player.userId, ranks[i])
          })
        }, p)

        //move challenge to completed challenges for each user
        items.forEach((i) => {
          removeChallengeFromUsers(item, i.userId)
        })

        //remove challenge from challenges
        dbRef.child(item).set(null).then(snapshot => {});
      } else {
        //Date hasn't passed
      }
    }
    //send response to request
    res.redirect(200);
  });
});


function giveTrophies(challengeID, userID, trophy) { 
  var dbRef = admin.database().ref('/users/' + userID);
  dbRef.child('trophies').child(trophy).transaction(function(currentValue) {
    return currentValue + 1
  });
}

function removeChallengeFromUsers(challengeID, userID) {
  var dbRef = admin.database().ref('/users/' + userID);
  return dbRef.child('/challenges/'+challengeID).set(null).then(snapshot => {
    return dbRef.child('/oldChallenges/'+challengeID).set(true).then(snapshot => {
      return dbRef.child(challengeID).set(null).then(snapshot => {
      });
    });
  });
}