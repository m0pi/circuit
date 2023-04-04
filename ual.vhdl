-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity Ual is

port (
    A in std_logic_vector (3 downto 0);
    B in std_logic_vector (3 downto 0);
    SLT : in std_logic_vector (3  downto 0);
    SR_IN_R : in std_logic;
    SR_IN_L : in std_logic;
    S : out std_logic_vector (7 downto 0);
    SR_OUT_R : out std_logic;
    SR_OUT_L : out std_logic;
);
end Ual;

architecture Ual_DataFlow of Ual is
signal my_A : std_logic_vector(7 downto 0);
signal my_B : std_logic_vector(7 downto 0);

begin

    case SLT is
        when "0000" => --nop (no operation) S = 0 | SR_OUT_L = 0 et SR_OUT_R = 0
            S <= ( others => '0');
            S_OUT_R <='0';
  	        S_OUT_ <='0';

        when "0001" => --S = Déc. droite A sur 4 bits(avec SR_IN_L) | SR_IN_L pour le bit entrant et SR_OUT_R pour le bit sortant
            SR_OUT_R <= A(0);
	        S(2 downto 0) <= A (3 downto 1);
            S(3) <= SR_IN_R;

        when "0010" => --S = Déc. gauche A sur 4 bits (avec SR_IN_R) | SR_IN_R pour le bit entrant et SR_OUT_L pour le bit sortant
            SR_OUT_L <= A(3);
            S(1 to 3) <= A (0 to 2);
            S(0) <= SR_IN_L; 
        
        when "0011" => --S = Déc. droite B sur 4 bits (avec SR_IN_L) | SR_IN_L pour le bit entrant et SR_OUT_R pour le bit sortant
            SR_OUT_L <= B (3);
            S(1 downto 3) <=B (0 downto 2);
            S(0) <= SR_IN_R; 
        
        when "0100" => --S = Déc. gauche B sur 4 bits (avec SR_IN_R) | SR_IN_R pour le bit entrant et SR_OUT_L pour le bit sortant
            SR_OUT_L <= B(3);
            S(1 to 3) <= B (0 to 2);
            S(0) <= SR_IN_L;

        when "0101" => --S = A | SR_OUT_L = 0 et SR_OUT_R = 0
            my_A (3 downto 0) <= A;
            my_A (7 downto 4) <= (others => A(3));
            S <= my_A;
            SR_OUT_R <= '0';
            SR_OUT_L <= '0';

        when "0110" => --S = B | SR_OUT_L = 0 et SR_OUT_R = 0
            my_B (3 downto 0) <= B;
            my_B (7 downto 4) <= (others => B(3));
            S <= my_B;
            SR_OUT_R <= '0';
            SR_OUT_L <= '0';

        when "0111" => --S = not A | SR_OUT_L = 0 et SR_OUT_R = 0
            my_A (3 downto 0) <= A;
            my_A (7 downto 4) <= (others => A(3));
            S <= not my_A;
            SR_OUT_R <= '0';
            SR_OUT_L <= '0';

        when "1000" => --S = not B | SR_OUT_L = 0 et SR_OUT_R = 0
            my_B (3 downto 0) <= B;
            my_B (7 downto 4) <= (others => B(3));
            S <= not my_B;
            SR_OUT_R <= '0';
            SR_OUT_L <= '0';

        when "1001" => --S = A and B | SR_OUT_L = 0 et SR_OUT_R = 0
            my_A (3 downto 0) <= A;
            my_B (3 downto 0) <= B;
            my_A (7 downto 4) <= (others => A(3));
            my_B (7 downto 4) <= (others => B(3));
            S <= my_A and my_B;
            SR_OUT_R <= '0';
            SR_OUT_L <= '0';

        when "1010" => --S = A or B | SR_OUT_L = 0 et SR_OUT_R = 0
            my_A (3 downto 0) <= A;
            my_B (3 downto 0) <= B;
            my_A (7 downto 4) <= (others => A(3));
            my_B (7 downto 4) <= (others => B(3));
            S <= my_A or my_B;
            SR_OUT_R <= '0';
            SR_OUT_L <= '0';

        when "1011" => --S = A xor B | SR_OUT_L = 0 et SR_OUT_R = 0
            my_A (3 downto 0) <= A;
            my_B (3 downto 0) <= B;
            my_A (7 downto 4) <= (others => A(3));
            my_B (7 downto 4) <= (others => B(3));
            S <= my_A xor my_B;
            SR_OUT_R <= '0';
            SR_OUT_L <= '0';

        when "1100" => --S = A + B addition binaire avec SR_IN_R comme retenue d’entrée
            my_A (3 downto 0) <= A;
            my_B (3 downto 0) <= B;
            my_A (7 downto 4) <= (others => A(3));
            my_B (7 downto 4) <= (others => B(3));
            S <= my_A + my_B + SR_IN_R;

        when "1101" => --S = A + B addition binaire sans retenue d’entrée
            my_A (3 downto 0) <= A;
            my_B (3 downto 0) <= B;
            my_A (7 downto 4) <= (others => A(3));
            my_B (7 downto 4) <= (others => B(3));
            S <= my_A + my_B;

        when "1101" => --S = A – B soustraction binaire
            my_A (3 downto 0) <= A;
            my_B (3 downto 0) <= B;
            my_A (7 downto 4) <= (others => A(3));
            my_B (7 downto 4) <= (others => B(3));
            S <= my_A - my_B;

        when "1101" => --S = A * B multiplication binaire à vérifier quand meme
            my_A (3 downto 0) <= A;
            my_B (3 downto 0) <= B;
            my_A (7 downto 4) <= (others => A(3));
            my_B (7 downto 4) <= (others => B(3));
            S <= my_A * my_B;

    end case

end Ual_DataFlow;