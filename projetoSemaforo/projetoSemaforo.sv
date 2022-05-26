module projetoSemaforo(input clock, reset, modo, 
			output logic redA, yellowA, greenA, redB, yellowB, greenB);
	logic [5:0] estado_atual;
	logic [2:0] cont;
	
	parameter  //Os 3 primeiros bits são referentes ao semáforo da Via A e os 3 últimos os da via B
		//Os bis seguem a sequência: Vermelho - Amarelo - Verde
		greenRed = 6'b001100, 
		yellowRed = 6'b010100, 
		redGreen = 6'b100001, 
		redYellow = 6'b100010, 
		allOff = 6'b000000, 
		yellowOn = 6'b010010;
	
	always_comb begin
		case(estado_atual)
		/*Modo(0) Diurno*/
			greenRed : {redA, yellowA, greenA, redB, yellowB, greenB} <= greenRed;
			
			yellowRed : {redA, yellowA, greenA, redB, yellowB, greenB} <= yellowRed;
			
			redGreen : {redA, yellowA, greenA, redB, yellowB, greenB} <= redGreen;
			
			redYellow : {redA, yellowA, greenA, redB, yellowB, greenB} <= redYellow;
			
		/*Modo(1) Noturno*/
			yellowOn : {redA, yellowA, greenA, redB, yellowB, greenB} <= yellowOn;
			
			allOff : {redA, yellowA, greenA, redB, yellowB, greenB} <= allOff;
		endcase
	end
	
	always_ff @(posedge clock, negedge reset) begin
		if(~reset) begin //Reset assincrono
				estado_atual <= greenRed;
				cont <= 0;
		end
		
		else begin
			case(estado_atual)
			/*Modo(0) Diurno*/
				greenRed : begin
					if(modo == 1) begin
						estado_atual <= allOff;
						cont <= 3'd1;
					end
					else if(cont != 3'd3) begin
						cont <= cont + 3'd1;
					end
					else begin
						estado_atual <= yellowRed;
						cont <= 3'd1;
					end
				end
			
				yellowRed : begin
					if(modo == 1) begin
						estado_atual <= allOff;
						cont <= 3'd1;
					end
					else begin
						estado_atual <= redGreen;
						cont <= 3'd1;
					end
				end

				redGreen : begin
					if(modo == 1) begin
						estado_atual <= allOff;
						cont <= 3'd1;
					end
					else if(cont != 3'd3) begin
						cont <= cont + 3'd1;
					end
					else begin
						estado_atual <= redYellow;
						cont <= 3'd1;
					end
				end
				
				redYellow : begin
					if(modo == 1) begin
						estado_atual <= allOff;
						cont <= 3'd1;
					end
					else begin
						estado_atual <= greenRed;
						cont <= 3'd1;
					end
				end
				
			/*Modo(1) Noturno*/
				yellowOn : begin
					if(modo == 0)
						estado_atual <= greenRed;
					else
						estado_atual <= allOff;
				end

				allOff : begin
					if(modo == 0)
						estado_atual <= greenRed;
					else
						estado_atual <= yellowOn;
				end
			endcase
		end
	end	
endmodule