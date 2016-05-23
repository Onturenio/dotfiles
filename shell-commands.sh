#set -ex

function passwd_INTERNET {
if [[ $# == 0 ]]; then
  gpg -d ~/Dropbox/INTERNET.asc 2> /dev/null | less
  echo "Type \"gpg -ca file\" to encrypt a file in ASCII"
elif [[ $# == 1 ]]; then
  gpg -d ~/Dropbox/INTERNET.asc 2> /dev/null | grep -i $1
else
  echo "Usage passwd_INTERNET [filter]"
fi
}


#function HDMI {
#xrandr --newmode "1360x768_60.00"   84.75  1360 1432 1568 1776  768 771 781 798 -hsync +vsync
#xrandr --addmode HDMI1 1360x768_60.00
#xrandr --output HDMI1 --mode 1360x768_60.00
#}


function ext2serie {
if [ $# -eq 2 ]; then
  cdo info $1 | grep -v Date | awk '{print $9}' > data
  cdo info $1 | grep -v Date | awk '{print $3}' | awk -F- '{print $1}' > dates
  paste dates data > $2
  rm -f data dates
else
  echo "usage ext2serie <filein> <fileout>"
fi
}

function extfield2serie {
if [ $# -eq 2 ]; then
  cdo info -fldmean $1 | grep -v Date | awk '{print $9}' > data
  cdo info $1 | grep -v Date | awk '{print $3}' | awk -F- '{print $1}' > dates
  paste dates data > $2
  rm -f data dates
else
  echo "usage ext2serie <filein> <fileout>"
fi
}

function standard {
if [ $# -eq 2 ]; then
  cdo -sub $1 -timmean $1 asdf1
  cdo -div asdf1 -timstd asdf1 $2
  rm asdf1
else
  echo "usage standard <filein> <fileout>"
fi
}


function mira {
cdo info $1 2> /dev/null | more
}

function purga_raw {
echo $PWD
for file in *NEF; do
  file=$(basename $file .NEF)
  if [ ! -f ${file}_NEF.jpg ]; then
    echo deleting ${file}.NEF
    rm ${file}.NEF
  fi
done
}


function rmse {
if [ $# -eq 3 ]; then
  cdo sub $1 $2 asdf1
  cdo sqr asdf1 asdf2
  cdo timmean asdf2 asdf3
  cdo sqrt asdf3 $3
  rm asdf1 asdf2 asdf3
else
  echo "usage rmse <fileini1> <filein2> <fileout>"
fi
}

function reduction_error {
if [ $# -eq 4 ]; then
  cdo timmean -seldate,$3 $1 ref_

  cdo sub $1 ref_ asdf1
  cdo sqr asdf1 asdf2
  cdo timsum asdf2 asdf3

  cdo sub $1 $2 fdsa1
  cdo sqr fdsa1 fdsa2
  cdo timsum fdsa2 fdsa3

  cdo addc,1 -mulc,-1 -div fdsa3 asdf3 $4

  rm asdf* fdsa* ref_
else
  echo "usage reduction_error <real> <recons> <date_ref> <fileout>"
fi
}
