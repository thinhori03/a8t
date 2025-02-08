1. JWT Structure
Authorization: Bearer base64UrlEncode(Header).base64UrlEncode(Payload).< Signature >
- Header: Contains metadata about the token, such as the type of token (JWT) 
and the signing algorithm (HS256, RS256, etc.).
```json
  	{
		"alg": "HS256",
		"typ": "JWT"
	}
```

- Payload: Contains the claims (information) that you want to transmit. 
This could include user info, permissions, expiration, etc.

```json
	{
		"sub": "1234567890",
		"name": "John Doe",
		"iat": 1516239022
	}

```

- Signature: Ensures that the token is not altered. 
Created by signing the header and payload with a secret key. 
The Signature will be generated using the hashing algorithm specified in the Header.

```shell
	HMACSHA256(base64UrlEncode(header) + "." + base64UrlEncode(payload), secretKey)

```
