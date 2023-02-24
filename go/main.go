package main

import (
	"context"
	"flag"
	"fmt"
	"os"

	"github.com/j-bro/pco-openapi-spec/services"
	"github.com/labstack/gommon/log"
)

type flags struct {
	title string
}

func main() {
	config := flags{}
	flag.StringVar(&config.title, "title", "", "Jesus paid it all")
	flag.Parse()

	client := services.Client{}
	songsResponse, err := client.GetSongs(context.Background(), &services.GetSongsParams{
		Where: &services.SongQuery{
			Title: &config.title,
		},
	})
	if err != nil {
		log.Info("%v", err)
		os.Exit(1)
	}
	parsedResponse, err := services.ParsegetSongsResponse(songsResponse)
	if err != nil {
		log.Info("%v", err)
		os.Exit(1)
	}

	fmt.Fprintf(os.Stdout, "Response`: %v\n", parsedResponse.JSON200)
}
