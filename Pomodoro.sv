module Pomodoro(clk, rst, swPlayPause, bDezenaAcresce, bUnidadeAcresce, bDezenaDecresce, bUnidadeDecresce, displayUnidade, 
                displayDezena);
  input clk; 
  input rst; 
  input swPlayPause, bDezena, bUnidade; 
  output reg [6:0] display; 
  output reg [6:0] displayUnidadeSegundos
  output reg [6:0] displayDezenaSegundos
  output reg [6:0] displayUnidadeMinutos
  output reg [6:0] displayDezenaMinutos
  reg [3:0]UnidadeSegundos;
  reg [3:0]DezenaSegundos;
  reg [3:0]UnidadeMinutos;
  reg [3:0]DezenaMinutos;

  reg [3:0]UnidadeSegundos_ff;
  reg [3:0]DezenaSegundos_ff;
  reg [3:0]UnidadeMinutos_ff;
  reg [3:0]DezenaMinutos_ff;

  reg [7:0] reg_swPlayPause, reg_bDezenaAcresce, reg_bUnidadeAcresce, reg_bDezenaDecresce, reg_bUnidadeDecresce;
  reg [7:0] reg_swPlayPause_ff, reg_bDezenaAcresce_ff, reg_bUnidadeAcresce_ff, reg_bDezenaDecresce_ff, reg_bUnidadeDecresce_ff; 
  reg timedClk;

  enum {BEGIN, INITIAL, PUSH} ActualState, NextState;

  timer t(.clk(clk), .rst(rst), .timedClk(timedClk));
  Display7Segmentos displayUnidadeMinutos(.value(DezenaMinutos), .segments(display));
  Display7Segmentos displayDezenaMinutos(.value(UnidadeMinutos), .segments(display));
  Display7Segmentos displayUnidadeSegundos(.value(DezenaSegundos), .segments(display));
  Display7Segmentos displayDezenaSegundos(.value(UnidadeSegundos), .segments(display));
  //dec7seg dec1(.bin(bin1), .dec(dis1));

  always_comb 
    begin
      logic_Dezena = logic_Dezena_ff;
      logic_Unidade = logic_Unidade_ff;

      reg_bDezenaAcresce = reg_bDezenaAcresce_ff;
      reg_bUnidadeAcresce = reg_bUnidadeAcresce_ff;
      reg_bDezenaDecresce = reg_bDezenaDecresce_ff;
      reg_bUnidadeDecresce = reg_bUnidadeDecresce_ff

      case (ActualState)
        BEGIN: 
          begin
            swPlayPause = 8'd1
            reg_bDezena = 8'd0;
            reg_bUnidade = 8'd0;
          end

        INITIAL: 
          begin
            Unidade = 0;
            Dezena = 0;
          end

        PUSH: 
          begin
            if (bDezenaAcresce && !swPlayPause)  
              begin 
                Dezena = Dezena + 4'd1; 
              end

            if (bDezenaDecresce && !swPlayPause)
              begin 
                Dezena = Dezena - 4'd1;
              end 

            if (bUnidadeAcresce && !swPlayPause) 
              begin 
                Unidade = Unidade + 4'd1;
              end 

            if (bUnidadeDecresce && !swPlayPause) 
              begin 
                Unidade = Unidade - 4'd1;
              end
          end
      endcase
    end


  always_ff @(posedge timedClk, posedge rst) 
    begin
      if (rst) 
        begin
          ActualState <= BEGIN; 

          reg_bDezenaAcresce_ff <= 8'd0;
          reg_bUnidadeAcresce_ff <= 8'd0;
          reg_bDezenaDecresce_ff <= 8'd0;
          reg_bUnidadeDecresce_ff <= 8'd0;

          logic_Unidade_ff <= 7';
          logic_Dezena_ff <= logic_DezenaSegundos;


        end else begin
          ActualState <= NextState; 

          reg_bDezenaAcresce_ff <= 8'd0;
          reg_bUnidadeAcresce_ff <= 8'd0;
          reg_bDezenaDecresce_ff <= 8'd0;
          reg_bUnidadeDecresce_ff <= 8'd0;

          reg_b1_ff <= reg_b1;
          reg_b2_ff <= reg_b2;
          reg_b3_ff <= reg_b3;
          reg_b4_ff <= reg_b4;

          logic_UnidadeSegundos_ff <= logic_UnidadeSegundos;
          logic_DezenaSegundos_ff <= logic_DezenaSegundos;
          logic_UnidadeMinutos_ff <= logic_UnidadeMinutos;
          logic_DezenaMinutos_ff <= logic_DezenaMinutos;

        end
    end

  always_comb begin
    NextState = ActualState;

    case (ActualState) 
      BEGIN: 
        NextState = INITIAL;

      INITIAL: 
        if (swPlayPause) NextState <= PUSH; 
      always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
          DezenaMinutos_ff <= DezenaMinutos;
          UnidadeMinutos_ff <= UnidadeMinutos;
          DezenaSegundos_ff <= DezenaSegundos;
          UnidadeSegundos_ff <= UnidadeSegundos;     

        end else if (clk) begin
          if (DezenaMinutos_ff == 4'b0000) 
            if (UnidadeMinutos_ff == 4'b0000)
              if (DezenaSegundos_ff == 4'b0000) 
                if (UnidadeSegundos_ff == 4'b0000)
                  begin 
                    // Contador chegou a zero, não decrementar mais
                  end else begin
                      DezenaMinutos_ff <= DezenaMinutos_ff - 1;
                      UnidadeMinutos_ff <= 4'b1001; // 9
                      DezenaSegundos_ff <= 4'b0101; // 5
                      UnidadeSegundos_ff <= 4'b1001; // 9
            end
        end else begin
          UnidadeMinutos_ff <= UnidadeMinutos_ff - 1;
          UnidadeSegundos_ff <= 4'b0101; // 5
          DezenaSegundos_ff <= 4'b1001; // 9
        end
      end else begin
        DezenaMinutos_ff <= DezenaMinutos_ff - 1;
        UnidadeSegundos_ff <= 4'b1001; // 9
      end
      end else begin
        UnidadeSegundos_ff <= UnidadeSegundos_ff - 1;
      end
      end
      // Atribuição das saídas
      UnidadeMinutos <= UnidadeMinutos_ff;
      DezenaMinutos <= DezenaMinutos_ff; 
      UnidadeSegundos <= UnidadeSegundos_ff;
      DezenaSegundos <= DezenaSegundos_ff;
      end

    endcase

    PUSH: 
    NextState = INITIAL; 

    endcase
  end
endmodule



// Lógica para decrementar minutos e segundos






/*// cornometro 60'
                                                                                                                          module cronometro 
                                                                                                                          (
                                                                                                                              input in, clk,
                                                                                                                              output logic [6:0] dis0, 
                                                                                                                              output logic [6:0] dis1
                                                                                                                          );

                                                                                                                          logic clk1;
                                                                                                                          logic [3:0]bin0;
                                                                                                                          logic [2:0]bin1;

                                                                                                                          divCLK div(.clk_in(clk), .clk_out(clk1));                           
                                                                                                                          dec7seg dec0(.bin(bin0), .dec(dis0));
                                                                                                                          dec7seg dec1(.bin(bin1), .dec(dis1));

                                                                                                                          always @(posedge clk1, negedge in)
                                                                                                                           begin 
                                                                                                                              if (in==1'b0)
                                                                                                                               begin
                                                                                                                                  bin0 <= 0;
                                                                                                                                  bin1 <= 0;
                                                                                                                               end
                                                                                                                              else begin 
                                                                                                                                  bin0 <= bin0+1;
                                                                                                                                  if (bin0 == 9)
                                                                                                                                   begin 
                                                                                                                                      bin0 <= 0;
                                                                                                                                      bin1 <= bin1+1;
                                                                                                                                   end
                                                                                                                                  if (bin1 == 5 && bin0 ==9)
                                                                                                                                   begin 
                                                                                                                                      bin1 <= 0;
                                                                                                                                   end 
                                                                                                                               end
                                                                                                                           end 
                                                                                                                          endmodule */


/*// cronometro 60' com pausa 
                                                                                                                          module cronometro 
                                                                                                                          (
                                                                                                                              input r, clk, p,
                                                                                                                              output logic [6:0] dis0, 
                                                                                                                              output logic [6:0] dis1
                                                                                                                          );

                                                                                                                          logic clk1;
                                                                                                                          logic b;
                                                                                                                          logic [3:0]bin0;
                                                                                                                          logic [2:0]bin1;

                                                                                                                          divCLK div(.clk_in(clk), .clk_out(clk1));                           
                                                                                                                          dec7seg dec0(.bin(bin0), .dec(dis0));
                                                                                                                          dec7seg dec1(.bin(bin1), .dec(dis1));

                                                                                                                          always @(posedge clk1, negedge r)
                                                                                                                           begin 
                                                                                                                              if (r == 1'b0)
                                                                                                                               begin
                                                                                                                                  bin0 <= 0;
                                                                                                                                  bin1 <= 0;
                                                                                                                               end
                                                                                                                              else begin
                                                                                                                                  if (b)
                                                                                                                                   begin
                                                                                                                                   end  
                                                                                                                                  else begin 
                                                                                                                                      bin0 <= bin0+1;
                                                                                                                                      if (bin0 == 9)
                                                                                                                                       begin 
                                                                                                                                          bin0 <= 0;
                                                                                                                                          bin1 <= bin1+1;
                                                                                                                                       end
                                                                                                                                      if (bin1 == 5 && bin0 == 9)
                                                                                                                                       begin 
                                                                                                                                              bin1 <= 0;
                                                                                                                                       end 
                                                                                                                                  end
                                                                                                                               end
                                                                                                                           end

                                                                                                                          always @(negedge p)
                                                                                                                           begin 
                                                                                                                               b <= ~b;
                                                                                                                           end

                                                                                                                          endmodule 
                                                                                                                          */
