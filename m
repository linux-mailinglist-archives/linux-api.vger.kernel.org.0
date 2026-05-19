Return-Path: <linux-api+bounces-6354-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKIGAacXDGrrVwUAu9opvQ
	(envelope-from <linux-api+bounces-6354-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2026 09:56:23 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFD2579819
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2026 09:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A6EA304CFFB
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2026 07:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825113DCDB5;
	Tue, 19 May 2026 07:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b="G4xkTv8p"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88623A6B61
	for <linux-api@vger.kernel.org>; Tue, 19 May 2026 07:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177211; cv=none; b=kRuHeGq/4SmI8+Dxj0Jw0fx0oTYHlrCDXcnTdLTjjBfVIxZimFLhTWGTHMqq8uVczj+1pVKtmbFDCwaU3+zTq0BrYeLqKXATVXA3o/2qL9Y3ms3yz5ltNSCASzhfXpqZpAZkrhvzzqDoTB/v2eHy7L+0+tcXVxAhJmxL7RSjyxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177211; c=relaxed/simple;
	bh=8i4LFYfSf6hdLzUAHOP9OlYZryfxcGXwACWUJi0VIH0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fmQ3vmzwOsRNypSNziLz9SoQV3YJC8TeapUONxob+cuJ7QsMh4mngQ8gZOCgSoog8v0nVYhwX5xoX17IvM5ON4YLlchIrmIK9eaENUv9sEs8ecNbUWuZsRfmcw3v+aSrz4Rgfnuq4stcEhFxAa+wTxKznBjhuaHSvrgdV5zMcxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b=G4xkTv8p; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-365eecc5885so2937566a91.0
        for <linux-api@vger.kernel.org>; Tue, 19 May 2026 00:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20251104.gappssmtp.com; s=20251104; t=1779177209; x=1779782009; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sgzdZP5m+Wyrelk2WxGJY8i5HNRNOV63MQyX9prQSw=;
        b=G4xkTv8pTxAyklB+SHs8DdWbJ23eQ9S4i58YYyxcFgQvub4nZKcLl+Cjfm0UVMOGLR
         5TEN8dOGXlzmnTVL55h7A4umKbHaQLvP4AdhnWCyVWQUStQx2SoBTYUjDCSpGknterHm
         iXX5G8whdy6/4HcrRWmpaj2Aio9mW4T8f1sGFYau0jcj3t/L4f87HZHZGrtK0VC4vtjq
         r83Qh0f2MuZ0pAln4RhCD9V+kgiaTbTSzew+3M3r0wbYbg/RQX3gi50nJCvFshmkyZp/
         kCK6g0TwtzgGumKiUdY1EMElSdl4ZLiv33Y+cNhr619DyuV5ubE9QdkPSHCT8mKE2zwx
         UTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779177209; x=1779782009;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5sgzdZP5m+Wyrelk2WxGJY8i5HNRNOV63MQyX9prQSw=;
        b=ApJ/p85Sanrw91f2KHfOOXO17VDC+SMMZNN/aOKBqbIN6s10IVsZlp8aCdlmhpDJ3V
         m8tcBA8tXo303rZZ5QMgVNkseHY7yDbgePT32AnMb43CrzHq0rEM161gH7NrMxsnuE6A
         APFXM8wytGCN0TfdfXO9SN2RjQNa8RH7VQiTJNINQUV5/xd2eF16uoH1bs7Z/fpj3sws
         NNHshtdZm6Vhb14f5ZvMTZhD8LckUdPl1G85vU9i5eMg7nHqb9s1hjE0kqTuFWLjNGwu
         zQa6JagPyrX5eRMw9SZNyLjcl6bqqMSaxpROhaqDBlipLwnFvkR9PGXm32CrZPyi2Rq6
         5Qsw==
X-Forwarded-Encrypted: i=1; AFNElJ83VsxFQUbHtZQsRUkTcA/tSKSYBXM5i6WGWFoW6PL3y2jhkZLcUGwAHhFV4zsFxdPQXaHxpR88hME=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrDQJfhXhGMmCTKZd+ENbZSvOCuheIFlbyUEDDeocal9fgbizS
	1Mx631Bc/BCzmDUAijTPsEdoGQ29SLjomjqESAJmsbUsBm5NFw4kZJuTIKYdrE2JcOk=
X-Gm-Gg: Acq92OE3wdnOBUI8VJhqjWiwoIy11cDM/It8onH1WRgk3FVb181pYfccfA80V7UR2jV
	MLKpdpO4hBOYb3sXAqdC7WKMwk+uzMR5fNrEdNS11sMDhTELlD+YP17VLooyaqR7JS+7j0+EWfc
	UgxZMAmgllYWoACHfbADTuUNmU38xZP3SVSlF8YsJAUecwNn7wtISejBbZA7L7TBf6HblD32sIR
	lW1VSDh9cx98d7RiZLPEbFriQOl03xT1ltgGRk6KzpAmKfIe5p3l6qWv6j0sCcbZc6+ATL/6YSi
	Yg1LRMQhm0Bxax9wKT+HOc8VCbV9IUNeer2uXjZf19j+/sYMdp3hdR62C6Oqoc0Bxb4YnTj+KSW
	Rt+bdMT4/oOmQsqc6K8fJnLAEHo/8gIeS5oq7LaDstaegCbtXmnXqHSX4a/hyOH5wiZFLpkHh+5
	pkAVNKK+9Zrx8+bhPXiw7C8lgUtQIp0Zy/0jWTDBC8eaxtJ6IZsWVuLY4FrldLwLSuCo4EZ+7Xd
	KSg
X-Received: by 2002:a17:90a:d40d:b0:366:4b0f:d3da with SMTP id 98e67ed59e1d1-36951ca4ee1mr19106356a91.26.1779177209016;
        Tue, 19 May 2026 00:53:29 -0700 (PDT)
Received: from smtpclient.apple (S0106a0ff70715ac6.ek.shawcable.net. [174.0.84.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369f59656a9sm1210242a91.2.2026.05.19.00.53.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2026 00:53:28 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [RFC] fs/ioctl.c: FIBMAP requires CAP_SYS_RAWIO while FIEMAP
 exposes identical data unprivileged
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <20260519033126.GD9531@frogsfrogsfrogs>
Date: Tue, 19 May 2026 01:53:16 -0600
Cc: Andy Lutomirski <luto@amacapital.net>,
 Christoph Hellwig <hch@infradead.org>,
 Cyber_black <Cyberblackk@proton.me>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Mark Fasheh <mark@fasheh.com>,
 Theodore Ts'o <tytso@mit.edu>,
 linux-api@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <53D75B79-7332-4B45-8995-114079CD659B@dilger.ca>
References: <_fcorj7Aa0YnzUmrPnqdEbTjLqS6S7t84HKrzsswvKm71LC0uVmTD2cthCwpgeI-296unEpzPZYBNdFFDXjsQvZRtGfTaQlKmcRkiSI4wiQ=@proton.me>
 <agqevS--YYBVW2Oz@infradead.org> <20260518162048.GC9531@frogsfrogsfrogs>
 <CALCETrUFMFNnJ6FLd9SkzS5E1q3x+cqGvOvo5PzU2V_+moSEJw@mail.gmail.com>
 <20260519033126.GD9531@frogsfrogsfrogs>
To: "Darrick J. Wong" <djwong@kernel.org>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[dilger-ca.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6354-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dilger-ca.20251104.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[dilger.ca];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adilger@dilger.ca,linux-api@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,dilger-ca.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 6BFD2579819
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On May 18, 2026, at 21:31, Darrick J. Wong <djwong@kernel.org> wrote:
>=20
> On Mon, May 18, 2026 at 09:22:42AM -0700, Andy Lutomirski wrote:
>> On Mon, May 18, 2026 at 9:21=E2=80=AFAM Darrick J. Wong =
<djwong@kernel.org> wrote:
>>>=20
>>> On Sun, May 17, 2026 at 10:08:13PM -0700, Christoph Hellwig wrote:
>>>> On Fri, May 15, 2026 at 05:36:45PM +0000, Cyber_black wrote:
>>>>> Option B) Add a capability check to ioctl_fiemap() to match =
FIBMAP.
>>>>> This restores the intended restriction, at the cost of breaking
>>>>> unprivileged use of FIEMAP (e.g. filefrag, btrfs tools, =
e2freefrag).
>>>>> This option is a larger ABI impact and likely undesirable.
>>>>>=20
>>>>> The preferred fix is Option A, since FIEMAP has been available
>>>>> unprivileged since 2008 with no reported security issues, and read
>>>>> access to physical block layout is already implicitly available
>>>>> through open() permission on the file.
>>>>=20
>>>> No, FIEMAP really should not be available unprivileged.  So I think =
B is
>>>> the right thing.  Can you send a proper patch with a proper =
signoff?
>>>=20
>>> For anyone who might be relying on FIEMAP output to find sparse =
regions
>>> -- don't.  FIEMAP is a lowlevel fs debugging interface; it won't =
tell
>>> you about dirty pagecache backed by unwritten disk space.  cp was =
burned
>>> by that a decade and a half ago.
>>>=20
>>=20
>> The only way that I'm personally aware of to determine whether ranges
>> in two files are reflinked to each other (and the only efficient way
>> to find identical blocks to, say, archive a large directory without
>> reading all the contents) is FIEMAP.  I wrote some code to do this
>> awhile back (not in production use).  Yes, I realize that it might
>> have issues with dirty page cache.
>>=20
>> Is there some other way to do this?  Could an API be added that
>> efficiently answers the actual question without revealing information
>> that shouldn't be revealed?
>=20
> Well, yes, we *could* make yet another ioctl, but we could also just =
run
> fe_physical through a one-way u64 hash function and set
> FIEMAP_EXTENT_UNKNOWN if (say) you don't have CAP_SYS_RAWIO or
> something.  Then your comparison function might still work... maybe?
>=20
> OTOH nobody really wants Linus roaring at them, so we might all just =
do
> absolutely nothing.
>=20
> Also note that FIEMAP still doesn't report devices, so you're still
> playing with fire on multi-device reflink-aware filesystems like XFS.

I've long had a patch to add device printing to FIEMAP/filefrag, but =
IIRC
the last time I tried to submit it upstream it was rejected.  Maybe =
times
have changed and there is a chance to get it included.

Cheers, Andreas






