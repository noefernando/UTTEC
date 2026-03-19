package ordenamientoburbuja;

public class OrdenamientoBurbuja {

    public static void main(String[] args) {

        int vec[][] = {
            {6,8,3,5,4,9,0,2,1,7},
            {4,9,0,2,1,7},
            {6,8,3,5,1,7}
        };

        System.out.print("Vector sin ordenar: ");

        // Impresión desordenada
        for(int i = 0; i < vec.length; i++){
            System.out.print("\nDimencion " + i + ": ");
            for(int j = 0; j < vec[i].length; j++){
                System.out.print(vec[i][j] + " ");
            }
        }

        // Ordenamiento burbuja por cada fila
        for(int i = 0; i < vec.length; i++){
            for(int j = 0; j < vec[i].length - 1; j++){
                for(int k = 0; k < vec[i].length - 1 - j; k++){
                    if(vec[i][k] > vec[i][k+1]){
                        int aux = vec[i][k];
                        vec[i][k] = vec[i][k+1];
                        vec[i][k+1] = aux;
                    }
                }
            }
        }

        System.out.print("\n\nVector ordenado: ");

        for(int i = 0; i < vec.length; i++){
            System.out.print("\nDimencion " + i + ": ");
            for(int j = 0; j < vec[i].length; j++){
                System.out.print(vec[i][j] + " ");
            }
        }
    }
}