import 'package:audio_service/audio_service.dart';

// Clase que convierte mapas de datos en objetos MediaItem para la gestión de medios
class MediaItemConverter {
  // Método estático para convertir un mapa de datos de canción en un objeto MediaItem
  static MediaItem mapToMediaItem(Map song,
      {bool addedByAutoplay = false, // Indica si el ítem fue añadido automáticamente
        bool autoplay = true, // Indica si el ítem debe reproducirse automáticamente
        String? playlistBox}) { // Nombre de la lista de reproducción opcional
    return MediaItem(
      id: song['id'].toString(), // Identificador del ítem
      album: song['album'].toString(), // Nombre del álbum
      artist: song['artist'].toString(), // Nombre del artista
      duration: Duration(
        seconds: int.parse(
          // Duración del ítem en segundos, con un valor predeterminado de 180 segundos si no está presente
          (song['duration'] == null ||
              song['duration'] == 'null' ||
              song['duration'] == '')
              ? '180'
              : song['duration'].toString(),
        ),
      ),
      title: song['title'].toString(), // Título del ítem
      artUri: Uri.parse(
        getImageUrl(song['image'].toString()), // URL de la imagen del ítem
      ),
      genre: song['language'].toString(), // Género o idioma del ítem
      extras: {
        'user_id': song['user_id'], // Identificador del usuario asociado
        'url': song['url'], // URL del recurso de medios
        'album_id': song['album_id'], // Identificador del álbum
        'addedByAutoplay': addedByAutoplay, // Indicador de añadido automático
        'autoplay': autoplay, // Indicador de reproducción automática
        'playlistBox': playlistBox, // Nombre de la lista de reproducción
      },
    );
  }
}

// Función que ajusta la URL de la imagen según la calidad especificada
String getImageUrl(String? imageUrl, {String quality = 'high'}) {
  if (imageUrl == null) return ''; // Retorna una cadena vacía si la URL es nula
  switch (quality) {
    case 'high':
    // Reemplaza las partes de la URL para obtener una imagen de alta calidad
      return imageUrl.trim()
          .replaceAll("http:", "https:") // Cambia el esquema http por https
          .replaceAll("50x50", "500x500") // Reemplaza el tamaño de imagen bajo por alto
          .replaceAll("150x150", "500x500"); // Reemplaza el tamaño medio por alto
    case 'medium':
    // Reemplaza las partes de la URL para obtener una imagen de calidad media
      return imageUrl
          .trim()
          .replaceAll("http:", "https:") // Cambia el esquema http por https
          .replaceAll("50x50", "150x150") // Reemplaza el tamaño de imagen bajo por medio
          .replaceAll("500x500", "150x150"); // Reemplaza el tamaño alto por medio
    case 'low':
    // Reemplaza las partes de la URL para obtener una imagen de baja calidad
      return imageUrl
          .trim()
          .replaceAll("http:", "https:") // Cambia el esquema http por https
          .replaceAll("150x150", "50x50") // Reemplaza el tamaño medio por bajo
          .replaceAll("500x500", "50x50"); // Reemplaza el tamaño alto por bajo
    default:
    // Por defecto, devuelve la URL para una imagen de alta calidad
      return imageUrl
          .trim()
          .replaceAll("http:", "https:") // Cambia el esquema http por https
          .replaceAll("50x50", "500x500") // Reemplaza el tamaño de imagen bajo por alto
          .replaceAll("150x150", "500x500"); // Reemplaza el tamaño medio por alto
  }
}
