# README

This is a sample project built with downstream API calls to setlist.fm and spotify to get the tracks metadata for a given Artist name.

API End Point

* To fetch and persist the tracks and its metadata from the latest concert of the given artist.
  
  API End Point : /playlists?artist_name=Tenacious%20D

  Note : This end point is expected to take some time to respond if there are more no of tracks found in the artist latest concert setlist.  

* To fetch the tracks, given the artist name and concert date.

  API End Point : /playlists?artist_name=Tenacious%20D&concert_date=20-5-2017
