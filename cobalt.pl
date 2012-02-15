#!/usr/bin/perl
#Cobalt Calibur and Position
init(); #should include load option here
map_move();

sub init {
$x = 0; #horizontal
$y = 0; #vertical
$m = 0; #spaces moved
$play = 1; #continue playing
$mode = 0; #enemy retaliation
#            0    1     2   3   4   5   6   7   8   9  10  11  12  13  14    15    16
#          hp-   hp+   mp- mp+ ap- ap+ at  df  ac  ev  at  df  ac  ev  sp    name regen
@player = (1000, 1000, 40, 50, 20, 25, 50, 50, 70, 10, 50, 50, 90, 10, 20, "Thomas", 0);
$money = 200;
$lines = "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"; #how else do you clear the screen?
$itpot = 100; $ithpt = 200; $itgr1 = 200; $itgr2 = 20; $itabi = 10; $itmag = 15; #item values
@inven = (4, 3, 3, 2, 2); #inventory
print "$lines \bCobalt Calibur\nCreated by Thomas Hunter\nnucleocide@!\byahoo.com\nVersion 1.2.2\n\nPress Enter...\n";
<STDIN>;
}

sub map_move {
 while ($play == 1) {
  @enemy = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "Nobody", 0);
  print "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
  print "$player[15] HP: $player[0]/$player[1] MP: $player[2]/$player[3] AP: $player[4]/$player[5]\n";
  print "Funds: $money\n";
  print "--Location--\n";
  print "X:$x Y:$y M: $m\n";
  print "--Choices---\n";
  print "01) - 09 Move\n10) Item\n11) Ability\n12) Magic\n13) View Stats\n14) Exit Game\n";
  print "?:";
  $choice = <STDIN>;
  if    ($choice == 1 and $y > -10 and $x > -10) { $y -= 1; $x -= 1; }
  elsif ($choice == 0) { }
  elsif ($choice == 2 and $y > -10) { $y -= 1; }
  elsif ($choice == 3 and $y > -10 and $x < 10) { $y -= 1; $x += 1; }
  elsif ($choice == 4 and $x > -10) { $x -= 1; }
  elsif ($choice == 5) { }
  elsif ($choice == 6 and $x < 10) { $x += 1; }
  elsif ($choice == 7 and $x > -10 and $y < 10 ) { $x -= 1; $y += 1; }
  elsif ($choice == 8 and $y < 10 ) { $y += 1; }
  elsif ($choice == 9 and $x < 10 and  $y < 10 ) { $x += 1; $y += 1; }
  elsif ($choice == 10) { $mode = 1; item(); $mode = 0; }
  elsif ($choice == 11) { $mode = 1; ability(); $mode = 0; }
  elsif ($choice == 12) { $mode = 1; magic(); $mode = 0; }
  elsif ($choice == 13) { $mode = 1; view_self_stats(); $mode = 0; }
  elsif ($choice == 14) { $mode = 1; user_quit(); $play = 0; }
  else { }
  $m++;
  regen();
  hpcheck();
  check_local();
  check_enemy(rand(100));
 }
user_quit();
}

sub check_local {
  if ($x == 4 and $y == 2) {
   print "You are at the town..."; <STDIN>;
   shop();
  } elsif ($x == 0 and $y == 0) {
   print "You are at your house and you rest..."; <STDIN>;
   $player[0] += 200; $player[2] += 2; $player[4] += 1; hpcheck();
  } elsif ($x == -2 and $y == 3) {
   print "You are at the temple..."; <STDIN>;
  } elsif ($x == -10 or $x == 10 or $y == -10 or $y == 10) {
   print "You are drowning in the water..."; <STDIN>;
   $player[0] -= dam_mod(100,10);
   if (! chk_pl_dth()) { print "$lines \bYou drown.\n"; exit; }
  }
}

sub check_enemy {
  if (@_[0] > 90) { print "$lines \bAmbushed!\n"; <STDIN>; pre_combat(); } #10% chance
}

