abstract final class ImageSources {
  static const _artists = 'assets/images/artists/';

  // MBID исполнителя -> локальный снимок с Викисклада (авторы в docs/CREDITS.md).
  static const _artistPhotos = <String, String>{
    '37b2cb82-ef79-4d46-a184-a549450aa231': '${_artists}artist_a_21_savage.jpg',
    '382f1005-e9ab-4684-afd4-0bdae4ee37f2': '${_artists}artist_a_2pac.png',
    '8e68819d-71be-4e7d-b41d-f1df81b01d3f': '${_artists}artist_a_50_cent.jpg',
    '9689aa5a-4471-4fb4-9721-07cecda0fa9f':
        '${_artists}artist_a_tribe_called_quest.jpg',
    '9beb62b2-88db-4cea-801e-162cd344ee53':
        '${_artists}artist_beastie_boys.jpg',
    '10a9ff92-9637-4498-afea-7044b2ab0dc0':
        '${_artists}artist_busta_rhymes.jpg',
    '51508c1f-8d07-4a00-9cf1-26c570fe7b78':
        '${_artists}artist_cypress_hill.jpg',
    'a8ebde98-7e91-46c7-992c-90039ba42017': '${_artists}artist_de_la_soul.jpg',
    '9fff2f8a-21e6-47de-a2b8-7f449929d43f': '${_artists}artist_drake.jpg',
    'b95ce3ff-3d05-4e87-9e01-c97b66af13d4': '${_artists}artist_eminem.jpg',
    '48262e82-db9f-4a92-b650-dfef979b73ec': '${_artists}artist_future.jpg',
    '36494952-f434-45d8-a958-8b4acdbcf8a8': '${_artists}artist_gucci_mane.jpg',
    '1d11e2a1-4531-4d61-a8c7-7b5c6a608fd2': '${_artists}artist_ice_cube.jpg',
    '875203e1-8e58-4b86-8dcb-7190faf411c5': '${_artists}artist_j_cole.jpg',
    '4e4ebde4-0c56-4dec-844b-6c73adcdd92d': '${_artists}artist_juice_wrld.png',
    '860d7dc2-618d-437e-a3bb-7b91c2d40095': '${_artists}artist_ken_carson.jpg',
    '381086ea-f511-4aba-bdf9-71c753dc5077':
        '${_artists}artist_kendrick_lamar.jpg',
    'c78c3026-426b-4580-ab23-08490bb8b515':
        '${_artists}artist_rae_sremmurd.jpg',
    '8837b875-3689-4646-b3fd-d8b53815c7a8':
        '${_artists}artist_lil_uzi_vert.png',
    'ac9a487a-d9d2-4f27-bb23-0f4686488345': '${_artists}artist_lil_wayne.jpg',
    'ea9078ef-20ca-4506-81ea-2ae5fe3a42e8': '${_artists}artist_madlib.jpg',
    '188711ed-c99b-439c-844a-ca831f63a727': '${_artists}artist_mf_doom.jpg',
    'cfbc0924-0035-4d6c-8197-f024653af823': '${_artists}artist_nas.jpg',
    '73fdb566-a9b1-494c-9f32-51768ec9fd27': '${_artists}artist_outkast.jpg',
    '2baf3276-ed6a-4349-8d2e-f4601e7b2167':
        '${_artists}artist_playboi_carti.jpg',
    'bf2e15d0-4b77-469e-bfb4-f8414415baca':
        '${_artists}artist_public_enemy.jpg',
    '5ecc3f72-20a6-47a0-8dc5-fb0b3dadeea0': '${_artists}artist_run_d_m_c.png',
    'f90e8b26-9e52-4669-a5c9-e28529c47894': '${_artists}artist_snoop_dogg.jpg',
    'e4a51f17-a57b-47b1-b37b-f552d0f8e9e6':
        '${_artists}artist_travis_scott.jpg',
    '8032cf05-d916-4b2a-9c53-6e75d4a24bd8':
        '${_artists}artist_trippie_redd.png',
    '0febdcf7-4e1f-4661-9493-b40427de2c13':
        '${_artists}artist_wu_tang_clan.jpg',
    '61af87f4-16ee-4431-8504-cc06187079fb':
        '${_artists}artist_xxxtentacion.jpg',
    '164f0d73-1234-4e2c-8743-d77bf2191051': '${_artists}artist_ye.jpg',
  };

  /// `null` — снимка нет, рисуется буквенная плитка.
  static String? artistPhoto(String artistId) => _artistPhotos[artistId];
}
