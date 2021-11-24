

class UserProfile {
  final String name, avatar_url, bio;
  final int followers, following;

  UserProfile({
    required this.name, 
    required this.avatar_url, 
    required this.bio, 
    required this.followers,
    required this.following});

//first method
//to get the userprofile obj 
//  UserProfile.fromJson(Map<String, dynamic> json) : 
// name = json['name'] == null ? 'bsal' : json['name'],
// avatar_url = json['avatar_url']== null ? 'url' : json['avatar_url'],
// bio = json['bio']== null ? 'bio' : json['bio'],
// followers = json['followers'],
// following = json['following'];

//second method
//In the following example, the UserProfile factory constructor returns objects from a cache, and the UserProfile.fromJson factory constructor initializes a final variable from a JSON object.
factory UserProfile.fromJson(Map<String, dynamic> json) {
  return UserProfile(
    name: json['name'] == null ? 'bsal' : json['name'],
    avatar_url: json['avatar_url'] == null ? 'url' : json['avatar_url'],
    bio: json['bio'] == null ? 'bio' : json['bio'],
    following: json['following'],
    followers: json['followers']
  );
}



Map<String, dynamic> toJson() => {
'name' : name,
'bio' : bio,
'avatar_url' : avatar_url,
'followers': followers,
'following' : following
};

}