sub pre_combat {
$enemy[1] = (int rand(400) + 1600);
$enemy[0] = $enemy[1];
$enemy[3] = (int rand(20) + 30);
$enemy[2] = $enemy[3];
$enemy[5] = (int rand(10) + 10);
$enemy[4] = $enemy[5];
$enemy[6] = (int rand(20) + 40);
$enemy[7] = (int rand(20) + 40);
$enemy[8] = (int rand(20) + 70);
$enemy[9] = (int rand(10) + 5);
$enemy[10] = (int rand(20) + 40);
$enemy[11] = (int rand(20) + 40);
$enemy[12] = (int rand(20) + 70);
$enemy[13] = (int rand(10) + 5);
$enemy[14] = (int rand(4) + 18);
@names = ("Jekeyl", "FeiSar", "Zidaxe", "Goteki", "Icarus"); #sample names
$enemy[15] = @names[ rand @names ];                          #name grabber
$endbattle = 0;
if (combat() != 29) {
my($spoils) = mrand(100,200);
print "You win $spoils cash...\n"; <STDIN>;
$money += $spoils;
 }
}

sub combat {
while ( $endbattle != 1 ) {
hpcheck();
print "$lines";
print "$player[15] HP: $player[0]/$player[1] MP: $player[2]/$player[3] AP: $player[4]/$player[5]\n";
print "$enemy[15] HP: $enemy[0]\n";
print "---CHOOSE---\n1) Attack\n2) Item\n3) Ability\n4) Magic\n5) Run\n6) Charge\n7) View Stats\n";
$choice = <STDIN>; $choice += "\b";
if ($choice == 1) {       #fight
   fight();
} elsif ($choice == 2) {  #Item
   item();
} elsif ($choice == 3) {  #Ability
   ability();
} elsif ($choice == 4) {  #Magic
   magic();
} elsif ($choice == 5) {  #Run
   $odds = ( $player[14] * 50 * rand ) - ( $enemy[14] * 100 * rand ); #this needs to be fixed...
   if ($odds > 0) {print "You run away safely...\n"; <STDIN>; $endbattle = 1; return(29);}
   else {
    print "\aYou don't run away...\n"; <STDIN>;
    enemai();
    }
} elsif ($choice == 6) {  #Charge
   charge();
} elsif ($choice == 7) {  #View self stats
   view_self_stats();
} elsif ($choice == 96) {  #debug
   debug4();
} elsif ($choice == 97) {  #Debug
   debug1();
} elsif ($choice == 98) {  #Debug
   debug2();
} elsif ($choice == 99) {  #Debug
   debug3();
}
if ($player[0] <= 0 or $enemy[0] <= 0) { finish(); }
}
}

sub chk_pl_dth {
if ($player[0] < 1) { return(0); } #dead
if ($player[0] > 0) { return(1); } #alive
}

sub finish {
if ($player[0] <= 0 && $enemy[0] <= 0) { print "You both killed each other.\n"; exit; }
elsif ($player[0] <= 0) { print "You were killed.\n"; exit;}
elsif ($enemy[0] <= 0) { print "You were victorious.\n";}
else {print "Error computing winner.\n";}
if ($cheat == 1) {print "You have used at least one DEBUG code.\n"; }
$endbattle = 1;
}

