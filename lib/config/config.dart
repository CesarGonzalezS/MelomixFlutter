class Config {
    static const String cognitoApiUrl = 'https://l54ncy8pk4.execute-api.us-east-2.amazonaws.com/Prod';    static const String albumApiUrl = 'https://eaeg2uqxz7.execute-api.us-east-2.amazonaws.com/Prod';
    static const String songApiUrl = 'https://6flief1e38.execute-api.us-east-2.amazonaws.com/Prod';
    static const String userApiUrl = 'https://nzjibvj5zh.execute-api.us-east-2.amazonaws.com/Prod';
    static const String artistApiUrl = 'https://ys5fpean17.execute-api.us-east-2.amazonaws.com/Prod';

    // General
    static const String getAllUsersEndpoint = '';

    // Authentication
    static const String signUpEndpoint = cognitoApiUrl + '/sign_up';
    static const String emailVerification = cognitoApiUrl + '/confirm_sign_up';
    static const String login = cognitoApiUrl + '/login';

    // Albums
    static const String getAllAlbumsEndpoint = albumApiUrl + '/read_all_albums';
    static const String createAlbumEndpoint = albumApiUrl + '/create_albums';
    static const String updateAlbumEndpoint = albumApiUrl + '/update_albums';
    static const String deleteAlbumEndpoint = albumApiUrl + '/delete_albums';

    // Songs
    static const String getAllSongsEndpoint = songApiUrl + '/read_all_songs';
    static const String getSongEndpoint = songApiUrl + '/read_song';
    static const String postSongEndpoint = songApiUrl + '/create_song';
    static const String putSongEndpoint = songApiUrl + '/update_song';
    static const String deleteSongEndpoint = songApiUrl + '/delete_song';

    // Users
    static const String addUserEndpoint = userApiUrl + '/create_user';
    static const String updateUserEndpoint = userApiUrl + '/update_user';
    static const String deleteUserEndpoint = userApiUrl + '/delete_user';

    // Artists
    static const String getAllArtistEndpoint = artistApiUrl + '/read_all_artist';
    static const String getArtistEndpoint = artistApiUrl + '/read_artist';
    static const String postArtistEndpoint = artistApiUrl + '/create_artist';
    static const String putArtistEndpoint = artistApiUrl + '/update_artist';
    static const String deleteArtistEndpoint = artistApiUrl + '/delete_artist';
}
