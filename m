Return-Path: <linux-api+bounces-6828-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZfADCTS5UGoc4AIAu9opvQ
	(envelope-from <linux-api+bounces-6828-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 10 Jul 2026 11:19:48 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8226A738F53
	for <lists+linux-api@lfdr.de>; Fri, 10 Jul 2026 11:19:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=mchp header.b=MBuZ6mNk;
	dmarc=pass (policy=reject) header.from=microchip.com;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6828-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6828-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 080A8314264F
	for <lists+linux-api@lfdr.de>; Fri, 10 Jul 2026 09:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03693D16F1;
	Fri, 10 Jul 2026 08:59:42 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46383CEB98;
	Fri, 10 Jul 2026 08:59:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673982; cv=none; b=QQ38fv/dYBepEwAMUNsEp+4YB4NPHwMQhRcBnSVRp/UdxpH0VJm0gdSfIpV/hKxZQ1TebRoWamVswpScFsIBfa5TmgcQuAQbLCF4nK8uNM+61wkiluTdHIWpz2Kn4S2qG2Mcv9Ad55Cx7WtkHzFbHpMS/M+3OKoBb+yFQBIwGx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673982; c=relaxed/simple;
	bh=ySeEdVyfLJ1FoqK1KDCiOu5dWvFOr79CGcqcGkC6+pU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1JqJ//9dbxUuGsFkusmvDyqaShLZ0hVP3sKiA40HF/T6wVLTR1R2/Zw14NraRpOyVcm+iY+6pIDzWkcTs8TWsmWRDQpOVIS6vZQgbYDEQykRcFFWF+3McyDR/sdXJN9gO+mRuyoigsHR+CKX7ndXmHoFaVukqs7USL0/7bqEUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MBuZ6mNk; arc=none smtp.client-ip=68.232.154.123
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1783673980; x=1815209980;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ySeEdVyfLJ1FoqK1KDCiOu5dWvFOr79CGcqcGkC6+pU=;
  b=MBuZ6mNkP/0S/zbN231bu5DjQckZiPlbcRWtjXxemb7K9wwMpGz5MD7p
   gJq7FrPdxrAV/YuTr82t5GynMDPCDpNcZ2kw4BWb5+esWAa9qIZaAHTgC
   wKPS8t3xVpnlJLo6Z1i1F2GlZ9HmUXdkAWTiAErrqUfB8m5VI68K5bkv3
   G8W13m1XmtPBHNVk72nt2gGg3Q/Hmrz/yDgdLadQAAbhX103v+BUNiZNf
   SRqI6llW4mF6vvy2ngOpS5cd76+YLNt6tt93iwPxM/P26nuCHittrMcVs
   uEvBQsKYfc5ppl3OeNXtbVz9WjFMbyMmjWGvEmIruxG/0p4CmQJPe/Mvm
   g==;
X-CSE-ConnectionGUID: 93p7ykEDR4iIaWuQKtugoQ==
X-CSE-MsgGUID: d97xofyKSd+Bzpg62yGSuw==
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="asc'?scan'208";a="59540370"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 01:59:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Fri, 10 Jul 2026 01:59:32 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Fri, 10 Jul 2026 01:59:29 -0700
Date: Fri, 10 Jul 2026 09:58:34 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
CC: Albert Ou <aou@eecs.berkeley.edu>, Alex Ousherovitch
	<aousherovitch@rambus.com>, Conor Dooley <conor+dt@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>,
	Jonathan Corbet <corbet@lwn.net>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, Rob
 Herring <robh@kernel.org>, Shuah Khan <shuah@kernel.org>, Alexandre Ghiti
	<alex@ghiti.fr>, <devicetree@vger.kernel.org>, Joel Wittenauer
	<Joel.Wittenauer@cryptography.com>, <linux-api@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, Shuah Khan <skhan@linuxfoundation.org>,
	Thi Nguyen <thin@rambus.com>
Subject: Re: [PATCH v2 01/19] dt-bindings: crypto: add Rambus CryptoManager
 Hub
Message-ID: <20260710-siding-unmatched-5e066fbe4c01@wendy>
References: <20260709203037.1884436-1-skrishnamoorthy@rambus.com>
 <20260709203037.1884436-2-skrishnamoorthy@rambus.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tVV5lCAGuauPQznU"
Content-Disposition: inline
In-Reply-To: <20260709203037.1884436-2-skrishnamoorthy@rambus.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6828-lists,linux-api=lfdr.de];
	FORGED_SENDER(0.00)[conor.dooley@microchip.com,linux-api@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:skrishnamoorthy@rambus.com,m:aou@eecs.berkeley.edu,m:aousherovitch@rambus.com,m:conor+dt@kernel.org,m:davem@davemloft.net,m:herbert@gondor.apana.org.au,m:corbet@lwn.net,m:krzk+dt@kernel.org,m:palmer@dabbelt.com,m:pjw@kernel.org,m:robh@kernel.org,m:shuah@kernel.org,m:alex@ghiti.fr,m:devicetree@vger.kernel.org,m:Joel.Wittenauer@cryptography.com,m:linux-api@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:skhan@linuxfoundation.org,m:thin@rambus.com,m:conor@kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor.dooley@microchip.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,devicetree.org:url,wendy:mid,microchip.com:from_mime,microchip.com:dkim,cryptography.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8226A738F53

--tVV5lCAGuauPQznU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Thu, Jul 09, 2026 at 01:30:19PM -0700, Saravanakrishnan Krishnamoorthy w=
rote:
> From: Alex Ousherovitch <aousherovitch@rambus.com>
>=20
> Add device tree binding schema for the CRI CryptoManager Hub (CMH)
> hardware crypto accelerator.  The binding covers the parent SoC-level
> node with register region, interrupt, DMA properties, and per-core
> child nodes identified by compatible string and unit address.
>=20
> Register the 'cri' vendor prefix for Cryptography Research, Inc.

This company no longer exists, you should probably introduce a rambus
vendor prefix instead.

>=20
> Co-developed-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.=
com>
> Signed-off-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.co=
m>
> Signed-off-by: Alex Ousherovitch <aousherovitch@rambus.com>
> Reviewed-by: Joel Wittenauer <Joel.Wittenauer@cryptography.com>
> Reviewed-by: Thi Nguyen <thin@rambus.com>
> ---
>  .../devicetree/bindings/crypto/cri,cmh.yaml   | 222 ++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  2 files changed, 224 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/crypto/cri,cmh.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/crypto/cri,cmh.yaml b/Docu=
mentation/devicetree/bindings/crypto/cri,cmh.yaml
> new file mode 100644
> index 000000000000..db41132e0591
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/cri,cmh.yaml
> @@ -0,0 +1,222 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/crypto/cri,cmh.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: CRI CryptoManager Hub (CMH) Hardware Crypto Accelerator
> +
> +maintainers:
> +  - Alex Ousherovitch <aousherovitch@rambus.com>
> +  - Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
> +  - Joel Wittenauer <Joel.Wittenauer@cryptography.com>
> +
> +description: |
> +  The CRI CryptoManager Hub (CMH) is a hardware cryptographic accelerato=
r accessed
> +  via a mailbox-based VCQ (Virtual Command Queue) interface.  The host
> +  writes VCQ command sequences into per-mailbox DMA queue buffers and
> +  rings a doorbell; the CMH eSW processes them and signals completion
> +  via interrupt.
> +
> +  Supported algorithm families: SHA-2, SHA-3, SM3, AES, SM4,
> +  ChaCha20-Poly1305, RSA, ECDSA, EdDSA, ECDH, SM2, ML-KEM, ML-DSA,
> +  SLH-DSA, LMS, XMSS, DRBG.
> +
> +properties:
> +  compatible:
> +    const: cri,cmh
> +
> +  reg:
> +    maxItems: 1
> +    description:
> +      SIC (System Interface Controller) MMIO region.  Mailbox instance
> +      registers are at offsets N * 0x1000 within this region.
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 64
> +    description:
> +      Per-mailbox completion/error interrupts from the CryptoManager Hub,
> +      matching the real CMH ch_sys_interrupt_mbx[N-1:0] topology.
> +      Entry i corresponds to MBX instance i.  The driver maps each
> +      configured mailbox (cri,mbx-instances) to its DT interrupt
> +      index and registers a separate threaded IRQ handler per MBX.
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 64
> +    items:
> +      pattern: '^mbx[0-9]+$'
> +    description:
> +      Names for each mailbox interrupt, matching the interrupts array.
> +      Format is "mbxN" where N is the mailbox instance index.
> +
> +  cri,mbx-instances:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 64
> +    description:
> +      Array of 0-based mailbox instance indices to configure.
> +      Each index N maps to register offset N * 0x1000 within the
> +      SIC region.  If absent, defaults to instances 0 and 1.

This property seems like it could be replaced by having a reg entry for
each mailbox.

> +  cri,mbx-slots-log2:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 64
> +    description:
> +      Per-mailbox slot count as log2.  Valid range 1..15.
> +      Array length must match cri,mbx-instances.
> +      Default is 5 (32 slots).

This looks like it should be deducible from a device-specific compatible.

> +
> +  cri,mbx-strides-log2:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 64
> +    description:
> +      Per-mailbox stride (bytes per slot) as log2.  Valid range 7..10.
> +      Array length must match cri,mbx-instances.
> +      Default is 7 (128 bytes per slot).

Ditto here.

> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^(hc|aes|sm4|sm3|hcq|qse|pke|drbg|ccp)@[0-9a-f]+$":
> +    type: object
> +    description:
> +      Per-core-type child nodes.  Each child represents one crypto core
> +      instance available in the hardware.  The driver enumerates these at
> +      probe to discover which algorithm families are present.

This whole subnode thing seems like it is only required because you
don't have device-specific compatibles to deduce what is supported.

> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +        description:
> +          Hardware core ID for this core type (e.g. 0x02 for HC, 0x03 fo=
r AES).
> +          Must match the CORE_ID_* values defined by the CMH hardware.
> +
> +      cri,mbx:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Pin this core instance to a specific mailbox instance index.
> +          Multiple child nodes of the same core type may each specify a
> +          different cri,mbx value to spread instances across mailboxes.
> +          When absent, the driver auto-assigns a mailbox via round-robin
> +          across the instances listed in cri,mbx-instances.

With the mailboxes converted to individual reg entries, this could
probably be handled via reg-names? If the reg name is "aes" or w/e, use
that mailbox for aes only, if it is $something-generic then it's
available for round robin assignment.

pw-bot: changes-requested

Cheers,
Conor.

> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells =3D <2>;
> +        #size-cells =3D <2>;
> +
> +        crypto@a4800000 {
> +            compatible =3D "cri,cmh";
> +            reg =3D <0x0 0xa4800000 0x0 0x41000>;
> +            interrupts =3D <1 2>;
> +            interrupt-names =3D "mbx0", "mbx1";
> +            cri,mbx-instances =3D <0 1>;
> +            cri,mbx-slots-log2 =3D <5 5>;
> +            cri,mbx-strides-log2 =3D <7 7>;
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            hc@2 {
> +                reg =3D <0x02>;
> +            };
> +
> +            aes@3 {
> +                reg =3D <0x03>;
> +            };
> +
> +            sm4@4 {
> +                reg =3D <0x04>;
> +            };
> +
> +            sm3@5 {
> +                reg =3D <0x05>;
> +            };
> +
> +            hcq@8 {
> +                reg =3D <0x08>;
> +            };
> +
> +            qse@9 {
> +                reg =3D <0x09>;
> +            };
> +
> +            pke@a {
> +                reg =3D <0x0a>;
> +                cri,mbx =3D <1>;
> +            };
> +
> +            drbg@f {
> +                reg =3D <0x0f>;
> +            };
> +
> +            ccp@18 {
> +                reg =3D <0x18>;
> +            };
> +        };
> +    };
> +
> +  - |
> +    /* Multi-instance: two AES cores on separate MBXes (future eSW suppo=
rt) */
> +    soc {
> +        #address-cells =3D <2>;
> +        #size-cells =3D <2>;
> +
> +        crypto@a4800000 {
> +            compatible =3D "cri,cmh";
> +            reg =3D <0x0 0xa4800000 0x0 0x41000>;
> +            interrupts =3D <1 2>;
> +            interrupt-names =3D "mbx0", "mbx1";
> +            cri,mbx-instances =3D <0 1>;
> +            cri,mbx-slots-log2 =3D <5 5>;
> +            cri,mbx-strides-log2 =3D <7 7>;
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            hc@2 {
> +                reg =3D <0x02>;
> +            };
> +
> +            aes@3 {
> +                reg =3D <0x03>;
> +                cri,mbx =3D <0>;
> +            };
> +
> +            /* Second AES instance at core ID 0x06, pinned to MBX 1 */
> +            aes@6 {
> +                reg =3D <0x06>;
> +                cri,mbx =3D <1>;
> +            };
> +
> +            pke@a {
> +                reg =3D <0x0a>;
> +                cri,mbx =3D <1>;
> +            };
> +
> +            drbg@f {
> +                reg =3D <0x0f>;
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index 396044f368e7..8b7187ea0194 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -375,6 +375,8 @@ patternProperties:
>      description: Crane Connectivity Solutions
>    "^creative,.*":
>      description: Creative Technology Ltd
> +  "^cri,.*":
> +    description: Cryptography Research, Inc.
>    "^crystalfontz,.*":
>      description: Crystalfontz America, Inc.
>    "^csky,.*":
> --=20
> 2.43.7
>=20

--tVV5lCAGuauPQznU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCalC0JQAKCRB4tDGHoIJi
0lDOAP4lM7VqD2SV+kzpePgkDgsK+A4p1hJGMNL/A0QhQxSjSgD8C+6gZEUcIcPi
73MwrF0YJ8Q/LuZsV0RCYOPYGqMSIAc=
=1fAE
-----END PGP SIGNATURE-----

--tVV5lCAGuauPQznU--