sub platk { #Calculate enemy damage from player
   if ($player[0] > 0 && hit_ch(0,2)){ #make sure your alive
   $damage = dam_mod( 2 * $player[6] - $enemy[7], 10 );
   print "You do $damage damage...\n"; <STDIN>;
   $enemy[0] -= $damage;
   }
}
sub enatk { #Calculate player damage from enemy
   if ($enemy[0] > 0 && hit_ch(0,3)){ #make sure enemy is alive
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
sub enmag { #Calculate player damage from enemy magic
   if ($enemy[0] > 0 && hit_ch(1,3)){
   my($damage) = @_[0];
   $damage += (2 * $enemy[10] - $player[11]); #THIS NEEDS TO CHANGE
   return($damage);
   }
}
sub dam_mod {
   my($d1) = @_[0]; #eg 50
   my($ch) = @_[1]; #eg 10%
   my($a) = ($ch * 2) + 1;
   my($b) = 100 - $ch;
   my($d2) = ((rand($a) + $b)/100);
   $d2 *= $d1;
   $d2 = int $d2;
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
   if ($mode == 0) {
   my($a) = rand(100);
   if ($a < 9) {
      print "$enemy[15] uses a potion...\n"; <STDIN>;
      $enemy[0] += $itpot;
      hpcheck();
   } elsif ($a < 16) {
      my($damage) = dam_mod($itgr1,$itgr2);
      $player[0] -= $damage;
      print "$enemy[15] uses a grenade ($damage)...\n"; <STDIN>;
   } elsif ($a < 24) {
      $enemy[2] += $itmag;
      print "$enemy[15] uses item magic...\n"; <STDIN>;
   } elsif ($a < 32) {
      $enemy[4] += $itabi;
      print "$enemy[15] uses item ability...\n"; <STDIN>;
   } elsif ($a < 38) {
      print "$enemy[15] charges his attack...\n"; <STDIN>;
      $enemy[6] += 1;
   } elsif ($a < 44) {
      print "$enemy[15] charges his defense...\n"; <STDIN>;
      $enemy[6] += 1;
   } elsif ($a < 50) {
      print "$enemy[15] charges his speed...\n"; <STDIN>;
      $enemy[14] += 1;
   } elsif ($a < 55 and $enemy[2] >= 9) {
      my($damage) = enmag(100);
      $player[0] -= $damage;
      $enemy[2] -= 9;
      print "$enemy[15] uses magic Degrade ($damage)...\n"; <STDIN>;
   } elsif ($a < 60 and $enemy[2] >= 12) {
      my($damage) = enmag(140);
      $player[0] -= $damage;
      $enemy[2] -= 12;
      print "$enemy[15] uses magic Decay ($damage)...\n"; <STDIN>;
   } elsif ($a < 65 and $enemy[2] >= 25) {
      my($damage) = $player[0] / 4;
      my($damage) = int $damage;
      $player[0] -= $damage;
      $enemy[2] -= 25;
      print "$enemy[15] uses magic Demi ($damage)...\n"; <STDIN>;
   } elsif ($a < 70 and $enemy[2] >= 20) {
      $enemy[4] = $enemy[5];
      $enemy[2] -= 20;
      print "$enemy[15] uses magic Restores AP...\n"; <STDIN>;
   } else {
      enatk();
   }
   }
regen(); #regenerate after enemy attack
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
   $asdf = 1;
   }
}
sub hit_ch { #hit chance
   my($type) = @_[0];
   my($orig) = @_[1];
   if($type == 0 && $orig == 2){ #player physical
     $a = $player[8];
     $b = $enemy[9];
   } elsif ($type == 0 && $orig == 3){ #player magical
     $a = $enemy[8];
     $b = $player[9];
   } elsif ($type == 1 && $orig == 2){ #enemy physical
     $a = $player[12];
     $b = $enemy[13];
   } elsif ($type == 1 && $orig == 3){ #enemy magical
     $a = $enemy[12];
     $b = $player[13];
   } else {print "\aHIT CHANCE ERROR!\n";} #should only occur if programmer makes a typo
   my($chance) = (100-(100-$a)*($b/$a+1)/2); #Just for kicks... should be changed
   if (rand(100) < $chance){return(1);}
   else {
      if ($orig == 2 and $type == 0) {print "$player[15] misses $enemy[15] with physical...\n";}
      elsif ($orig == 2 and $type == 1) {print "$player[15] misses $enemy[15] with magical...\n";}
      elsif ($orig == 3 and $type == 0) {print "$enemy[15] misses $player[15] with physical...\n";}
      elsif ($orig == 3 and $type == 1) {print "$enemy[15] misses $player[15] with magical...\n";}
   <STDIN>; return(0);}
}
sub regen { #regenerate
   my($regen) = $player[16];
   $player[0] += $regen;           #hp 100%
   $player[2] += int ($regen / 2); #mp 50%
   $player[4] += int ($regen / 3); #ap 33%
}

sub user_quit {
 print "$lines";
 print "You have decided to end the game.\n";
 exit
}

sub fight {
   if ($player[14] >= $enemy[14]) { platk(); enemai(); }    #player faster
   elsif ($player[14] <= $enemy[14]) { enemai(); platk(); } #enemy faster
}

sub item {
   $asdf = 0; #this variable is used to make sure that the enemy attacks only if an item is used
   print "$lines";
   print "HP: $player[0]/$player[1] MP: $player[2]/$player[3] AP: $player[4]/$player[5]\n";
   print "Use an Item:\n";
   print "1) Potions   ($inven[0])\n";
   print "2) HiPotions ($inven[1])\n";
   print "3) Grenades  ($inven[2])\n";
   print "4) Ability   ($inven[3])\n";
   print "5) Magic     ($inven[4])\n";
   print "9) Quit\n";
   $choice = <STDIN>; $choice += "\b"; $choice = int $choice; #get user choice, chop off \n
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
}

sub ability {
    print "$lines \b---CHOOSE---($player[4]/$player[5]ap)\n1) Super Punch  (4ap)\n2) Upper Cut    (5ap)\n3) +10% Attack ($player[5] \bap)\n4) +10% Defense($player[5] \bap)\n5) +10% Speed  ($player[5] \bap)\n6) Restore HP  (10ap)\n7) Scan Enemy   (2ap)\n8) Regen ($player[16])   (20ap)\n9) Back\n";
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
   } elsif ($choice == 3 && $player[4] >= $player[5]) {
       print "Your attack has been increased...\n"; <STDIN>;
       $player[6] *= 1.1;
       $player[6] = int $player[6];
       $player[4] -= $player[5];
       enemai();
   } elsif ($choice == 4 && $player[4] >= $player[5]) {
       print "Your defense has been increased...\n"; <STDIN>;
       $player[7] *= 1.1;
       $player[7] = int $player[7];
       $player[4] -= $player[5];
       enemai();
   } elsif ($choice == 5 && $player[4] >= $player[5]) {
       print "Your speed has been increased...\n"; <STDIN>;
       $player[14] *= 1.1;
       $player[14] = int $player[14];
       $player[4] -= $player[5];
       enemai();
   } elsif ($choice == 6 && $player[4] >= 10) {
       print "Your HP has been restored...\n"; <STDIN>;
       $player[0] = $player[1];
       $player[4] -= 10;
       enemai();
   } elsif ($choice == 7 && $player[4] >= 2) {
       print "$lines";
       print "$enemy[15] Stats\n";
       print "HP: $enemy[0]/$enemy[1] MP: $enemy[2]/$enemy[3] AP: $enemy[4]/$enemy[5]\n";
       print "------Physical-----+-----Mental-----\n";
       print "ATT DEF ACC EVA SPD| ATT DEF ACC EVA\n";
       print "$enemy[6]  $enemy[7]  $enemy[8]  $enemy[9]  $enemy[14] | $enemy[10]  $enemy[11]  $enemy[12]  $enemy[13]\n";
       print "\nPress Enter...\n"; <STDIN>;
       $player[4] -= 2;
       enemai();
   } elsif ($choice == 8 && $player[4] >= 20) {
       $player[16] += 1;
       print "Regeneration increased to $player[16]...\n"; <STDIN>;
       $player[4] -= 20;
       enemai();
   } elsif ($choice == 9) {
   } else {print "\aNot enough ap...\n"; <STDIN>;}
}

