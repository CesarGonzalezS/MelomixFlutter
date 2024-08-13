class Config {
    static const String getAllUsersEndpoint = '';

    static const String sing_upEndpoint='https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/sign_up';
    static const String emailVerification='https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/confirm_sign_up';
    static const String login='https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/login';

    // Albums
    static const String getAllAlbumsEndpoint="https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/read_albums";
    static const String createAlbumEndpoint="https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/create_albums";
    static const String updateAlbumEndpoint="https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/update_albums";
    static const String deleteAlbumEndpoint="https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/delete_albums";

    // Songs
    static const String getAllSongsEndpoint ='https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/read_song/';
    static const String getSongEndpoint='https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/read_song/';
    static const String postSongEndpoint='https://5zappruc5i.execute-api.us-east-2.amazonaws.com/Prod/create_song';
    static const String putSongEndpoint='https://5zappruc5i.execute-api.us-east-2.amazonaws.com/Prod/update_song';
    static const String deleteSongEndpoint='https://5zappruc5i.execute-api.us-east-2.amazonaws.com/Prod/delete_song/{songId}';

    // Users
    static const String addUserEndpoint='https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/add_user';
    static const String updateUserEndpoint='https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/update_user';
    static const String deleteUserEndpoint='https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/delete_user';

    // Favorites
    static const String getAllFavoritesByUserEndpoint="https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/get_all_favorites_by_user";
    static const String createFavoriteEndpoint="https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/create_favorite";
    static const String updateFavorite="https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/update_favorite";
    static const String deleteFavorite="https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod/delete_favorite/";


}
