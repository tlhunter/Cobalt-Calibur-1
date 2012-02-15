#!/usr/bin/perl
#Cobalt Calibur and Map Engine
#August 28, 2004
clear();
print "Cobalt Calibur\nCreated by Thomas Hunter\nnucleocide@!\byahoo.com \nVersion 2.0.1\n\nPress Enter...\n";
<STDIN>;
initiate_player();
initiate_map();
walk_mode();

sub initiate_player {
$play = 1; #continue playing
$mode = 0; #enemy retaliation
$money = 200;
$itpot = 100; $ithpt = 200; $itgr1 = 200; $itgr2 = 20; $itabi = 10; $itmag = 15; #item values
@inven = (4, 3, 3, 2, 2); #inventory
while ($play == 1) {
clear();
print "Pick a character type to be:\n";
print "1) Normal\n2) Warrior\n3) Cleric\n4) Mage \n5) Healer\n6) Monk\n";
  $choice = <STDIN>;
  if    ($choice == 1) { #normal
 %player = ('name' => "Thomas",
            'hpmin' => 1000,
	    'hpmax' => 1000,
	    'mpmin' => 50,
	    'mpmax' => 50,
	    'apmin' => 25,
	    'apmax' => 25,
	    'patt' => 50,
	    'pdef' => 50,
	    'pacc' => 70,
	    'peva' => 10,
	    'matt' => 50,
	    'mdef' => 50,
	    'macc' => 90,
	    'meva' => 10,
	    'speed' => 20,
	    'regen' => 0);
$play = 0; 
} elsif ($choice == 2) { #Warrior
 %player = ('name' => "Hunter",
            'hpmin' => 1200,
	    'hpmax' => 1200,
	    'mpmin' => 0,
	    'mpmax' => 0,
	    'apmin' => 25,
	    'apmax' => 25,
	    'patt' => 70,
	    'pdef' => 70,
	    'pacc' => 95,
	    'peva' => 10,
	    'matt' => 0,
	    'mdef' => 0,
	    'macc' => 0,
	    'meva' => 5,
	    'speed' => 20,
	    'regen' => 0);
$play = 0;
 } elsif ($choice == 3) { #Cleric
 %player = ('name' => "Goryla",
            'hpmin' => 1300,
	    'hpmax' => 1300,
	    'mpmin' => 70,
	    'mpmax' => 70,
	    'apmin' => 25,
	    'apmax' => 25,
	    'patt' => 30,
	    'pdef' => 80,
	    'pacc' => 75,
	    'peva' => 10,
	    'matt' => 65,
	    'mdef' => 75,
	    'macc' => 95,
	    'meva' => 15,
	    'speed' => 20,
	    'regen' => 1);
$play = 0;
} elsif ($choice == 4) { #Mage
 %player = ('name' => "Cobalt",
            'hpmin' => 900,
	    'hpmax' => 900,
	    'mpmin' => 100,
	    'mpmax' => 100,
	    'apmin' => 30,
	    'apmax' => 30,
	    'patt' => 20,
	    'pdef' => 60,
	    'pacc' => 55,
	    'peva' => 10,
	    'matt' => 75,
	    'mdef' => 80,
	    'macc' => 95,
	    'meva' => 20,
	    'speed' => 20,
	    'regen' => 0);
$play = 0;
} elsif ($choice == 5) { #Healer
 %player = ('name' => "Corbra",
            'hpmin' => 1500,
	    'hpmax' => 1500,
	    'mpmin' => 100,
	    'mpmax' => 100,
	    'apmin' => 30,
	    'apmax' => 30,
	    'patt' => 20,
	    'pdef' => 60,
	    'pacc' => 55,
	    'peva' => 10,
	    'matt' => 40,
	    'mdef' => 95,
	    'macc' => 95,
	    'meva' => 20,
	    'speed' => 20,
	    'regen' => 2);
$play = 0;
 } elsif ($choice == 6) { #Monk
 %player = ('name' => "Necroa",
            'hpmin' => 1500,
	    'hpmax' => 1500,
	    'mpmin' => 30,
	    'mpmax' => 30,
	    'apmin' => 80,
	    'apmax' => 80,
	    'patt' => 50,
	    'pdef' => 50,
	    'pacc' => 50,
	    'peva' => 10,
	    'matt' => 50,
	    'mdef' => 50,
	    'macc' => 50,
	    'meva' => 10,
	    'speed' => 20,
	    'regen' => 0);

$play = 0; }
  else { $play = 1}
$player{'x'} = 38;
$player{'y'} = 7;
}
$play = 1;
}

