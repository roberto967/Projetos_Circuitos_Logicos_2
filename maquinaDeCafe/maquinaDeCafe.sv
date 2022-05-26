module maquinaDeCafe (input [1:0]TIPO, input Clock, Reset, output logic C, L, F);

int liquido_c = 0;
int liquido_l = 0; 

logic [1:0]estados;
parameter estado_inicial = 0, estado_enchendo_c = 1, estado_enchendo_l = 2, 
estado_final = 3;

always_comb
begin
	case(estados)
	estado_inicial:
		begin
		C = 0;
		F = 0;
		L = 0;
		end
	estado_enchendo_c:
		begin
		C = 1;
		F = 0;
		L = 0;
		end
	estado_enchendo_l:
		begin
		C = 0;
		F = 0;
		L = 1;
		end
	estado_final:
		begin
		C = 0;
		F = 1;
		L = 0;
		end
	endcase
end
		
always_ff @ (posedge Clock or negedge Reset)
begin
	if(~Reset)
		begin
		estados <= estado_inicial;
		end
	else
		case(estados)
		estado_inicial:
			begin
			estados <= estado_enchendo_c;
			end
		estado_enchendo_c:
			begin
			liquido_c += 25;
			if (((TIPO == 0 || TIPO == 2) && liquido_c == 50) || 
				(TIPO == 1 && liquido_c == 100))
				begin
				if (TIPO == 2)
					estados <= estado_enchendo_l;
				else
					estados <= estado_final;
				end
			end
		estado_enchendo_l:
			begin
			liquido_l += 25;
			if (liquido_l == 50)
				begin
				estados <= estado_final;
				end
			end
		estado_final:
			begin
			liquido_l = 0;
			liquido_c = 0;
			estados <= estado_inicial;
			end
		endcase		
end
endmodule