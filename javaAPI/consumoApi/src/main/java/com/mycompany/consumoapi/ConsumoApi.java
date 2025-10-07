package com.mycompany.consumoapi;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class ConsumoApi {

    public static void main(String[] args) {
        try {
            // URL API
            String urlString = "https://pokeapi.co/api/v2/pokemon/pikachu";
            URL url = new URL(urlString);

            // conexión
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            // Verificar la respuesta del servidor
            int responseCode = conn.getResponseCode();
            if (responseCode == 200) {
                // Leer respuesta
                BufferedReader reader = new BufferedReader(
                        new InputStreamReader(conn.getInputStream())
                );
                StringBuilder response = new StringBuilder();
                String line;

                while ((line = reader.readLine()) != null) {
                    response.append(line);
                }
                reader.close();
                System.out.println("Respuesta de la API de Pokémon:");
                System.out.println(response.toString());

            } else {
                System.out.println("Error al conectar. Código de respuesta: " + responseCode);
            }

            conn.disconnect();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