sub walk_mode {
 while ($play == 1) {# In case player tries to use an offense magic...
 %enemy = ('name' => "Nobody",
            'hpmin' => 0,
	    'hpmax' => 0,
	    'mpmin' => 0,
	    'mpmax' => 0,
	    'apmin' => 0,
	    'apmax' => 0,
	    'patt' => 0,
	    'pdef' => 0,
	    'pacc' => 0,
	    'peva' => 0,
	    'matt' => 0,
	    'mdef' => 0,
	    'macc' => 0,
	    'meva' => 0,
	    'speed' => 0,
	    'regen' => 0);
  clear();
if ($map[$player{'x'}][$player{'y'}] == 3 ) { print "DROWNING!\a\n"; $player{'hpmin'} -= mrand(40,60); if (! chk_pl_dth()) { clear(); print "You Drowned..."; <STDIN>;} };
  print "$player{'name'} HP: $player{'hpmin'}/$player{'hpmax'} MP: $player{'mpmin'}/$player{'mpmax'} AP: $player{'apmin'}/$player{'apmax'}\n";
  print "Funds: $money\n";
  print_map();
  print "--Choices---\n";
  print "789      |5)Action    10)Item\n";
  print "4 6 Move |13)View Stats 14) Exit\n";
  print "123      |11)Ability  12)Magic\n";
  print "?:";
 $action = <STDIN>;
 clear();
 if ($action == 1 && ($map[$player{'x'}-1][$player{'y'}+1] != 1)) {
 $player{'x'} -= 1;
 $player{'y'} += 1;
 } elsif ($action == 2 && ($map[$player{'x'}][$player{'y'}+1] != 1)) {
 $player{'y'} += 1;
 } elsif ($action == 3 && ($map[$player{'x'}+1][$player{'y'}+1] != 1)) {
 $player{'x'} += 1;
 $player{'y'} += 1;
 } elsif ($action == 4 && ($map[$player{'x'}-1][$player{'y'}] != 1)) {
 $player{'x'} -= 1;
 } elsif ($action == 5 && ($map[$player{'x'}][$player{'y'}] != 1)) {
  if ($map[$player{'x'}][$player{'y'}] == 2 ) {
   $map[$player{'x'}][$player{'y'}] = 0;
   $inven[0] += 1;
  } elsif ($map[$player{'x'}][$player{'y'}] == 4 ) {
   shop(); } elsif ($map[$player{'x'}][$player{'y'}] == 5 ) {
   traincent(); }
 } elsif ($action == 6 && ($map[$player{'x'}+1][$player{'y'}] != 1)) {
 $player{'x'} += 1;
 } elsif ($action == 7 && ($map[$player{'x'}-1][$player{'y'}-1] != 1)) {
 $player{'x'} -= 1;
 $player{'y'} -= 1;
 } elsif ($action == 8 && ($map[$player{'x'}][$player{'y'}-1] != 1)) {
 $player{'y'} -= 1;
 } elsif ($action == 9 && ($map[$player{'x'}+1][$player{'y'}-1] != 1)) {
 $player{'x'} += 1;
 $player{'y'} -= 1;
 }
  elsif ($action == 10) { $mode = 1; item(); $mode = 0; }
  elsif ($action == 11) { $mode = 1; ability(); $mode = 0; }
  elsif ($action == 12) { $mode = 1; magic(); $mode = 0; }
  elsif ($action == 13) { $mode = 1; view_self_stats(); $mode = 0; }
  elsif ($action == 14) { $mode = 1; user_quit(); $play = 0; }
  elsif ($action == 96) { debug1(); }
  elsif ($action == 97) { debug2(); }
  elsif ($action == 98) { debug3(); }
  elsif ($action == 99) { debug4(); }
  else { }
  regen();
  hpcheck();
  check_enemy(rand(300)); #randomly fight enemy, number in () represents chances
 }
user_quit();
}

sub check_enemy {
clear();
  if (@_[0] < 10) { print "Ambushed!\n"; <STDIN>; pre_combat(); } #% chance
}

sub pre_combat {
@names = ("Jekeyl", "FeiSar", "Zidaxe", "Goteki", "Icarus");
 my($hps) = (int rand(400) + 1600);
 my($mps) = (int rand(20) + 30);
 my($aps) = (int rand(10) + 10);
 %enemy = ('name' => @names[ rand @names ],
            'hpmin' => $hps,
	    'hpmax' => $hps,
	    'mpmin' => $mps,
	    'mpmax' => $mps,
	    'apmin' => $aps,
	    'apmax' => $aps,
	    'patt' => (int rand(20) + 40),
	    'pdef' => (int rand(20) + 40),
	    'pacc' => (int rand(20) + 70),
	    'peva' => (int rand(10) + 5),
	    'matt' => (int rand(20) + 40),
	    'mdef' => (int rand(20) + 40),
	    'macc' => (int rand(20) + 70),
	    'meva' => (int rand(10) + 5),
	    'speed' => (int rand(4) + 18),
	    'regen' => 0,
	    'x' => 1,
	    'y' => 1);

$endbattle = 0;
if (combat() != 29) {
my($spoils) = mrand(550,650);
print "You win $spoils cash...\n"; <STDIN>;
$money += $spoils;
 }
}

