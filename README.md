# PomodoroSV

Grupo: João Granvile, Aurélio José, André Teles

Forma de uso

SET:
	1) Utilizar o SW0 -> bSelectTimer para alternar entre 3 tempos(Trabalho, Intervalo Curto e Intervalo Longo.)

	2) Observando o display de 7 segmentos(HEX0, HEX1, HEX2, HEX3) utilizar o SW1, SW2, SW3, SW4  -> Respectivamente -> bUnidadeAcresce, bDezenaAcresce, bUnidadeDecresce, bDezenaDecresce -> para selecionar o tempo de Trabalho e dos intervalos juntamente com o SW0 (bSelectTimer) alternando entre eles. 
Exemplo -> Inicialmente para o tempo do Trabalho aperte o SW2 até que a dezena de minutos chegue a 2 e o SW1 até que a unidade de minutos chegue a cinco.
Depois use o SW0 para trocar para o Intervalo Curto e use o SW1 para colocá-lo em cinco minutos. Após isso use troque para o Intervalo Longo com o SW0 e coloque o tempo para 30 minutos.

	3) Utilizar os SW5 SW6 SW7 SW8 observando o display de 7 segmentos(HEX4, HEX5) -> Respectivamente -> bLoopAcresce, bLoopDecresce, bLoopMaiorAcresce, bLoopMaiorDecresce -> para selecionar a quantidade de loops menores (Trabalho -> Intervalo Curto) e a quantidade de loops maiores (Trabalho -> Intervalo Curto -> Intervalo Longo.)

	4) Utilizar o SW16(swPlayPause) para iniciar o pomodoro -> Estados(TRABALHO -> INTERVALO CURTO.)
	
	5) Utilizar o SW17(rst) para resetar o pomodoro ao seu estado inicial. 