sub magic {
    print "$lines \b---CHOOSE----($player[2]/$player[3]mp)\n1) Magic Missile (4mp)\n2) Sub Zer0      (7mp)\n3) Smite        (10mp)\n4) Demi         (25mp)\n5) Restore HP   (20mp)\n6) Restore AP   (20mp)\n9) Back\n";
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
}

sub charge {
    print "$lines \b---CHOOSE---\n1) Phys Attack up\n2) Phys Defense up\n3) Speed up\n4) AP up\n5) MP up\n9) Back\n";
    $choice = <STDIN>; $choice += "\b";
    if ($choice == 1) {$player[6] += 1; print "Attack Increased...\n"; <STDIN>; enemai();}
    elsif ($choice == 2) {$player[7] += 1; print "Defense Increased...\n"; <STDIN>; enemai();}
    elsif ($choice == 3) {$player[14] += 1; print "Speed Increased...\n"; <STDIN>; enemai();}
    elsif ($choice == 4) {$player[4] += 3; print "AP Increased...\n"; <STDIN>; enemai();}
    elsif ($choice == 5) {$player[2] += 4; print "MP Increased...\n"; <STDIN>; enemai();}
    elsif ($choice == 9) {}
    else {print "\aInvalid selection...\n";<STDIN>;}
}

