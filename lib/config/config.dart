class Config {
static const String getAllUsersEndpoint = '';

static const String sing_upEndpoint='https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/sign_up';
static const String emailVerification='https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/confirm_sign_up';
static const String login='https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/login';

static const String getReadAlmbuns='https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/read_albums/1';

//CRUD Songs
static const String getAllSongsEndpoint ='https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/read_song/'
static const String getSongEndpoint='https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/read_song/${songId}';
static const String postSongEndpoint=' https://5zappruc5i.execute-api.us-east-2.amazonaws.com/Prod/create_song';
static const String putSongEndpoint=' https://5zappruc5i.execute-api.us-east-2.amazonaws.com/Prod/update_song';
static const String deleteSongEndpoint=' https://5zappruc5i.execute-api.us-east-2.amazonaws.com/Prod/delete_song/${songId}'; 

}
