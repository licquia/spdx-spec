#!/bin/sh

if [ \! -d docs/model ]; then
  echo "error: model directory not found" >&2
  exit 1
fi

(
  echo "- model:"
  for i in Core Software Security Licensing SimpleLicensing ExpandedLicensing Dataset AI Build Lite Extension; do
    printf "  - ${i}:\n    - 'Description': model/$i/${i}.md\n"
    for d in Classes Properties Vocabularies Individuals Datatypes ; do
      if [ -d docs/model/$i/$d ] ; then
        printf "    - ${d}:\n"
        (cd docs/model && find $i/$d -type f -printf "      - model/%p\n") | sort
      fi
    done
  done
) > model_toc

cutoff_line=$(grep -n @MODEL_TOC@ mkdocs.yml.in | cut -f1 -d:)
split_amt=$(($cutoff_line-1))
split -l $split_amt mkdocs.yml.in

mv xaa mkdocs.yml

cat model_toc >> mkdocs.yml

grep -v @MODEL_TOC@ xab >> mkdocs.yml
rm xab

if [ -e xac ]; then
  cat xa? >> mkdocs.yml
fi

rm -f xa? model_toc
