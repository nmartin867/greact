package main

import (
	"github.com/gin-gonic/gin"
)

func main() {
	router := gin.Default()
	router.GET("/ping", getStatus)

	router.Run()
}

func getStatus(c *gin.Context) {
	c.JSON(200, gin.H{
		"message": "pong",
	})
}
