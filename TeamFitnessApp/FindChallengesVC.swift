//
//  FindChallengesVC.swift
//  TeamFitnessApp
//
//  Created by Alessandro Musto on 4/20/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class FindChallengesVC: UIViewController {

    var collectionView: UICollectionView!
    var goals: [Goal]!
    var challengeSearchBar: UISearchBar!
    var tableView: UITableView!
    var searchActive: Bool = false
    var filteredChallenges = [Challenge]()
    var challenges = [Challenge]()
    var challenge: Challenge!

    fileprivate let sectionInsets = UIEdgeInsets(top: 25.0, left: 25.0, bottom: 25.0, right: 25.0)
    fileprivate let itemsPerRow: CGFloat = 2



    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setTitle(text: "Choose Challenge Type")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onCancel(_:)))

        self.view.backgroundColor = UIColor.whitewash

        let flowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView!.register(FindChallengeCell.self, forCellWithReuseIdentifier: "fChallengeCell")
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self

        challengeSearchBar = UISearchBar()
        self.view.addSubview(challengeSearchBar)
        challengeSearchBar.translatesAutoresizingMaskIntoConstraints = false
        challengeSearchBar.placeholder = "find challenge by name"
        challengeSearchBar.setPlaceholderAttributes()
        challengeSearchBar.setTextAttributes()
        challengeSearchBar.delegate = self
        challengeSearchBar.searchBarStyle = .minimal

        tableView = UITableView()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.clear
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FitnessCell.self, forCellReuseIdentifier: "fitnessCell")

        setGoals()
        setConstraints()
        getData()
    }

    func onCancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    func setGoals() {
        let goal1 = Goal(type: .exerciseMinutes, value: 0)
        let goal2 = Goal(type: .caloriesBurned, value: 0)
        let goal3 = Goal(type: .miles, value: 0)
        let goal4 = Goal(type: .stepCount, value: 0)

        goals = [goal1, goal2, goal3, goal4]
        collectionView.reloadData()
    }


    func setConstraints() {

        challengeSearchBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 75).isActive = true
        challengeSearchBar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        challengeSearchBar.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
        challengeSearchBar.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.80).isActive = true

        collectionView.topAnchor.constraint(equalTo: challengeSearchBar.bottomAnchor, constant: 10).isActive = true
        collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, constant: -100).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true

        tableView.topAnchor.constraint(equalTo: challengeSearchBar.bottomAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: challengeSearchBar.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: collectionView.heightAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: challengeSearchBar.leadingAnchor).isActive = true
    }

}

extension FindChallengesVC: UICollectionViewDelegate, UICollectionViewDataSource  {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goals.count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fChallengeCell", for: indexPath) as! FindChallengeCell
        cell.goal = goals[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ChallengeTypeVC()
        vc.goal = goals[indexPath.item]
        vc.challenges = challenges
        self.navigationController?.pushViewController(vc, animated: true)

    }
}


//MARK: - UICollectionViewDelegateFlowLayout


extension FindChallengesVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let width = availableWidth / itemsPerRow
        let height = width
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}


//MARK: - Search bar delegate

extension FindChallengesVC: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
        self.view.bringSubview(toFront: tableView)
        collectionView.isHidden = true
        tableView.isHidden = false
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
        collectionView.isHidden = false
        tableView.isHidden = true
        filteredChallenges = challenges
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        collectionView.isHidden = false
        tableView.isHidden = true
        filteredChallenges = challenges
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        collectionView.isHidden = false
        tableView.isHidden = true
        filteredChallenges = challenges
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredChallenges = challenges.filter({ (challenge) -> Bool in
            let temp: String = challenge.name
            let range = temp.range(of: searchText, options: .caseInsensitive)
            return range != nil
        })
        if challengeSearchBar.text == nil || challengeSearchBar.text == "" {
            self.searchActive = false
        } else {
            self.searchActive = true
        }

        tableView.reloadData()
    }
}
//MARK: - Table view data source and delegate

extension FindChallengesVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return filteredChallenges.count
        } else {
            return challenges.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fitnessCell", for: indexPath) as! FitnessCell

        if searchActive {
            cell.setLabels(forChallenge: filteredChallenges[indexPath.row])
        } else {
            cell.setLabels(forChallenge: challenges[indexPath.row])
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let challengeDetailVC = ChallengeDetailVC()
        challengeDetailVC.setChallenge(challenge: filteredChallenges[indexPath.row])
        self.navigationController?.pushViewController(challengeDetailVC, animated: true)
    }
}

//MARK: - Firebase calls

extension FindChallengesVC {

    func getData() {
        self.challenges.removeAll()
        self.filteredChallenges.removeAll()
        FirebaseManager.fetchAllChallenges { (challenges) in
            self.challenges = challenges
            self.filteredChallenges = self.challenges
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}
