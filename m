Return-Path: <linux-api+bounces-6351-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5enJOgdvC2pXHwUAu9opvQ
	(envelope-from <linux-api+bounces-6351-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2026 21:56:55 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A70457327F
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2026 21:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 432C63030E87
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2026 19:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3D538F629;
	Mon, 18 May 2026 19:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b="KY1xDIx6"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F8326ED41
	for <linux-api@vger.kernel.org>; Mon, 18 May 2026 19:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779133787; cv=none; b=gc9A1VXnO6UGZ8k5KwfQid4+mVBvXQv7cVZnxb7fPyP6hLYfvUBX2HwO53eFeIgloOPmgKdevIvCSJD+oixq1TxnXR0mdFLQ0ih/kfDOGeedr7he3oh6F/kL64cpxWj+DuokKRcv6TKZhOAfGOdf6B7TxKYQkQPRf7bTIlWxgMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779133787; c=relaxed/simple;
	bh=j9kmxjMEOPhqwMBlreKKTmZ9079fBm/XA7Zn+8z7jp4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iORX68TwIU6m/FxS1cgKx9xefUtvM32nmRZ6TomNXDsSVXAdETtoF5l958dgFe1PURiRQj1HOQ3IPeUBQCSeLapfSFiQcEDDyMhyi/mrdESsf3kTuqhZ+jB8ZB8zQI0pUPmu/2FzGF6n3xV4S2lLJNgDfLfcFipK5uTPaJcgMls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b=KY1xDIx6; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-367cbac9c37so1275815a91.2
        for <linux-api@vger.kernel.org>; Mon, 18 May 2026 12:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20251104.gappssmtp.com; s=20251104; t=1779133785; x=1779738585; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXkEizAZd7wRFvVTMvMDw5R0J5iwG2vTUc9MlXWdewk=;
        b=KY1xDIx6CtgEhr/7KLO33NfbrdTcLWk0LBh98DY4twMALrGCX+qiUQv2Lpssn1erkr
         KxLe1VuHkzX+favCDG4l5ISAWuUNfEdVq4uHOciyl6vMgdipdoY9JWDWIl/0ZvJzBe85
         Zd8Cydv569KzijxWSXGznDboroZkgIkzikDjJxF08CK/P+/HVZ3bzj647OEBvVHXJkkt
         xMzleGcgTNcwiGfrya1meg1zAz3cfteR31ZeQukZBzHNXrIvMzVdJ3k7rden/VgAcSSE
         XhDb347nddw3p0lIA0AfOHEB/9qTLdsP3WU8FfFP/i2tciLzt6+7/My58kB4iTNpW4ln
         HFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779133785; x=1779738585;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jXkEizAZd7wRFvVTMvMDw5R0J5iwG2vTUc9MlXWdewk=;
        b=EMPxvs+ncro/NOpDlWFSRf8HJINBzc+/AnD/L2ECIXkFlC4GnO4kHuI9L3HQXv7p2E
         X/b5VURxNjDF3EIv3LefaLaEOjhuSOf9WfBT9F1eBemykG2Sp07ULISYgxC8mghEs1l7
         uyXjfYn6jFEwYzxeei5zdsHm6fSnmZ9omlLvlDV8rq+Di/omGJIC4bKKrY/7I0U7Vf5S
         m3dPXXdtrjKXJe6zCLrvM8Lsuuyv08Y8gF2tRyaJntWqcaaXah/BR2wq2FjVtK73S2O/
         pfFpW+Xd/dbPOGYduiY+C/PeKPC5pf3/1C9wVO/SxyQbtK/TQ6Y3zd/LBj6puFIQd8tK
         ffrQ==
X-Forwarded-Encrypted: i=1; AFNElJ/j4yrMjbbi+FaFSwuarRoDtsD9z14CR9zt8hlg9w+AIZMt2KsedeWsd9a7WgX0TS4Af2GVbWD3hts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ZVdrpSMBb8axEpkhs/xlqPE0iPUjMc8ciZsPuv6rmSL7XP9C
	lv8p3sj2CrimtK87mboN4TbHhBJKIdyHz0MKzTj9uF/zlmfJU7UYKaCT00gY/Di4M1Y=
X-Gm-Gg: Acq92OFDfUc1oiuIXLLZdyEKPB14CWmCv/o+xlR3740YeXDwMQKPprxfej/DDKxYZIt
	hzSNmHl/eTTdbKmGZ1z1Y0hlKe8IfbvMLa3vKX1SjryG6VkhJ1xJG2R6ofIHSsdVL8hQ0K+K4G0
	pMOxpWqB4fA8EjwGiO2ON4O4bq+Uq+sfpRMdjtQyWIpG+Pj1VDerESa/PoWtYT1tLuYK6Ts4S9f
	fJN8pTzn54pyye8LFXDHOnMTnrhys7JBP4rbTNqwVTsuplQwlzk4z7ncz2hXqiGvHlS/k4avfJY
	US/J3QAwIt9MqKOt6JcOOZOsZf4DU4HO5LMT3VTrK47zTz17wYb/h7/bOFGapRsnXhzWMZCs/sW
	v8YW5wfOWJt36DF0yshdabF3DIDp9HWbNrEFp+rkfFvfrl2+CfL9KsDiLgwmcqUytHjPW46Fmng
	/WYSdxRkNa79iXrGlZ40y0WNIQemhN2LyLaWqMKaxh3/YeXVD7yAW+IZUy97DJHkNiPF37K3pxL
	qqUKGuhBPlUz3MQm4fVLTjoVA==
X-Received: by 2002:a17:90b:5904:b0:368:f179:ba07 with SMTP id 98e67ed59e1d1-36951a1cb7dmr16636204a91.9.1779133785138;
        Mon, 18 May 2026 12:49:45 -0700 (PDT)
Received: from smtpclient.apple (S0106a0ff70715ac6.ek.shawcable.net. [174.0.84.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369515895d2sm11637092a91.8.2026.05.18.12.49.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2026 12:49:44 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [5][RFC] fs/ioctl.c: FIBMAP requires CAP_SYS_RAWIO while FIEMAP
 exposes identical data unprivileged
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <-nQmUF-iBsNFQ1Iz2j_cVui7DxnmpAO7z3X7qH8Xzpr7CYXE8j5x5YeFQ39U1wcMFNuVnuxu1pJf7ooiwJYK8ZFJDpjEtifFaBuWNJIi0ak=@proton.me>
Date: Mon, 18 May 2026 13:49:30 -0600
Cc: "luto@amacapital.net" <luto@amacapital.net>,
 "hch@infradead.org" <hch@infradead.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "tytso@mit.edu" <tytso@mit.edu>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
 "djwong@kernel.org" <djwong@kernel.org>,
 "mark@fasheh.com" <mark@fasheh.com>,
 "moybs027@gmail.com" <moybs027@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7FCF68D7-331B-4E8B-9356-F361440764BB@dilger.ca>
References: <-nQmUF-iBsNFQ1Iz2j_cVui7DxnmpAO7z3X7qH8Xzpr7CYXE8j5x5YeFQ39U1wcMFNuVnuxu1pJf7ooiwJYK8ZFJDpjEtifFaBuWNJIi0ak=@proton.me>
To: Cyber_black <Cyberblackk@proton.me>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[dilger-ca.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6351-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[amacapital.net,infradead.org,vger.kernel.org,mit.edu,kernel.org,fasheh.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[dilger.ca];
	DKIM_TRACE(0.00)[dilger-ca.20251104.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adilger@dilger.ca,linux-api@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,dilger-ca.20251104.gappssmtp.com:dkim,proton.me:email]
X-Rspamd-Queue-Id: 4A70457327F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On May 18, 2026, at 11:22, Cyber_black <Cyberblackk@proton.me> wrote:
>=20
> Thank you for raising this important question, Andy. I've been =
following the discussion as a "listening guest" and I have a thought.
>=20
> My idea is this: Instead of forcing FIEMAP to become a root-only =
interface (breaking existing tools), or leaving it as-is (with =
information disclosure), what if we design a new, restricted API that is =
not privileged but also not unprivileged in the traditional sense?

What is the *actual* security risk of showing block numbers to users for =
their own files?

If an attacker can access the underlying device/image, they could =
directly use debugfs
or other filesystem tools to get file->block mappings anyway, and could =
modify the image
arbitrarily.  Restricting FIEMAP to root or obscuring block numbers is =
security through
obscurity and provides no actual safety.

Cheers, Andreas

>=20
> Concretely:
>=20
> 1.  The API would be callable by any user, but it would not expose =
physical block addresses.
>=20
> 2.  It would answer higher-level questions that tools actually need, =
such as:
>=20
>    -   "Are these two file ranges reflinked (shared)?" (for =
deduplication)
>=20
>    -   "Is this file range sparse (holes)?" (without leaking physical =
locations)
>=20
>    -   "What is the allocation status (delayed, unwritten, etc.)?"
>=20
> 3.  The kernel would maintain a capability or permission that is not =
root-equivalent (e.g., a new `CAP_BLOCK_MAP_QUERY`), but the API would =
not require full `CAP_SYS_RAWIO`.
>=20
>=20
> This way:
>=20
> -   Tools like `filefrag`, `cp`, and deduplication utilities can work =
without root.
>=20
> -   Physical block addresses remain hidden from unprivileged users, =
closing the information leak.
>=20
> -   We avoid forcing users to run these tools as root, which would =
open up far more serious risks (e.g., kernel panic, accidental =
corruption).
>=20
>=20
> In short: we don't need to choose between "unprivileged leak" and =
"root-only". We can design a purpose=E2=80=91limited API that answers =
only the necessary questions, with the minimum privilege required.
>=20
> Would this be acceptable? I'd be happy to help draft a more detailed =
proposal or prototype.
>=20
> This idea was developed together with my friend playerofficial19 =
(moybs027@gmail.com) through discussion. We hope it's helpful.
>=20


Cheers, Andreas






