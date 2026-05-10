Return-Path: <linux-api+bounces-6292-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IxIIorJAGrLMgEAu9opvQ
	(envelope-from <linux-api+bounces-6292-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sun, 10 May 2026 20:08:10 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0075058CA
	for <lists+linux-api@lfdr.de>; Sun, 10 May 2026 20:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A950300E271
	for <lists+linux-api@lfdr.de>; Sun, 10 May 2026 18:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442B72F6184;
	Sun, 10 May 2026 18:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="xd2nxrE2"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24FC17B50A
	for <linux-api@vger.kernel.org>; Sun, 10 May 2026 18:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778436434; cv=pass; b=Xxl6QXsiMS6NoQVcsKyv4zc6+4bdTxZwfdiyz+X2wb2l51sKuOYe/7N+LYuxigxxqNlwiz8JAa8dHYiuSl910NiMyg/1MzD/KaVNY+IlrydmYSZnzvzUEWQw72bdFVR6a/5/WqglTUv/GRl0ecyD2UyPe1f4IIm4PYhfQ5HpHb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778436434; c=relaxed/simple;
	bh=B/9PkITJMR854+53j7XQJ2o4B0fxddCNlnNjJN0jwA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hz7SKUEk7SyFgXaotuw0LlwP+30W9ip5zgb4ZpUhUhKAsM7yRWsfctspPvkaEY9BxNKntJuRWYQwldxwlr5MME87Wg6FarRWE1YS4M8o+Fuq+DZHH2FszQTJHYMCtpIz+VV5+5+lviKBvBtkbvdQaYh4MMEClM0HtYc+9bXZi5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=xd2nxrE2; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a74ac8b40aso3228546e87.1
        for <linux-api@vger.kernel.org>; Sun, 10 May 2026 11:07:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778436431; cv=none;
        d=google.com; s=arc-20240605;
        b=cmjHfT6aaA8T3l8qUAFbrlNDqexc2BRAPWk+dVXiBLmm/AyiaAqXReLNHxYVVj3Li8
         t9GK77NEdXELcqbFJOG0xNTvyr6qNYpHwrMHfDq3w058DKZU3WRd1ZITWFw1HxQQm9H0
         7T5tENr4NXRXaZfHQFrv/qIJSBXtU7qPyWQoaJRiCHTjsYz03lhPnd2OaB/pMDPNyVw5
         hKiQWPZxGghMOEpZ6uIAsY46s9s4si83Yw3OMu43ByEpBa9qcmMp91pZkqTXxUN/xAhu
         4yAxj9mtHvSrCNJs1K7AQQBTr9j6WGysRyKGBblxHeWS2EYX+jYR99HqB/ZZQtzUFkJf
         Iubg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mPI9RtUtwfMsUB1RLcg9XhbB2p1KI0Jg9PNs9S7CB20=;
        fh=eFa5wkiuRbPVERjDAKrNG2Ie1xwZ6UOoKFzG+Oggsio=;
        b=es57ZHgk0/QhgY/+ANOrz1qDBoRQVuiDKJWPR91Ef9tMqZrNp+mk5hNMoTFArWNgRG
         d1UrT4RUUcuq1kUQbFUZKW1ihBggsGJm9eOK8DMp53SsaqAAkU75P+NskrZqhzL90ff+
         9/37TKlIt2u/H0mXM/SrNh11xJq3qqiFClX6jt9kUb22iCQcbPViqb9PwAsekMnDA638
         uRzCJE7l01U7b5E7IE3kTjW7QU7BssaMphl+ti6Vdp06B9AOAZbYcIQ7hZz/AyCw+F8Y
         n5i9Mo/n0AAv0gIKw30W1mW9322KNH+7s5xRzp5ca4E4D9gPDp5yVLLmT4tiJaig2wMK
         AG6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1778436431; x=1779041231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPI9RtUtwfMsUB1RLcg9XhbB2p1KI0Jg9PNs9S7CB20=;
        b=xd2nxrE2rwAT9XPROHji45Y7YpK9Lj8wqqYVwjTqgaMJz/T1a0pi3r14co3QbcC+DB
         1/4Y3nhJBc0pDjz4bJ5G0wRQXnFdGh+e1UV32hu9+18QbspbZI9ZtapjgRmcIkYmN8/A
         s5i2sZWZaL/7qTGe3cYymFLJtdPu27BfAb9pRJ/kW1s6bvKOSKkPnyd2ENQyI/E2Uxos
         Kb5P+sJVgC8pCMhXtMlV3JppbqSy+KqJa5FFCmFTcYHk9ic8b4HcwLQRQ4JPzTHCVfbx
         i+GCaAWpzUEjVYQU5DwBa3Lb8upX9MEia51MmdOlPKXUUobvN8LcCMrj957XJu6cRCp8
         TXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778436431; x=1779041231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mPI9RtUtwfMsUB1RLcg9XhbB2p1KI0Jg9PNs9S7CB20=;
        b=bArC9tMtX6/Fog3LJ9Rzrh9d/8RbF3z5HtlFLZDpeqRWQDWhwiWjrS28nEivzBxuQz
         FZCJVPQK8nT5Rkn7wHBCLAJy54UCrJLxeQ+CYeC9pPPOeE7TzHK6eLDkLmjPPElRzAfz
         61w6scoUjBCITPeBrax18WNBf2ukJbC8vYmaGgIoHuDw0IMMCbxOPZIcGeMLmBlA+Xc9
         yTcoGkMiuEGkd3RHEBbmdf3765kOKfKywmpbhDFDtC8Fl8Hs9q9lsVd3+vvRc4IGS7a0
         l8kUBCLG1pHqamXD3hTiXfbm9+EH8BQM/mGYCMn92DOEsUXVjNSvDbKu1Es06gMoYvId
         gEiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/tBctyfiOzjEGpoSP5ZfAsGYm/m57rtgR4iFA/YMhRTuroS5OPUJ3vnIJjz5Ueq7Rgr4jX3v9NZ1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyycKGWC1nCsLqhX1svpXnJ5muaN9iC5Aebr31sg9ukwnSagzRi
	GCem6JJgG/+DpVjr2rn0jEg+esPy8nL0KAJDu1Jn9FWnr1IyH3rW0QWwykwwpA3rYIp1xn76moB
	eUlvk7XgSZHZDugLA58vNvBZyPoledusOPmiCy6qt
X-Gm-Gg: Acq92OGy7WX5OxhW1ud/MHNascAzPtTOu7rRmX6whov6K37+f9kd6aAh8W9Hl/gVRNS
	YQfew70aMmvMEYa3yvu5Tpx7oGzWfjGOuGH1BqF6DzjtYB72NMNYzLWjOSlYXq/Iw3MzLIFJM/h
	IKTmkC3kwMjTNfJCRlIi91BzzlZe7tjtZ1OG+i2kXLf+SPIhY5q/EqCuWYIiUSpgSAJCQzTE4Eb
	3MVZ+QaBV7vT8dlYReJ1R0ZJ2U7M/WYtNra0F83t/Ib7H5CVHV72NHAi0tunswtkVh//EcoV1l0
	qaOgb7TzpVvcYzY=
X-Received: by 2002:a05:6512:3e14:b0:5a7:4699:d851 with SMTP id
 2adb3069b0e04-5a8b6c9c530mr1787120e87.7.1778436430400; Sun, 10 May 2026
 11:07:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALCETrVqG+1yErRJjkxvJrf=A+Vu84HTR4Bx1Pcd8G1C0PJcMA@mail.gmail.com>
 <14A441D8-5370-44BE-8732-99BF8107C3FD@getmailspring.com> <0b8bba44-f6bb-4d69-b9d4-5787c276d41a@inspirated.com>
 <20260510163204.GA2279@sol>
In-Reply-To: <20260510163204.GA2279@sol>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sun, 10 May 2026 11:06:57 -0700
X-Gm-Features: AVHnY4Ksn57e9ZSnowz7i8VDuqmEeyTqf3rUkaTOYFnl29-9oyrpMeTvEmcHBgg
Message-ID: <CALCETrVLsFyo71Jk7pZ+VDSR+cX-tu_mD+RdpDe-q1sVw4wisg@mail.gmail.com>
Subject: Re: [PATCH] crypto: af_alg - Document the deprecation of AF_ALG
To: Eric Biggers <ebiggers@kernel.org>
Cc: Kamran Khan <kz@inspirated.com>, Jeff Barnes <jeffbarnes@linux.microsoft.com>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: DC0075058CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[amacapital-net.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[amacapital.net];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-6292-lists,linux-api=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amacapital-net.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@amacapital.net,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amacapital-net.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

On Sun, May 10, 2026 at 9:33=E2=80=AFAM Eric Biggers <ebiggers@kernel.org> =
wrote:

> In any case, any hypothetical security benefit provided by AF_ALG would
> have to be *very high* to outweigh the continuous stream of
> vulnerabilities in it.  I understand that people using AF_ALG might not
> be familiar with that continuous stream of vulnerabilities, but it would
> be worth spending some time researching what has been going on.


It would not be completely crazy to have a simple, straightforward
interface by which user code could ask the kernel to do a
cryptographic operation.  Think:

int compute_keyed_hash(int key_fd, const void *data, size_t len);

where key_fd encodes both the key and the hash type (HMAC-SHA256 or
whatever), and there is a very, very small menu of hashes to choose
from.

But this is not really obviously worth the hassle.  And AF_ALG is
definitely not the right interface.