sub view_self_stats {
   print "$lines";
   print "$player[15] Stats\n";
   print "HP: $player[0]/$player[1] MP: $player[2]/$player[3] AP: $player[4]/$player[5]\n";
   print "------Physical-----+-----Mental-----\n";
   print "ATT DEF ACC EVA SPD| ATT DEF ACC EVA\n";
   print "$player[6]  $player[7]  $player[8]  $player[9]  $player[14] | $player[10]  $player[11]  $player[12]  $player[13]\n";
   print "\nPress Enter...\n"; <STDIN>;
}

sub shop {
   print "$lines";
   print "Welcome to the shop\nYou have $money cash.\n";
   print "---BUY------#--cc---SELL---\n";
   print "1) Potion  ($inven[0])(10c) (06) (5c)\n2) HiPotion($inven[1])(30c) (07) (15c)\n3) Grenade ($inven[2])(75c) (08) (40c)\n4) Magic   ($inven[3])(50c) (09) (25c)\n5) Agility ($inven[4])(50c) (10) (25c)\n99) Leave\n";
   $choice = <STDIN>;
   if ($choice == 1 and $money >= 10) {
   $inven[0] += 1;
   $money -= 10;
   print "You now have $inven[0] Potions...\n"; <STDIN>;
   } elsif ($choice == 2 and $money >= 30) {
   $inven[1] += 1;
   $money -= 30;
   print "You now have $inven[1] HiPotions...\n"; <STDIN>;
   } elsif ($choice == 3 and $money >= 75) {
   $inven[2] += 1;
   $money -= 75;
   print "You now have $inven[2] Grenades...\n"; <STDIN>;
   } elsif ($choice == 4 and $money >= 50) {
   $inven[3] += 1;
   $money -= 50;
   print "You now have $inven[3] Magics...\n"; <STDIN>;
   } elsif ($choice == 5 and $money >= 50) {
   $inven[4] += 1;
   $money -= 50;
   print "You now have $inven[4] Abilities...\n"; <STDIN>;
   } elsif ($choice == 6 and $inven[0] >= 1) {
   $inven[0] -= 1;
   $money += 5;
   print "You now have $inven[0] Potions...\n"; <STDIN>;
   } elsif ($choice == 7 and $inven[1] >= 1) {
   $inven[1] -= 1;
   $money += 15;
   print "You now have $inven[1] HiPotions...\n"; <STDIN>;
   } elsif ($choice == 8 and $inven[2] >= 1) {
   $inven[2] -= 1;
   $money += 40;
   print "You now have $inven[2] Grenades...\n"; <STDIN>;
   } elsif ($choice == 9 and $inven[3] >= 1) {
   $inven[3] -= 1;
   $money += 50;
   print "You now have $inven[3] Magics...\n"; <STDIN>;
   } elsif ($choice == 10 and $inven[4] >= 1) {
   $inven[4] -= 1;
   $money += 50;
   print "You now have $inven[4] Abilities...\n"; <STDIN>;
   }
}

sub mrand { #min, max
  my($min) = $_[0];
  my($max) = $_[1];
  my($val) = int rand(($max - $min) + 1) + $min;
  return($val);
}

