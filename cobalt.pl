#!/usr/bin/perl
#Cobalt Calibur
#          hp-   hp+   mp- mp+ ap- ap+ at  df  ac  ev  at  df  ac  ev  sp  name
@player = (1000, 1000, 20, 50, 10, 20, 50, 50, 90, 10, 50, 50, 90, 10, 20, "Thomas");
@enemy =  (1200, 1200, 50, 50, 10, 10, 50, 50, 90, 10, 50, 10, 90, 10, 20, "Enemy");
@inven = (2, 2, 2, 2, 2);                                          #sample inventory
@names = ("Jekeyl", "FeiSar", "Zidaxe", "Goteki", "Icarus"); #sample names
$enemy[15] = @names[ rand @names ];                           #name grabber
$lines = "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
$itpot = 100;
$ithpt = 200;
$itgr1 = 200;
$itgr2 = 20;
$itabi = 10;
$itmag = 15;
print "$lines \bCobalt Calibur\nCreated by Thomas Hunter\nnucleocide@!\byahoo.com\nVersion 0.5.0\n\nPress Enter...\n";
<STDIN>;

while ( $player[0] > 0 && $enemy[0] > 0 ) {
hpcheck();
print "$lines";
print "$player[15] HP: $player[0]/$player[1] MP: $player[2]/$player[3] AP: $player[4]/$player[5]\n";
print "$enemy[15] HP: $enemy[0]/$enemy[1] MP: $enemy[2]/$enemy[3] AP: $enemy[4]/$enemy[5]\n";
print "---CHOOSE---\n1) Attack\n2) Item\n3) Ability\n4) Magic\n5) Run\n6) Charge\n7) View Stats\n9) Exit\n";
$choice = <STDIN>; $choice += "\b";
if ($choice == 1) {       #fight
   if ($player[14] >= $enemy[14]) { platk(); enemai(); }    #player faster
   elsif ($player[14] <= $enemy[14]) { enemai(); platk(); } #enemy faster
} elsif ($choice == 2) {  #Item
   $asdf = 0;
   print "$lines";
   print "HP: $player[0]/$player[1] MP: $player[2]/$player[3] AP: $player[4]/$player[5]\n";
   print "Use an Item:\n";
   print "1) Potions   ($inven[0])\n";
   print "2) HiPotions ($inven[1])\n";
   print "3) Grenades  ($inven[2])\n";
   print "4) Ability   ($inven[3])\n";
   print "5) Magic     ($inven[4])\n";
   print "9) Quit\n";
   $choice = <STDIN>; $choice += "\b"; #get user choice, chop off \n
   if ($choice == 9) {$asdf = 1;}
   $choice -= 1;                       #array starts with 0

   if ($inven[$choice] >= 1) {
      $inven[$choice] -= 1;
      useitem($choice);
      hpcheck();
   } else {
      if ($asdf == 0) { print "Not enough of those items...\n"; <STDIN>; }
      $asdf = 1;
   }
   if ($asdf == 0){ enemai(); }
} elsif ($choice == 3) {  #Ability
    print "$lines \b---CHOOSE------($player[4]/$player[5]ap)\n1) Super Punch  (4ap)\n2) Upper Cut    (5ap)\n3) 1.5 Attack  (16ap)\n4) 1.5 Defense (16ap)\n5) 1.5 Agility (16ap)\n6) Restore HP  (10ap)\n9) Back\n";
    $choice = <STDIN>; $choice += "\b";
   if ($choice == 1 && $player[4] >= 4) {
        $damage = dam_mod(100,8);
        print "Super Punch does $damage damage to $enemy[15]...\n"; <STDIN>;
        $enemy[0] -= $damage;
        $player[4] -= 4;
        enemai();
   } elsif ($choice == 2 && $player[4] >= 5) {
       $damage = dam_mod(120,10);
       print "Upper Cut does $damage damage to $enemy[15]...\n"; <STDIN>;
       $enemy[0] -= $damage;
       $player[4] -= 5;
       enemai();
   } elsif ($choice == 3 && $player[4] >= 16) {
       print "Your attack has been increased...\n"; <STDIN>;
       $player[6] *= 1.5;
       $player[6] = int $player[2];
       $player[4] -= 16;
       enemai();
   } elsif ($choice == 4 && $player[4] >= 16) {
       print "Your defense has been increased...\n"; <STDIN>;
       $player[7] *= 1.5;
       $player[7] = int $player[3];
       $player[4] -= 16;
       enemai();
   } elsif ($choice == 5 && $player[4] >= 16) {
       print "Your speed has been increased...\n"; <STDIN>;
       $player[14] *= 1.5;
       $player[14] = int $player[4];
       $player[4] -= 16;
       enemai();
   } elsif ($choice == 6 && $player[4] >= 10) {
       print "Your HP has been restored...\n"; <STDIN>;
       $player[0] = $player[1];
       $player[4] -= 10;
       enemai();
   } elsif ($choice == 9) {
   } else {print "\aNot enough ap...\n"; <STDIN>;}

} elsif ($choice == 4) {  #Magic

    print "$lines \b---CHOOSE---($player[2]/$player[3]ap)\n1) Magic Missile (4mp)\n2) Sub Zer0      (7mp)\n3) Smite        (10mp)\n4) Demi         (25mp)\n5) Restore HP   (20mp)\n6) Restore AP   (20mp)\n9) Back\n";
    $choice = <STDIN>; $choice += "\b";
   if ($choice == 1 && $player[2] >= 4) {
        $damage = plmag(50);
        print "Magic Missile does $damage damage to $enemy[15]...\n"; <STDIN>;
        $enemy[0] -= $damage;
        $player[2] -= 4;
        enemai();
   } elsif ($choice == 2 && $player[2] >= 7) {
       $damage = plmag(80);
       print "Sub Zer0 does $damage damage to $enemy[15]...\n"; <STDIN>;
       $enemy[0] -= $damage;
       $player[2] -= 7;
       enemai();
   } elsif ($choice == 3 && $player[2] >= 10) {
       $damage = plmag(120);
       print "Smite does $damage to $enemy[15]...\n"; <STDIN>;
       $enemy[0] -= $damage;
       $player[2] -= 10;
       enemai();
   } elsif ($choice == 4 && $player[2] >= 25) {
       $damage = $enemy[0] / 4;
       $damage = int $damage;
       print "Demi does $damage to $enemy[15]...\n"; <STDIN>;
       $enemy[0] -= $damage;
       $player[2] -= 25;
       enemai();
   } elsif ($choice == 5 && $player[2] >= 20) {
       print "Your health has been restored...\n"; <STDIN>;
       $player[0] = $player[1];
       $player[2] -= 20;
       enemai();
   } elsif ($choice == 6 && $player[2] >= 20) {
       print "Your AP has been restored...\n"; <STDIN>;
       $player[4] = $player[5];
       $player[2] -= 20;
       enemai();
   } elsif ($choice == 9) {
   } else {print "\aNot enough MP...\n"; <STDIN>;}
} elsif ($choice == 5) {  #Run
   $odds = ( $player[14] * 50 * rand ) - ( $enemy[14] * 100 * rand ); #this needs to be fixed...
   if ($odds > 0) {print "You run away safely...\n"; <STDIN>; exit;}
   else {
    print "\aYou don't run away...\n"; <STDIN>;
    enemai();
    }


} elsif ($choice == 6) {  #Charge
    print "$lines \b---CHOOSE---\n1) Phys Attack up\n2) Phys Defense up\n3) Speed up\n4) AP up\n5) MP up\n9) Back\n";
    $choice = <STDIN>; $choice += "\b";
    if ($choice == 1) {$player[6] += 1; print "Attack Increased...\n"; <STDIN>; enemai();}
    elsif ($choice == 2) {$player[7] += 1; print "Defense Increased...\n"; <STDIN>; enemai();}
    elsif ($choice == 3) {$player[14] += 1; print "Speed Increased...\n"; <STDIN>; enemai();}
    elsif ($choice == 4) {$player[4] += 3; print "AP Increased...\n"; <STDIN>; enemai();}
    elsif ($choice == 5) {$player[2] += 4; print "MP Increased...\n"; <STDIN>; enemai();}
    elsif ($choice == 9) {}
    else {print "\aInvalid selection...\n";<STDIN>;}
} elsif ($choice == 7) {  #View Stats
   print "$lines";
   print "        ------Physical-----+-----Mental-----\n";
   print "        ATT DEF ACC EVA SPD| ATT DEF ACC EVA\n";
   print "$player[15]: $player[6]  $player[7]  $player[8]  $player[9]  $player[14] | $player[10]  $player[11]  $player[12]  $player[13]\n";
   print "$enemy[15]: $enemy[6]  $enemy[7]  $enemy[8]  $enemy[9]  $enemy[14] | $enemy[10]  $enemy[11]  $enemy[12]  $enemy[13]\n";
   print "\nPress Enter...\n"; <STDIN>;
} elsif ($choice == 9) {  #Exit Game
   print "You have decided to end the game.\n";
   exit;
} elsif ($choice == 99) {  #Cheat
   print "You cheater...\n"; <STDIN>;
   $player[1] += 200;
   $player[0] = $player[1];
}
}; #end main while

