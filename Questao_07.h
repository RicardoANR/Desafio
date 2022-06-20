#include<stdio.h>

int main()
{
	int i, conta = 0;
	char caracteres[50], c;

	printf("Digite uma string: ");
	gets(caracteres);

	for(i=0; caracteres[i]!='\0'; i++) {
			conta++;
	}

	if(conta==0) {
		printf("Caractere nao encontrado");
	} else {
		printf ("Contagem de caracteres = %d\n", conta);
	}
}