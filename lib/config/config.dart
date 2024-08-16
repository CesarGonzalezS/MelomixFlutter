class Config {
    // General
    static const String getAllUsersEndpoint = '';

    // Authentication
    static const String signUpEndpoint = 'https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/sign_up';
    static const String emailVerification = 'https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/confirm_sign_up';
    static const String login = 'https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/login';

    // Albums
    static const String getAllAlbumsEndpoint = 'https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/read_all_albums';
    static const String createAlbumEndpoint = 'https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/create_albums';
    static const String updateAlbumEndpoint = 'https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/update_albums';
    static const String deleteAlbumEndpoint = 'https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/delete_albums';

    // Songs
    static const String getAllSongsEndpoint = 'https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/read_all_songs';
    static const String getSongEndpoint = 'https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/read_song';
    static const String postSongEndpoint = 'https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/create_song';
    static const String putSongEndpoint = 'https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/update_song';
    static const String deleteSongEndpoint = 'https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/delete_song';

    // Users
    static const String addUserEndpoint = 'https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/add_user';
    static const String updateUserEndpoint = 'https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/update_user';
    static const String deleteUserEndpoint = 'https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/delete_user';

    // Artists
    static const String getAllArtistEndpoint = 'https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/read_all_artist';
    static const String getArtistEndpoint = 'https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/read_artist';
    static const String postArtistEndpoint = 'https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/create_artist';
    static const String putArtistEndpoint = 'https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/read_all_artist';
    static const String deleteArtistEndpoint = 'https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/delete_artist';
}