if ($player[0] <= 0 && $enemy[0] <= 0) { print "You both killed each other.\n"; }
elsif ($player[0] <= 0) { print "You were killed.\n"; }
elsif ($enemy[0] <= 0) { print "You were victorious.\n";}
else {print "Error computing winner.\n";}

sub platk { #Calculate enemy damage from player
   if ($player[0] > 0 && hit_ch(0,2)){
   $damage = dam_mod( 2 * $player[6] - $enemy[7], 10 );
   print "You do $damage damage...\n"; <STDIN>;
   $enemy[0] -= $damage;
   }
}
sub enatk { #Calculate player damage from enemy
   if ($enemy[0] > 0 && hit_ch(0,3)){
   $damage = dam_mod( 2 * $enemy[6] - $player[7], 10 );
   print "You recieve $damage damage...\n"; <STDIN>;
   $player[0] -= $damage;
   }
}
sub plmag { #Calculate enemy damage from player magic
   if ($player[0] > 0 && hit_ch(1,2)){
   my($damage) = @_[0];
   $damage += (2 * $player[10] - $enemy[11]); #THIS NEEDS TO CHANGE
   return($damage);
   }
}
sub dam_mod {
   my($d1) = @_[0]; #eg 500
   my($ch) = @_[1]; #eg 10%
   my($a) = ($ch * 2) + 1; #yes, add one
   my($b) = 100 - $ch;
   my($d2) = ((rand($a) + $b)/100);
   $d2 *= $d1;
   $d2 = int $d2; #round it off
   return($d2);
}
sub hpcheck { #makes sure that you don't go over your max, and keeps it an integer
   if ($player[0] > $player[1]) { $player[0] = $player[1]}
   if ($enemy[0] > $enemy[1]) { $enemy[0] = $enemy[1]}
   $player[0] = int $player[0];
   $enemy[0] = int $enemy[0];

   if ($player[2] > $player[3]) { $player[2] = $player[3]}
   if ($enemy[2] > $enemy[3]) { $enemy[2] = $enemy[3]}
   $player[2] = int $player[2];
   $enemy[2] = int $enemy[2];

   if ($player[4] > $player[5]) { $player[4] = $player[5]}
   if ($enemy[4] > $enemy[5]) { $enemy[4] = $enemy[5]}
   $player[4] = int $player[4];
   $enemy[4] = int $enemy[4];

}
sub enemai { #enemy decision
   my($a) = rand(100);
   if ($a < 10) {
      print "$enemy[15] uses a potion...\n"; <STDIN>;
      $enemy[0] += $itpot;
      hpcheck();
   } elsif ($a < 20) {
      print "$enemy[15] charges his attack...\n"; <STDIN>;
      $enemy[6] += 1;
   } elsif ($a < 30) {
      print "$enemy[15] charges his defense...\n"; <STDIN>;
      $enemy[6] += 1;
   } elsif ($a < 40) {
      print "$enemy[15] charges his speed...\n"; <STDIN>;
      $enemy[14] += 1;
   } elsif ($a < 45) {
      my($damage) = dam_mod($itgr1,$itgr2);
      $player[0] -= $damage;
      print "$enemy[15] uses a grenade ($damage)...\n"; <STDIN>;
   } else {
      enatk();
   }
}
sub useitem {
   my($choice) = @_[0];
   if ($choice == 0) {
   $player[0] += $itpot;
   hpcheck();
   print "HP increased by $itpot...\n"; <STDIN>;
   } elsif ($choice == 1) {
   $player[0] += $ithpt;
   hpcheck();
   print "HP increased by $ithpt...\n"; <STDIN>;
   } elsif ($choice == 2) {
   my($damage) = dam_mod($itgr1,$itgr2);
   $enemy[0] -= $damage;
   print "Your grenade does $damage damage...\n"; <STDIN>;
   } elsif ($choice == 3) {
   $player[4] += $itabi;
   hpcheck();
   print "AP increased by $itabi...\n"; <STDIN>;
   } elsif ($choice == 4) {
   $player[2] += $itmag;
   hpcheck();
   print "MP increased by $itmag...\n"; <STDIN>;
   } else {
   print "Item does not exist!\n"; <STDIN>;
   }
}
sub hit_ch { #hit chance
   my($type) = @_[0];
   my($orig) = @_[1];
   if($type == 0 && $orig == 2){
     $a = $player[8];
     $b = $enemy[9];
   } elsif ($type == 0 && $orig == 3){
     $a = $enemy[8];
     $b = $player[9];
   } elsif ($type == 1 && $orig == 2){
     $a = $player[12];
     $b = $enemy[13];
   } elsif ($type == 1 && $orig == 3){
     $a = $enemy[12];
     $b = $player[13];
   } else {print "/a HIT CHANCE ERROR!";}
   my($chance) = (100-(100-$a)*($b/$a+1)/2); #Just for kicks...
   if (rand(100) < $chance){return(1);}
   else {
      if ($orig == 2) {print "$player[15] misses $enemy[15]...\n";}
      elsif ($orig == 3) {print "$enemy[15] misses $player[15]...\n";}
   <STDIN>; return(0);}
}

#released under the GPL by nucleocide.net