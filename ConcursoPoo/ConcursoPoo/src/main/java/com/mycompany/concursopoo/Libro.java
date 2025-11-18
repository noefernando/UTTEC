/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.concursopoo;

/**
 *
 * @author noece
 */
public class Libro {

    private String titulo;
    private String autor;
    private int año;
public class empleadoHora{
    int salario = 200;
}
public class empleadoFijo{
    int salario = 100;
}
public class empleadoComision{
    int salario = 250;
}

    public Libro() {
    }

    public Libro(String titulo, String autor, int año) {
        this.titulo = titulo;
        this.autor = autor;
        this.año = año;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getAutor() {
        return autor;
    }

    public void setAutor(String autor) {
        this.autor = autor;
    }

    public int getAño() {
        return año;
    }

    public void setAño(int año) {
        this.año = año;
    }

    // Método para procesar/imprimir
    public void procesar() {
        if(año>0&&año<=2025){
            System.out.println("Libro recibido:");
            System.out.println("Título: " + titulo);
            System.out.println("Autor: " + autor);
            System.out.println("Año: " + año);
        }else{
            System.out.println("Año no valido");
        }
    }
}
