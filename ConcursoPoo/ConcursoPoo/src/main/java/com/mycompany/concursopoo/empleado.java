/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.concursopoo;

import java.util.Scanner;

/**
 *
 * @author noece
 */
public class empleado {
    //Crar una clase empleado 
    //nombre, salario base
    //SubClase: 'Empleado por hora', 'EmpleadoFijo','EmpleadoComision'.
    //Sobre escribir un metodo de caclculo salario. Solicitar datos y mostrar datos.
    
    private String nombre;
    private float salarioBase;
    
    public void calculoSalario() {
        Scanner sc = new Scanner(System.in);
        System.out.print("Ingresa tu nombre: ");
        nombre = sc.nextLine();

        System.out.print("Ingresa tu salario base: ");
        salarioBase = sc.nextFloat();
    }
    
    public class empleadoPorHora{
        private int horasTrabajadas;
        private float pagoPorHora;

        public void calculoSalario() {
        Scanner sc = new Scanner(System.in);

        System.out.print("Ingresa tu nombre: ");
        nombre = sc.nextLine();

        System.out.print("Ingresa horas trabajadas: ");
        horasTrabajadas = sc.nextInt();

        System.out.print("Ingresa pago por hora: ");
        pagoPorHora = sc.nextFloat();

        salarioBase = horasTrabajadas * pagoPorHora;
        }
    }
    
    public class empleadoFijo{
        private int diasTrabajados;
        private float pagoPorDia;

        public void calculoSalario() {
        Scanner sc = new Scanner(System.in);

        System.out.print("Ingresa tu nombre: ");
        nombre = sc.nextLine();

        System.out.print("Ingresa días trabajados: ");
        diasTrabajados = sc.nextInt();

        System.out.print("Ingresa pago por día: ");
        pagoPorDia = sc.nextFloat();

        salarioBase = diasTrabajados * pagoPorDia;
        }
    }
    public class empleadoPorComision{
        private int comisiones;
        private float pagoPorComision = 200;

        public void calculoSalario() {
        Scanner sc = new Scanner(System.in);

        System.out.print("Ingresa tu nombre: ");
        nombre = sc.nextLine();

        System.out.print("Ingresa días trabajados: ");
        comisiones = sc.nextInt();
        
        salarioBase = comisiones * pagoPorComision;
        }
    }
}
