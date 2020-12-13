variable "common_tags" {
    type = map(string)
    default = {
        "applictaion": "netpalm",
        "Name": "netpalm"
    }
}