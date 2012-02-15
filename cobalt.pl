#!/usr/bin/perl
#Cobalt Calibur

#          mnHP  mxHP  at  df  ag    name  points
@player = (1000, 1000, 60, 53, 50, "Thomas", 20);            #sample player stats
@enemy = (1400, 1400, 52, 55, 50, "error");                  #sample enemy stats
@inven = (2, 2, 2, 2);                                          #sample inventory
@names = ("Jekeyl", "FeiSar", "Zidaxe", "Goteki", "Icarus"); #sample names
$enemy[5] = @names[ rand @names ];                           #name grabber
$lines = "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
$itpot = 100;
$ithpt = 200;
$itgr1 = 200;
$itgr2 = 20;
$iteth = 10;
print "$lines \bCobalt Calibur\nCreated by Thomas Hunter\nnucleocide@!\byahoo.com\nVersion 0.3.6\n\nPress Enter...\n";
<STDIN>;

while ( $player[0] > 0 && $enemy[0] > 0 ) {
hpcheck();
print "$lines";
print "$player[5] HP: $player[0]/$player[1] AP: $player[6]\n";
print "$enemy[5] HP: $enemy[0]/$enemy[1]\n";
print "---CHOOSE---\n1) Attack\n2) Item\n3) Ability\n4) Run\n5) Charge\n6) View Stats\n9) Exit\n";
$choice = <STDIN>; $choice += "\b";
if ($choice == 1) {       #fight
   if ($player[4] >= $enemy[4]) { platk(); enemai(); }    #player faster
   elsif ($player[4] <= $enemy[4]) { enemai(); platk(); } #enemy faster
} elsif ($choice == 2) {  #Item
   $asdf = 0;
   print "$lines";
   print "Use an Item:\n";
   print "1) Potions   ($inven[0])\n";
   print "2) HiPotions ($inven[1])\n";
   print "3) Grenades  ($inven[2])\n";
   print "4) Ether     ($inven[3])\n";
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

} elsif ($choice == 4) {  #Run
   $odds = ( $player[4] * 50 * rand ) - ( $enemy[4] * 100 * rand ); #this needs to be fixed...
   if ($odds > 0) {print "You run away safely...\n"; <STDIN>; exit;}
   else {
    print "\aYou don't run away...\n"; <STDIN>;
    enemai();
    }

} elsif ($choice == 5) {  #Charge
    print "$lines \b---CHOOSE---\n1) Attack up\n2) Defense up\n3) Agility up\n4) AP up\n9) Back\n";
    $choice = <STDIN>; $choice += "\b";
    if ($choice == 1) {$player[2] += 1; print "Attack Increased...\n"; <STDIN>; enemai();}
    elsif ($choice == 2) {$player[3] += 1; print "Defense Increased...\n"; <STDIN>; enemai();}
    elsif ($choice == 3) {$player[4] += 1; print "Agility Increased...\n"; <STDIN>; enemai();}
    elsif ($choice == 4) {$player[6] += 3; print "AP Increased...\n"; <STDIN>; enemai();}
    elsif ($choice == 9) {}
    else {print "\aInvalid selection...\n";<STDIN>;}
} elsif ($choice == 3) {  #Ability
    print "$lines \b---CHOOSE------($player[6]ap)\n1) Super Punch  (4ap)\n2) Upper Cut    (5ap)\n3) 1.5 Attack  (16ap)\n4) 1.5 Defense (16ap)\n5) 1.5 Agility (16ap)\n6) Restore HP  (10ap)\n9) Back\n";
    $choice = <STDIN>; $choice += "\b";
   if ($choice == 1 && $player[6] >= 4) {
        $damage = dam_mod(100,8);
        print "Super Punch does $damage damage to $enemy[5]...\n"; <STDIN>;
        $enemy[0] -= $damage;
        $player[6] -= 4;
        enemai();
   } elsif ($choice == 2 && $player[6] >= 5) {
       $damage = dam_mod(120,10);
       print "Upper Cut does $damage damage to $enemy[5]...\n"; <STDIN>;
       $enemy[0] -= $damage;
       $player[6] -= 5;
       enemai();
   } elsif ($choice == 3 && $player[6] >= 16) {
       print "Your attack has been increased...\n"; <STDIN>;
       $player[2] *= 1.5;
       $player[2] = int $player[2];
       $player[6] -= 16;
       enemai();
   } elsif ($choice == 4 && $player[6] >= 16) {
       print "Your defense has been increased...\n"; <STDIN>;
       $player[3] *= 1.5;
       $player[3] = int $player[3];
       $player[6] -= 16;
       enemai();
   } elsif ($choice == 5 && $player[6] >= 16) {
       print "Your agility has been increased...\n"; <STDIN>;
       $player[4] *= 1.5;
       $player[4] = int $player[4];
       $player[6] -= 16;
       enemai();
   } elsif ($choice == 6 && $player[6] >= 10) {
       print "Your HP has been restored...\n"; <STDIN>;
       $player[0] = $player[1];
       $player[6] -= 10;
       enemai();
   } elsif ($choice == 9) {
   } else {print "\aNot enough ap...\n"; <STDIN>;}
} elsif ($choice == 6) {  #View Stats
   print "$lines";
   print "        AT DF AG\n";
   print "$player[5]: @player[2..4]\n";
   print "$enemy[5]: @enemy[2..4]\n";
   print "\nPress Enter...\n"; <STDIN>;
} elsif ($choice == 9) {  #Exit Game
   print "You have decided to end the game.\n";
   exit;
} elsif ($choice == 99) {  #Cheat
   print "You cheater...\n"; <STDIN>;
   $player[1] += 200;
   $player[0] = $player[1];
   $player[6] += 10;
   $inven[0] += 10;
   $inven[1] += 10;
   $inven[2] += 10;
}
}; #end main while