sub debug1 {
   print "DEBUG: display variables\n";
   print "Player stats: @player[0 .. 16]\n";
   print "Enemy stats : @enemy[0 .. 15]\n";
   print "Variable Scopes: a: $a b: $b c: $c asdf: $asdf damage: $damage regen: $regen orig: $orig type: $type cheat: $cheat\n";
   print "Potions   ($inven[0])$itpot\nHiPotions ($inven[1])$ithpt\nGrenades  ($inven[2])$itgr1 $itgr2\nAbility   ($inven[3])$itabi\nMagic     ($inven[4])$itmag\n";
   print "press enter..."; <STDIN>;
   $cheat = 1;
}

sub debug2 {
   print "DEBUG: increase all enemy min/max points...\n"; <STDIN>;
   $enemy[1] += 200;
   $enemy[0] = $enemy[1];
   $enemy[3] += 30;
   $enemy[2] = $enemy[3];
   $enemy[5] += 15;
   $enemy[4] = $enemy[5];
   $cheat = 1;
}

sub debug3 {
   print "DEBUG: increase all self min/max points...\n"; <STDIN>;
   $player[1] += 200;
   $player[0] = $player[1];
   $player[3] += 30;
   $player[2] = $player[3];
   $player[5] += 15;
   $player[4] = $player[5];
   $cheat = 1;
}
#            0    1     2   3   4   5   6   7   8   9  10  11  12  13  14    15    16
#          hp-   hp+   mp- mp+ ap- ap+ at  df  ac  ev  at  df  ac  ev  sp    name regen

sub debug4 {
   print "DEBUG: manually modify variables...\n"; <STDIN>;
   print "\nplayer[0]hpa:"; $player[0] = <STDIN>;
   print "\nplayer[1]hpb:"; $player[1] = <STDIN>;
   print "\nplayer[2]mpa:"; $player[2] = <STDIN>;
   print "\nplayer[3]mpb:"; $player[3] = <STDIN>;
   print "\nplayer[4]apa:"; $player[4] = <STDIN>;
   print "\nplayer[5]apb:"; $player[5] = <STDIN>;
   print "\nplayer[6]pat:"; $player[6] = <STDIN>;
   print "\nplayer[7]pde:"; $player[7] = <STDIN>;
   print "\nplayer[8]pac:"; $player[8] = <STDIN>;
   print "\nplayer[9]pev:"; $player[9] = <STDIN>;
   print "\nplayer[10]mat:"; $player[10] = <STDIN>;
   print "\nplayer[11]mde:"; $player[11] = <STDIN>;
   print "\nplayer[12]mac:"; $player[12] = <STDIN>;
   print "\nplayer[13]mev:"; $player[13] = <STDIN>;
   print "\nplayer[14]spd:"; $player[14] = <STDIN>;
   print "\nplayer[15]nam:"; $player[15] = <STDIN>;
   print "\nplayer[16]rgn:"; $player[16] = <STDIN>;
   print "\nX:"; $x = <STDIN>;
   print "\nY:"; $y = <STDIN>;
   print "\nM:"; $m = <STDIN>;
   print "\nMoney:"; $money = <STDIN>;
   print "\nitpot:"; $itpot = <STDIN>;
   print "\nithpt:"; $ithpt = <STDIN>;
   print "\nitgr1:"; $itgr1 = <STDIN>;
   print "\nitgr2:"; $itgr2 = <STDIN>;
   print "\nitabi:"; $itabi = <STDIN>;
   print "\nitmag:"; $itmag = <STDIN>;
   print "\ninven[0]:"; $inven[0] = <STDIN>;
   print "\ninven[1]:"; $inven[1] = <STDIN>;
   print "\ninven[2]:"; $inven[2] = <STDIN>;
   print "\ninven[3]:"; $inven[3] = <STDIN>;
   print "\ninven[4]:"; $inven[4] = <STDIN>;
}

#released under the GPL by nucleocide.net