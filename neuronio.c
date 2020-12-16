#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main()
{
    //definição variaveis floats
    float peso1 = 0;
    float peso2 = 0.9;
    float data;
    float result;
    float taxaAprendizado = 0.05;
    float taxaErro = 1.1;
    float output;

    //Treinar neuronio
    for (int i = 1; i < 100; i++)
    {
        data = i;
        output = data + data;
        taxaErro = output - (peso1 + peso2) * data;

        if (taxaErro < taxaAprendizado)
        {
            break;
        }

        printf("Treino: \n");
        printf("Taxa de Erro do Teste/Treino= %f \n", taxaErro);

        //atualizar pesos
        if (i % 2 == 0) //Se i for par, atualiza peso 1
        {
            peso1 = peso1 + (taxaErro * taxaAprendizado * data);
        }
        else//Senao, atualiza peso 2
        {
            peso2 = peso2 + (taxaErro * taxaAprendizado * data);
        }

        printf("peso1 = %f\n", peso1);
        printf("peso2 = %f\n", peso2);
    }

    //Print dos resultados
    printf("\n");
    for (int i = 1; i < 11; i++)
    {
        data = i;
        result = data * peso1 + data * peso2;
        printf("Saída: \n");
        printf("%f + %f = %f \n", data, data, result);
    }
    return 0;
}