if ($player[0] <= 0 && $enemy[0] <= 0) { print "You both killed each other.\n"; }
elsif ($player[0] <= 0) { print "You were killed.\n"; }
elsif ($enemy[0] <= 0) { print "You were victorious.\n";}
else {print "Error computing winner.\n";}

sub platk { #Calculate enemy damage from player
   if ($player[0] > 0){
   $damage = dam_mod( 2 * $player[2] - $enemy[3], 10 );
   print "You do $damage damage...\n"; <STDIN>;
   $enemy[0] -= $damage;
   }
}
sub enatk { #Calculate player damage from enemy
   if ($enemy[0] > 0){
   $damage = dam_mod( 2 * $enemy[2] - $player[3], 10 );
   $phrase = phrase();
   print "$phrase";
   print "You recieve $damage damage...\n"; <STDIN>;
   $player[0] -= $damage;
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
}
sub enemai { #enemy decision
   my($a) = rand(100);
   if ($a < 10) {
      print "$enemy[5] uses a potion...\n"; <STDIN>;
      $enemy[0] += $itpot;
      hpcheck();
   } elsif ($a < 20) {
      print "$enemy[5] charges his attack...\n"; <STDIN>;
      $enemy[2] += 1;
   } elsif ($a < 30) {
      print "$enemy[5] charges his defense...\n"; <STDIN>;
      $enemy[3] += 1;
   } elsif ($a < 40) {
      print "$enemy[5] charges his Agility...\n"; <STDIN>;
      $enemy[4] += 1;
   } elsif ($a < 45) {
      $damage = dam_mod($itgr1,$itgr2);
      $player[0] -= $damage;
      print "$enemy[5] uses a grenade ($damage)...\n"; <STDIN>;
   } else {
      enatk();
   }
}
sub phrase { #phrases
   my(@phrase) = ("", "", "I will destroy you, $player[5]!\n", "You will die!\n", "See you in hell!\n");
   return(@phrase[ rand @phrase ]);
}
sub useitem {
   my($choice) = @_[0];
   if ($choice == 0) {
   $player[0] += $itpot;
   hpcheck();
   print "Your HP is now $player[0]...\n"; <STDIN>;
   } elsif ($choice == 1) {
   $player[0] += $ithpt;
   hpcheck();
   print "Your HP is now $player[0].\n"; <STDIN>;
   } elsif ($choice == 2) {
   $damage = dam_mod($itgr1,$itgr2);
   $enemy[0] -= $damage;
   print "Your grenade does $damage damage.\n"; <STDIN>;
   } elsif ($choice == 3) {
   $player[6] += $iteth;
   print "AP increased by $iteth.\n"; <STDIN>;
   } else {
   print "Item does not exist!\n"; <STDIN>;
   }
}

#released under the GPL by nucleocide.net