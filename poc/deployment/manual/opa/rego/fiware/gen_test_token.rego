#
# Generate a test JWT token signed with the RSA key in `rsa-key-pair.rego`
# having a tenant field set to the `input` and an expiry date in 2286.
#
# Example
#
# $ cd rego
# $ echo '"my-tenant"' | opa eval 'test_token' -d ./ -I --package 'fiware.service'
#

package fiware.service


import data.fiware.service.rsa_key_pair_jwk as jwk


test_token = t {
    header = {
        "alg": "RS256",
        "typ": "JWT"
    }
    payload = {
        "tenant": input,
        "exp": 10000000000  # 20 Nov 2286 @ 18:46:40 (CET)
    }
    jwt := io.jwt.encode_sign(header, payload, jwk)
    bearer := sprintf("Bearer %s", [jwt])

    t := {
        "bearer": bearer,
        "jwt": jwt
    }
}
