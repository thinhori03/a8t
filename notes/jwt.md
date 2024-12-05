
# jwt.

- [jwt.io](https://jwt.io)

""" from [jwt.io](https://jwt.io)
- Authorization:
  This is the most common scenario for using JWT. Once the user is logged in, each subsequent request will include the  JWT, allowing the user to access routes, services, and resources that are permitted with that token. Single Sign On is a  feature that widely uses JWT nowadays, because of its small overhead and its ability to be easily used across different domains.

- Information Exchange: JSON Web Tokens are a good way of securely transmitting information between parties. Because JWTs   can be signed—for example, using public/private key pairs—you can be sure the senders are who they say they are. Additionally, as the signature is calculated using the header and the payload, you can also verify that the content hasn't been tampered with
"""

### jwt structure.

+ **header**.
  - consits two part: `typ` token type (jwt) and `sig` (algorithm used to `signing` token).
  ``` json
  {
      "alg": "HS256",
      "typ": "JWT"
  }
  ```
  - this **json** is **base64url** encoded.
+ **payload**: contain additonal data
  - `registered claim`: example
    ``` json
    {
        "sub": "1234567890",
        "name": "John Doe",
        "admin": true
    }
    ```
  - `public clai]`:
  - `private claim`:
- **signature**: encoded `header`, `payload`, a secret, signed by `header.sig` algorithm.
  ``` C
  HMACSHA256(
      base64UrlEncode(header) + "." +
      base64UrlEncode(payload),
      secret)
  ```
  **from** [jwt.io](https://jwt.io)
  > The signature is used to verify the message wasn't changed along the way,
  > and, in the case of tokens signed with a private key,
  > it can also verify that the sender of the JWT is who it says it is.

## try with debugger.

- [jwt-debugger](https://jwt.io/#debugger-io)