sub combat {
while ( $endbattle != 1 ) {
hpcheck();
clear();
print "$player{'name'} HP: $player{'hpmin'}/$player{'hpmax'} MP: $player{'mpmin'}/$player{'mpmax'} AP: $player{'apmin'}/$player{'apmax'}\n";
print "$enemy{'name'} HP: $enemy{'hpmin'}\n";
print "---CHOOSE---\n1) Attack\n2) Item \n3) Ability \n4) Magic\n5) Run\n6) Charge\n7) View Stats\n";
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
   $odds = ( $player{'speed'} * 50 * rand ) - ( $enemy{'speed'} * 100 * rand ); #this needs to be fixed...
   if ($odds > 0) {print "You run away safely...\n"; <STDIN>; $endbattle = 1; return(29);}
   else {
    print "\aYou don\'t run away...\n"; <STDIN>;
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
if ($player{'hpmin'} <= 0 or $enemy{'hpmin'} <= 0) { finish(); }
}
}

sub chk_pl_dth {
if ($player{'hpmin'} < 1) { return(0); } #dead
if ($player{'hpmin'} > 0) { return(1); } #alive
}

sub finish {
if ($player{'hpmin'} <= 0 && $enemy{'hpmin'} <= 0) { print "You both killed each other.\n"; exit; }
elsif ($player{'hpmin'} <= 0) { print "You were killed.\n"; exit;}
elsif ($enemy{'hpmin'} <= 0) { print "You were victorious.\n";}
else {print "Error computing winner.\n";}
if ($cheat == 1) {print "You have used at least one DEBUG code.\n"; }
$endbattle = 1;
}

sub platk { #Calculate enemy damage from player
   if ($player{'hpmin'} > 0 && hit_ch(0,2)){ #make sure your alive
   $damage = dam_mod( 2 * $player{'patt'} - $enemy{'pdef'}, 10 );
   if ($damage <= 1) { $damage = 1 };
   print "You do $damage damage...\n"; <STDIN>;
   $enemy{'hpmin'} -= $damage;
   }
}
sub enatk { #Calculate player damage from enemy
   if ($enemy{'hpmin'} > 0 && hit_ch(0,3)){ #make sure enemy is alive
   $damage = dam_mod( 2 * $enemy{'patt'} - $player{'pdef'}, 10 );
   if ($damage <= 1) { $damage = 1 };
   print "You recieve $damage damage...\n"; <STDIN>;
   $player{'hpmin'} -= $damage;
   }
}
sub plmag { #Calculate enemy damage from player magic
   if ($player{'hpmin'} > 0 && hit_ch(1,2)){
   my($damage) = @_[0];
   $damage += (2 * $player{'matt'} - $enemy{'mdef'}); #THIS NEEDS TO CHANGE
   if ($damage <= 1) { $damage = 1 };
   return($damage);
   }
}
sub enmag { #Calculate player damage from enemy magic
   if ($enemy{'hpmin'} > 0 && hit_ch(1,3)){
   my($damage) = @_[0];
   $damage += (2 * $enemy{'matt'} - $player{'mdef'}); #THIS NEEDS TO CHANGE
   if ($damage <= 1) { $damage = 1 };
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
   if ($player{'hpmin'} > $player{'hpmax'}) { $player{'hpmin'} = $player{'hpmax'}}
   if ($enemy{'hpmin'} > $enemy{'hpmax'}) { $enemy{'hpmin'} = $enemy{'hpmax'}}
   $player{'hpmin'} = int $player{'hpmin'};
   $enemy{'hpmin'} = int $enemy{'hpmin'};

   if ($player{'mpmin'} > $player{'mpmax'}) { $player{'mpmin'} = $player{'mpmax'}}
   if ($enemy{'mpmin'} > $enemy{'mpmax'}) { $enemy{'mpmin'} = $enemy{'mpmax'}}
   $player{'mpmin'} = int $player{'mpmin'};
   $enemy{'mpmin'} = int $enemy{'mpmin'};

   if ($player{'apmin'} > $player{'apmax'}) { $player{'apmin'} = $player{'apmax'}}
   if ($enemy{'apmin'} > $enemy{'apmax'}) { $enemy{'apmin'} = $enemy{'apmax'}}
   $player{'apmin'} = int $player{'apmin'};
   $enemy{'apmin'} = int $enemy{'apmin'};
}
sub enemai { #enemy decision
   if ($mode == 0) {
   my($a) = rand(100);
   if ($a < 9) {
      print "$enemy{'name'} uses a potion...\n"; <STDIN>;
      $enemy{'hpmin'} += $itpot;
      hpcheck();
   } elsif ($a < 16) {
      my($damage) = dam_mod($itgr1,$itgr2);
      $player{'hpmin'} -= $damage;
      print "$enemy{'name'} uses a grenade ($damage)...\n"; <STDIN>;
   } elsif ($a < 24) {
      $enemy{'mpmin'} += $itmag;
      print "$enemy{'name'} uses item magic...\n"; <STDIN>;
   } elsif ($a < 32) {
      $enemy{'apmin'} += $itabi;
      print "$enemy{'name'} uses item ability...\n"; <STDIN>;
   } elsif ($a < 38) {
      print "$enemy{'name'} charges his attack...\n"; <STDIN>;
      $enemy{'patt'} += 1;
   } elsif ($a < 44) {
      print "$enemy{'name'} charges his defense...\n"; <STDIN>;
      $enemy{'pdef'} += 1;
   } elsif ($a < 50) {
      print "$enemy{'name'} charges his speed...\n"; <STDIN>;
      $enemy{'speed'} += 1;
   } elsif ($a < 55 and $enemy{'mpmin'} >= 9) {
      my($damage) = enmag(100);
      $player{'hpmin'} -= $damage;
      $enemy{'mpmin'} -= 9;
      print "$enemy{'name'} uses magic Degrade ($damage)...\n"; <STDIN>;
   } elsif ($a < 60 and $enemy{'mpmin'} >= 12) {
      my($damage) = enmag(140);
      $player{'hpmin'} -= $damage;
      $enemy{'mpmin'} -= 12;
      print "$enemy{'name'} uses magic Decay ($damage)...\n"; <STDIN>;
   } elsif ($a < 65 and $enemy{'mpmin'} >= 25) {
      my($damage) = $player{'hpmin'} / 4;
      my($damage) = int $damage;
      $player{'hpmin'} -= $damage;
      $enemy{'mpmin'} -= 25;
      print "$enemy{'name'} uses magic Demi ($damage)...\n"; <STDIN>;
   } elsif ($a < 70 and $enemy{'mpmin'} >= 20) {
      $enemy{'apmin'} = $enemy{'apmax'};
      $enemy{'mpmin'} -= 20;
      print "$enemy{'name'} uses magic Restores AP...\n"; <STDIN>;
   } else {
      enatk();
   }
   }
regen(); #regenerate after enemy attack
}
sub useitem {
   my($choice) = @_[0];
   if ($choice == 0) {
   $player{'hpmin'} += $itpot;
   hpcheck();
   print "HP increased by $itpot...\n"; <STDIN>;
   } elsif ($choice == 1) {
   $player{'hpmin'} += $ithpt;
   hpcheck();
   print "HP increased by $ithpt...\n"; <STDIN>;
   } elsif ($choice == 2) {
   my($damage) = dam_mod($itgr1,$itgr2);
   $enemy{'hpmin'} -= $damage;
   print "Your grenade does $damage damage...\n"; <STDIN>;
   } elsif ($choice == 3) {
   $player{'apmin'} += $itabi;
   hpcheck();
   print "AP increased by $itabi...\n"; <STDIN>;
   } elsif ($choice == 4) {
   $player{'mpmin'} += $itmag;
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
     $a = $player{'pacc'};
     $b = $enemy{'peva'};
   } elsif ($type == 0 && $orig == 3){ #player magical
     $a = $enemy{'pacc'};
     $b = $player{'peva'};
   } elsif ($type == 1 && $orig == 2){ #enemy physical
     $a = $player{'macc'};
     $b = $enemy{'meva'};
   } elsif ($type == 1 && $orig == 3){ #enemy magical
     $a = $enemy{'macc'};
     $b = $player{'meva'};
   } else {print "\aHIT CHANCE ERROR!\n";} #should only occur if programmer makes a typo
   my($chance) = (100-(100-$a)*($b/$a+1)/2); #Just for kicks... should be changed
   if (rand(100) < $chance){return(1);}
   else {
      if ($orig == 2 and $type == 0) {print "$player{'name'} misses $enemy{'name'} with physical...\n";}
      elsif ($orig == 2 and $type == 1) {print "$player{'name'} misses $enemy{'name'} with magical...\n";}
      elsif ($orig == 3 and $type == 0) {print "$enemy{'name'} misses $player{'name'} with physical...\n";}
      elsif ($orig == 3 and $type == 1) {print "$enemy{'name'} misses $player{'name'} with magical...\n";}
   <STDIN>; return(0);}
}
sub regen { #regenerate
   my($regen) = $player{'regen'};
   $player{'hpmin'} += $regen;           #hp 100%
   $player{'mpmin'} += int ($regen / 2); #mp 50%
   $player{'apmin'} += int ($regen / 3); #ap 33%
}

sub user_quit {
 clear();
 print "You have decided to end the game.\n";
 exit
}

sub fight { #you choose the basic attack option
   if ($player{'speed'} >= $enemy{'speed'}) { platk(); enemai(); }    #player faster
   elsif ($player{'speed'} <= $enemy{'speed'}) { enemai(); platk(); } #enemy faster
}

sub item {
   $asdf = 0; #this variable is used to make sure that the enemy attacks only if an item is used
   clear();
   print "HP: $player{'hpmin'}/$player{'hpmax'} MP: $player{'mpmin'}/$player{'mpmax'} AP: $player{'apmin'}/$player{'apmax'}\n";
   print "Use an Item:\n";
   print "1) Potions   ($inven[0])\n";
   print "2) HiPotions ($inven[1])\n";
   print "3) Grenades  ($inven[2])\n";
   print "4) Ability   ($inven[3])\n";
   print "5) Magic     ($inven[4])\n";
   print "9) Quit\n";
   $choice = <STDIN>; $choice += "\b"; $choice = int $choice; #get user choice, chop off \n
   if ($choice == 9) {$asdf = 1;} #asdf?!?! what is the matter with me?!?!
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
    clear();
    print "---CHOOSE---($player{'apmin'}/$player{'apmax'}ap)\n1) Super Punch  (4ap)\n2) Upper Cut    (5ap)\n3) +10% Attack ($player{'apmax'} \bap)\n4) +10% Defense($player{'apmax'} \bap)\n5) +10% Speed  ($player{'apmax'} \bap)\n6) Restore HP  (10ap)\n7) Scan Enemy   (2ap)\n8) Regen ($player{'regen'})   (20ap)\n9) Back\n";
    $choice = <STDIN>; $choice += "\b";
   if ($choice == 1 && $player{'apmin'} >= 4) {
        $damage = dam_mod(100,8);
        print "Super Punch does $damage damage to $enemy{'name'}...\n"; <STDIN>;
        $enemy{'hpmin'} -= $damage;
        $player{'apmin'} -= 4;
        enemai();
   } elsif ($choice == 2 && $player{'apmin'} >= 5) {
       $damage = dam_mod(120,10);
       print "Upper Cut does $damage damage to $enemy{'name'}...\n"; <STDIN>;
       $enemy{'hpmin'} -= $damage;
       $player{'apmin'} -= 5;
       enemai();
   } elsif ($choice == 3 && $player{'apmin'} >= $player{'apmax'}) {
       print "Your attack has been increased...\n"; <STDIN>;
       $player{'patt'} *= 1.1;
       $player{'patt'} = int $player{'patt'};
       $player{'apmin'} -= $player{'apmax'};
       enemai();
   } elsif ($choice == 4 && $player{'apmin'} >= $player{'apmax'}) {
       print "Your defense has been increased...\n"; <STDIN>;
       $player{'pdef'} *= 1.1;
       $player{'pdef'} = int $player{'pdef'};
       $player{'apmin'} -= $player{'apmax'};
       enemai();
   } elsif ($choice == 5 && $player{'apmin'} >= $player{'apmax'}) {
       print "Your speed has been increased...\n"; <STDIN>;
       $player{'speed'} *= 1.1;
       $player{'speed'} = int $player{'speed'};
       $player{'apmin'} -= $player{'apmax'};
       enemai();
   } elsif ($choice == 6 && $player{'apmin'} >= 10) {
       print "Your HP has been restored...\n"; <STDIN>;
       $player{'hpmin'} = $player{'hpmax'};
       $player{'apmin'} -= 10;
       enemai();
   } elsif ($choice == 7 && $player{'apmin'} >= 2) {
       clear();
       print "$enemy{'name'} Stats\n";
       print "HP: $enemy{'hpmin'}/$enemy{'hpmax'} MP: $enemy{'mpmin'}/$enemy{'mpmax'} AP: $enemy{'apmin'}/$enemy{'apmax'}\n";
       print "------Physical-----+-----Mental-----\n";
       print "ATT DEF ACC EVA SPD| ATT DEF ACC EVA\n";
       print "$enemy{'patt'}  $enemy{'pdef'}  $enemy{'pacc'}  $enemy{'peva'}  $enemy{'speed'} | $enemy{'matt'}  $enemy{'mdef'}  $enemy{'macc'}  $enemy{'meva'}\n";
       print "\nPress Enter...\n"; <STDIN>;
       $player{'apmin'} -= 2;
       enemai();
   } elsif ($choice == 8 && $player{'apmin'} >= 20) {
       $player{'regen'} += 1;
       print "Regeneration increased to $player{'regen'}...\n"; <STDIN>;
       $player{'apmin'} -= 20;
       enemai();
   } elsif ($choice == 9) {
   } else {print "\aNot enough ap...\n"; <STDIN>;}
}

sub magic {
    clear();
    print "---CHOOSE----($player{'mpmin'}/$player{'mpmax'}\n1) Magic Missile (4mp)\n2) Sub Zer0      (7mp)\n3) Smite        (10mp)\n4) Demi         (25mp)\n5) Restore HP   (20mp)\n6) Restore AP   (20mp)\n9) Back\n";
    $choice = <STDIN>; $choice += "\b";
   if ($choice == 1 && $player{'mpmin'} >= 4) {
        $damage = plmag(50);
        print "Magic Missile does $damage damage to $enemy{'name'}...\n"; <STDIN>;
        $enemy{'hpmin'} -= $damage;
        $player{'mpmin'} -= 4;
        enemai();
   } elsif ($choice == 2 && $player{'mpmin'} >= 7) {
       $damage = plmag(80);
       print "Sub Zer0 does $damage damage to $enemy{'name'}...\n"; <STDIN>;
       $enemy{'hpmin'} -= $damage;
       $player{'mpmin'} -= 7;
       enemai();
   } elsif ($choice == 3 && $player{'mpmin'} >= 10) {
       $damage = plmag(120);
       print "Smite does $damage to $enemy{'name'}...\n"; <STDIN>;
       $enemy{'hpmin'} -= $damage;
       $player{'mpmin'} -= 10;
       enemai();
   } elsif ($choice == 4 && $player{'mpmin'} >= 25) {
       $damage = $enemy{'hpmin'} / 4;
       $damage = int $damage;
       print "Demi does $damage to $enemy{'name'}...\n"; <STDIN>;
       $enemy{'hpmin'} -= $damage;
       $player{'mpmin'} -= 25;
       enemai();
   } elsif ($choice == 5 && $player{'mpmin'} >= 20) {
       print "Your health has been restored...\n"; <STDIN>;
       $player{'hpmin'} = $player{'hpmax'};
       $player{'mpmin'} -= 20;
       enemai();
   } elsif ($choice == 6 && $player{'mpmin'} >= 20) {
       print "Your AP has been restored...\n"; <STDIN>;
       $player{'apmin'} = $player{'apmax'};
       $player{'mpmin'} -= 20;
       enemai();
   } elsif ($choice == 9) {
   } else {print "\aNot enough MP...\n"; <STDIN>;}
}

sub charge {
    clear();
    print "---CHOOSE---\n1) Phys Attack up\n2) Phys Defense up\n3) Speed up\n4) AP up\n5) MP up\n9) Back\n";
    $choice = <STDIN>; $choice += "\b";
    if ($choice == 1) {$player{'patt'} += 1; print "Attack Increased...\n"; <STDIN>; enemai();}
    elsif ($choice == 2) {$player{'pdef'} += 1; print "Defense Increased...\n"; <STDIN>; enemai();}
    elsif ($choice == 3) {$player{'speed'} += 1; print "Speed Increased...\n"; <STDIN>; enemai();}
    elsif ($choice == 4) {$player{'apmin'} += 3; print "AP Increased...\n"; <STDIN>; enemai();}
    elsif ($choice == 5) {$player{'mpmin'} += 4; print "MP Increased...\n"; <STDIN>; enemai();}
    elsif ($choice == 9) {}
    else {print "\aInvalid selection...\n";<STDIN>;}
}

sub view_self_stats {
   clear();
   print "$player{'name'} Stats\n";
   print "HP: $player{'hpmin'}/$player{'hpmax'} MP: $player{'mpmin'}/$player{'mpmax'} AP: $player{'apmin'}/$player{'apmax'}\n";
   print "------Physical-----+-----Mental-----\n";
   print "ATT DEF ACC EVA SPD| ATT DEF ACC EVA\n";
   print "$player{'patt'}  $player{'pdef'}  $player{'pacc'}  $player{'peva'}  $player{'speed'} | $player{'matt'}  $player{'mdef'}  $player{'macc'}  $player{'meva'}\n";
   print "\nPress Enter...\n"; <STDIN>;
}

sub shop {
 my($choice) = 0;
 while ($choice != 99) {
   clear();
   print "Welcome to the shop\nYou have $money cash.\n";
   print "---BUY------#--cc---SELL---\n";
   print "1) Potion  ($inven[0])(10c) (06) (5c)\n2) HiPotion($inven[1])(30c) (07) (15c)\n3) Grenade ($inven[2])(75c) (08) (40c)\n4) Ability ($inven[3])(50c) (09) (25c)\n5) Magic   ($inven[4])(50c) (10) (25c)\n99) Leave\n";
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
   print "You now have $inven[3] Abilities...\n"; <STDIN>;
   } elsif ($choice == 5 and $money >= 50) {
   $inven[4] += 1;
   $money -= 50;
   print "You now have $inven[4] Magics...\n"; <STDIN>;
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
   print "You now have $inven[3] Abilities...\n"; <STDIN>;
   } elsif ($choice == 10 and $inven[4] >= 1) {
   $inven[4] -= 1;
   $money += 50;
   print "You now have $inven[4] Magics...\n"; <STDIN>;
   }
 }
}

sub traincent {
   clear();
   print "Welcome to the training center.\n";
   print "While here, I can make you stronger\n";
   print "For the small fee of \$500...\n";
   print "[type 1 for yes, 2 for no]\n";
   $choice = <STDIN>;
   if ($choice == 1 and $money >= 500) {
    $money -= 500;
    $player{'patt'} += 4;
    $player{'pdef'} += 4;
    $player{'pacc'} += 5;
    $player{'peva'} += 3;
   } elsif ($choice == 1 and $money < 500) {
    print "Go away, you cheep bastard...\n"; <STDIN>;
   } else { }
}

sub mrand { #min, max
  my($min) = $_[0];
  my($max) = $_[1];
  my($val) = int rand(($max - $min) + 1) + $min;
  return($val);
}

sub debug1 {
   print "DEBUG: display variables\n";
   print "Variable Scopes: a: $a b: $b c: $c asdf: $asdf damage: $damage regen: $regen orig: $orig type: $type cheat: $cheat\n";
   print "Potions   ($inven[0])$itpot\nHiPotions ($inven[1])$ithpt\nGrenades  ($inven[2])$itgr1 $itgr2\nAbility   ($inven[3])$itabi\nMagic     ($inven[4])$itmag\n";
   print "press enter..."; <STDIN>;
   $cheat = 1;
}

sub debug2 {
   print "DEBUG: increase all enemy min/max points...\n"; <STDIN>;
   $enemy{'hpmax'} += 200;
   $enemy{'hpmin'} = $enemy{'hpmax'};
   $enemy{'mpmax'} += 30;
   $enemy{'mpmin'} = $enemy{'mpmax'};
   $enemy{'apmax'} += 15;
   $enemy{'apmin'} = $enemy{'apmax'};
   $cheat = 1;
}

sub debug3 {
   print "DEBUG: increase all self min/max points...\n"; <STDIN>;
   $player{'hpmax'} += 200;
   $player{'hpmin'} = $player{'hpmax'};
   $player{'mpmax'} += 30;
   $player{'mpmin'} = $player{'mpmax'};
   $player{'apmax'} += 15;
   $player{'apmin'} = $player{'apmax'};
   $cheat = 1;
}

sub debug4 {
   print "DEBUG: manually modify variables...\n"; <STDIN>;
   print "\nhpa:"; $player{'hpmin'} = <STDIN>;
   print "\nhpb:"; $player{'hpmax'} = <STDIN>;
   print "\nmpa:"; $player{'mpmin'} = <STDIN>;
   print "\nmpb:"; $player{'mpmax'} = <STDIN>;
   print "\napa:"; $player{'apmin'} = <STDIN>;
   print "\napb:"; $player{'apmax'} = <STDIN>;
   print "\npat:"; $player{'patt'} = <STDIN>;
   print "\npde:"; $player{'pdef'} = <STDIN>;
   print "\npac:"; $player{'pacc'} = <STDIN>;
   print "\npev:"; $player{'peva'} = <STDIN>;
   print "\nmat:"; $player{'matt'} = <STDIN>;
   print "\nmde:"; $player{'mdef'} = <STDIN>;
   print "\nmac:"; $player{'macc'} = <STDIN>;
   print "\nmev:"; $player{'meva'} = <STDIN>;
   print "\nspd:"; $player{'speed'} = <STDIN>;
   print "\nnam:"; $player{'name'} = <STDIN>;
   print "\nrgn:"; $player{'regen'} = <STDIN>;
   print "\nX:"; $player{'x'} = <STDIN>;
   print "\nY:"; $player{'y'} = <STDIN>;
   print "\nmoney:"; $money = <STDIN>;
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

sub initiate_map {
#0=floor 1=wall 2=potion 3=liquid 4=shop 5=traincenter 6= 7=enemyTypeA 8=enemyTypeB 9=enemyTypeC
# W
#N S
# E
@map = (
 [0, 1, 1, 1, 1, 1, 1, 1, 1, 0],
 [1, 1, 0, 3, 3, 3, 0, 0, 1, 1],
 [1, 0, 3, 3, 0, 3, 3, 0, 0, 1],
 [1, 0, 3, 0, 9, 0, 3, 0, 0, 1],
 [1, 0, 3, 3, 0, 3, 3, 0, 0, 1],
 [1, 0, 0, 3, 3, 3, 0, 0, 0, 1],
 [1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
 [1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
 [1, 1, 0, 0, 0, 0, 0, 0, 1, 1],
 [0, 1, 1, 1, 0, 1, 1, 1, 1, 0],
 [0, 0, 0, 1, 0, 1, 0, 0, 0, 0],
 [0, 0, 0, 1, 0, 1, 0, 0, 0, 0],
 [0, 0, 0, 1, 0, 1, 0, 0, 0, 0],
 [0, 0, 0, 1, 0, 1, 1, 1, 0, 0],
 [0, 0, 0, 1, 0, 0, 0, 1, 0, 0],
 [0, 0, 0, 1, 1, 1, 0, 1, 0, 0],
 [0, 0, 0, 0, 0, 1, 0, 1, 0, 0],
 [0, 0, 0, 0, 0, 1, 0, 1, 0, 0],
 [1, 1, 1, 1, 1, 1, 8, 1, 1, 1],
 [1, 0, 0, 0, 1, 0, 0, 0, 0, 1],
 [1, 0, 1, 0, 1, 0, 0, 0, 0, 1],
 [1, 0, 1, 0, 1, 0, 0, 0, 0, 1],
 [1, 0, 1, 0, 1, 0, 0, 0, 0, 1],
 [1, 0, 1, 0, 0, 0, 0, 0, 0, 1],
 [1, 0, 1, 1, 1, 1, 1, 1, 1, 1],
 [1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
 [1, 1, 1, 1, 1, 1, 1, 0, 1, 1],
 [1, 0, 0, 1, 0, 0, 0, 0, 0, 1],
 [1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
 [1, 0, 0, 1, 0, 0, 0, 0, 0, 1],
 [1, 0, 0, 1, 1, 0, 1, 1, 1, 1],
 [1, 0, 0, 1, 0, 0, 0, 0, 0, 1],
 [1, 0, 0, 1, 0, 0, 0, 0, 0, 1],
 [1, 4, 0, 1, 0, 0, 0, 0, 0, 1],
 [1, 0, 0, 1, 0, 0, 0, 0, 0, 1],
 [1, 1, 1, 1, 0, 0, 1, 1, 1, 1],
 [1, 0, 0, 1, 0, 0, 1, 0, 0, 1],
 [1, 5, 0, 7, 0, 0, 0, 0, 0, 1],
 [1, 0, 0, 1, 0, 0, 1, 0, 0, 1],
 [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
);
%map = ('width' => 40,'height' => 10);
}

sub clear {
 my($j) = 0;
 while ($j <= 20) {
  print "\n";
  $j++;
 }
}

sub print_map {
my($i) = 0;
until ($i >= $map{'height'}) {
 my($j) = 0;
  until ($j >= $map{'width'}) {
   if ($j == $player{'x'} && $i == $player{'y'}) {
    print "@";
   } elsif ( $map[$j][$i] == 0 ) {
   print " ";   
   } elsif ( $map[$j][$i] == 1 ) {
   print "#";
   } elsif ( $map[$j][$i] == 2 ) {
   print "p";
   } elsif ( $map[$j][$i] == 3 ) {
   print "-";
   } elsif ( $map[$j][$i] == 4 ) {
   print "S";
   } elsif ( $map[$j][$i] == 5 ) {
   print "T";
   } elsif ( $map[$j][$i] == 6 ) {
   print "?";
   } elsif ( $map[$j][$i] == 7 ) {
   print "a";
   } elsif ( $map[$j][$i] == 8 ) {
   print "b";
   } elsif ( $map[$j][$i] == 9 ) {
   print "c";
   } else { print "?"; }
   $j++;
  }
  print "\n";
  $i++;
}

}


#released under the GPL by nucleocide.net