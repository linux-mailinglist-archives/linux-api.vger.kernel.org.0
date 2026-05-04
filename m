Return-Path: <linux-api+bounces-6265-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFLEKabm+Gkt2wIAu9opvQ
	(envelope-from <linux-api+bounces-6265-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 04 May 2026 20:34:14 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3014C2982
	for <lists+linux-api@lfdr.de>; Mon, 04 May 2026 20:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D72830C4DEF
	for <lists+linux-api@lfdr.de>; Mon,  4 May 2026 18:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6103E9280;
	Mon,  4 May 2026 18:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eh3ZGqst";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0TACS4X"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787483E8C47
	for <linux-api@vger.kernel.org>; Mon,  4 May 2026 18:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919262; cv=none; b=gc0Mvt5xTRaAuAjrFrDnJ5m9yFvH0LudZVEqWgE5l7oiw2rF3xBslEyY88UHEPqLeE8akGhQWY0Xsy/uzvM2kY6JQshBrxk4db/0ONEACKJxp4USPh9vNZQ7v5tM8xlHto0SsmWMP1mu95cuBe3KVq04HmYB3Fb0gdN5Ju3pu9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919262; c=relaxed/simple;
	bh=y/kTyLZ+HlrQ86LL8qEx3AHdGjyMN0oqqtY2orbYvNk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YhJCRzg9xf67gq10pY82Cs/TPNmSxHon8dp+kS8xKUnQYAJfnhDADIPgceocHcxKUo1TbreoUJi4oLrJyhmig/ZlmLCMMlL35RPcqrWsasahzZNRvl86wS+UsbeOIbFgYK25H74SsAL455sL2BEQTjYzApibAtVmVMnMYpydTLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eh3ZGqst; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=X0TACS4X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777919260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QcIoIPVGpy+t+hQB2IAxs25ATlafdN5syK1oi+kQ6lo=;
	b=eh3ZGqstbQlQ8HV1FkIOqgqp+7OPt56i7R8qfEoSmKEAWpujhtlZZOqd/DYgBW56RmU7h+
	9yTECLpJ9YMHUHqZtWOmECqKIxCaBHNkcRI4ktLM+050MlOESUVj060SuDNl12GeVutvFx
	ktoIt7KcvR3EVaesrV9+zPCafj7W1NU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-BVsn4BwEOiSaWnfXjjDASw-1; Mon, 04 May 2026 14:27:21 -0400
X-MC-Unique: BVsn4BwEOiSaWnfXjjDASw-1
X-Mimecast-MFC-AGG-ID: BVsn4BwEOiSaWnfXjjDASw_1777919241
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50d8e8c47a3so124193701cf.0
        for <linux-api@vger.kernel.org>; Mon, 04 May 2026 11:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777919239; x=1778524039; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QcIoIPVGpy+t+hQB2IAxs25ATlafdN5syK1oi+kQ6lo=;
        b=X0TACS4XXf3YLMC+ZSqUzPgih6j7BGfb0qvSALIdbFSgXDcnSq2D+/roChPmKAB2i/
         I9xJTYPXRGwYI9krqrt4HBBkZt1iTt2kuy7+n5nE4y7RW48VgHJC5RRCpBnEFGgGW6Jw
         qvYJ3XN/yC6htjdvm+27ZEePZy/0sx6u4mZGt8KF9dj72Bjip+70Ps1XFczIH7jQHNdu
         rXLWE4L6lKh8kKrA5Fm4OQajZjqFBqOU6/iPZLvmzB3Exzjo19dsWjDQtBpGJ4czXSQX
         uOapTF9697atNxMLgyuiRMPiUj6qJMg5X7WofJaEKn1wx3ZOtGJ5TvtomBXLoUHifK0M
         8cvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777919239; x=1778524039;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QcIoIPVGpy+t+hQB2IAxs25ATlafdN5syK1oi+kQ6lo=;
        b=e6yaFcRGJbQe23QMvUlDvXESQnOQADf5WwHSvkVtos5SZFlqyb6SKOngpL0R5RXNUG
         9KfLclBgN5nc9mTW715zP4EwNsflVVgCmSw1y2qYycv+CJCNWiNdsRgbKzIIP2xh2Mgb
         GpxMk7SGfzaDiPlHPmSEvVrdxtQMrA5VVxlqmxAz+AgxZ6b2zbEcAuR8IFrXs5akDFCl
         ER0cYHdb26OETxgr4BZwLyzONSsXFYxRbQ6oWxRE5oUFp1cdfFtNfwMkNCJeUuAtqkN0
         NEovpfBPYqAjkWuR1crmyGy6Y8A7L5zaQ8wJrXG8BIH8EY8UTvTNMTbbbrgLGxbFLCf2
         RHHA==
X-Forwarded-Encrypted: i=1; AFNElJ+diexjfQBwOvZEql/ZolOuaAG7quomZMgi4lg9YSHnNDYdbR+MMJ2bfC3jSP7BrWX2zO1SEC11XYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnYY+1s7P8gVQx3HeZXYvfeNCjto0h9IqnnEprbMlq5mKjYI19
	PTMVjukv+pIYOATRcVFB2VzGu3Onjam7yr488qd8qUWzrpDRMIQMvkuHSYxCH5un6kIb0lfWwmk
	D1iUeBBjuYjzHRmXc0uMpGG1gim8JVoAtUA/6bo5n2inua8KldIQNwcUtSfDo3w==
X-Gm-Gg: AeBDietDg0O39T7rPPFtVUKYfclRV8lsu3oRBItW6ciSwVhG8Apw7p7PAf0jJqou8XQ
	gUKynp3JZP+7je+6S9d0vk0+q8ZMZD2lVigr4fn6VM02R1S0EHPj7PQiqapwjo1xSREYPx/lz7K
	rKlqNTaWA59tBjx7ZojoUlAv9THHwOGEqRFxkeiQPOvv8RV1C3Ga7qP9xV+yi7xt8IQTqwZ8Orc
	+EY18OlkMIO2ajBk/MzwsT5guBcKnyMOI10w8EIoiokNOSc0IUenhA+bi9vNiq+4fgFQxTjENvQ
	5+/2TYpeAHomF+1H8S7atcHuRQGo0U+Dy7wY67roc29DAOoFOYH/KoAFyKHrslVPy7QpTkxGm7G
	hrA4+TtsYbgocpI4iTv4KMKG6GTA=
X-Received: by 2002:a05:622a:5c09:b0:509:26f4:64e9 with SMTP id d75a77b69052e-5104bfa3385mr199674301cf.51.1777919239169;
        Mon, 04 May 2026 11:27:19 -0700 (PDT)
X-Received: by 2002:a05:622a:5c09:b0:509:26f4:64e9 with SMTP id d75a77b69052e-5104bfa3385mr199673581cf.51.1777919238563;
        Mon, 04 May 2026 11:27:18 -0700 (PDT)
Received: from m8.users.ipa.redhat.com ([2603:7000:9400:fe80::fc6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53ca982a1sm142199276d6.38.2026.05.04.11.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 11:27:18 -0700 (PDT)
Message-ID: <2890ba9558b503c5316f04aed958337455b8f7ad.camel@redhat.com>
Subject: Re: [PATCH] crypto: af_alg - Document the deprecation of AF_ALG
From: Simo Sorce <simo@redhat.com>
To: Jeff Barnes <jeffbarnes@linux.microsoft.com>, Eric Biggers
	 <ebiggers@kernel.org>
Cc: Jon Kohler <jon@nutanix.com>, "linux-crypto@vger.kernel.org"
	 <linux-crypto@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
 "linux-doc@vger.kernel.org"
	 <linux-doc@vger.kernel.org>, "linux-api@vger.kernel.org"
	 <linux-api@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	 <netdev@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 04 May 2026 14:27:16 -0400
In-Reply-To: <F100C726-F841-461B-BE2F-C2018C122426@getmailspring.com>
References: <20260504173952.GA2291@sol>
	 <F100C726-F841-461B-BE2F-C2018C122426@getmailspring.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 1C3014C2982
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6265-lists,linux-api=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simo@redhat.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_EQ_ADDR_SOME(0.00)[]

On Mon, 2026-05-04 at 14:12 -0400, Jeff Barnes wrote:
>=20
> On May 4 2026, at 1:39 pm, Eric Biggers <ebiggers@kernel.org> wrote:
> > =20
> > That seems to be an implementation of FIPS 140-3's integrity self-check=
.
> > A few observations:
> > =20
> > - It could easily use userspace SHA-512 code instead.  If including
> >  libcrypto.so in the "FIPS cryptographic boundary" would cause
> >  certification difficulties, then a sha512.c file could simply be added
> >  to 'libkcapi-hmaccalc' which is already in it.
>=20
> Indeed expanding the crypto boundary to include libcrypto.so would cause
> certification difficulties, it would mean certifying all of libcrypto.so
> with the kernel. There *may* be a case for saying that it is outside the
> module boundary but only if:
>=20
>     * The integrity mechanism is clearly external
>     * The cryptographic module refuses to operate unless integrity is con=
firmed
>     * The trust relationship is clearly documented
>=20
> I don't see how this could be justified cleanly without significant pushb=
ack.
>=20
> > =20
> > - It's compatible with all of the proposed hardening.  It doesn't
> >  require zero-copy performance.  It runs as root, so it would be
> >  compatible with a capability check.  "hmac(sha512)" will need to be on
> >  the algorithm allowlist anyway for iwd.
> > =20
> > - FIPS 140-3 might also allow it to be simplified to use a plain hash
> >  instead of pointlessly using HMAC with a fixed key.
>=20
> FIPS 140=E2=80=913 (via ISO/IEC 19790) draws a hard distinction between:
>     * Integrity checking (cryptographic protection)
>     * Integrity measurement (detection only)
>=20
> A plain hash provides no protection against an attacker who can modify
> both the object and its reference hash.

The integrity mechanism is not build to detect adversarial tampering
(at least at level 1), that is not its purpose.

That said a HMAC is just a hash with a secret key in the mix, it does
not change the conditions wrt Hash if the key is known.

=20
> > By the way, also on the topic of FIPS 140-3, some people do use AF_ALG
> > for ACVP (even though it's not all that great for that purpose, either)=
.
> > But ACVP is a testing thing, not something that is needed on production
> > systems.  ACVP can just be run as root on a testing build; there's no
> > need to enable support for it in the actual production build.
>=20
> Agreed it's not a good use case. Unless/until pkcs1 is supported, I
> don't see how you can use it for all of the test cases. Plus as
> evidenced by Ubuntu's new cert, it requires validating the library.

Of course it requires validating the library, validating the
cryptography implementation is what FIPS is for. libcrypto.so can never
be outside the boundary, unless you turn it off at runtime ...

The problems are rather that libcrypto is not instrumented to enforce
KAT tests are executed before it allows operation (crypto-API did this
via test manager) and does not provide an indicator (or blocks)
unapproved algorithms ...

Simo.

--=20
Simo Sorce
Distinguished Engineer
RHEL Crypto Team
Red Hat, Inc


